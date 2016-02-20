ad_pub = false ;
first = 1;
subs = true ;
adv = false ;
final = [];
point_cloud = [];
t=tcpip('fetch7',9090);
t.InputBufferSize =640*480*50;
% set(t,'Timeout',1);
fopen(t);
warning('off','MATLAB:serial:fscanf:unsuccessfulRead');
i = 1;
k = 1;
cloud = [];
if ad_pub
    if adv
        data = loadjson(['advertise.json']);
        json_com = savejson('',data);
        fprintf(t,json_com);
    else
        for i= 1:4
            data = loadjson(['publish.json']);
            json_com = savejson('',data);
            fprintf(t,json_com);
            pause(1);
        end
    end
end
if subs
   data = loadjson(['subscribe.json']);
   json_com = savejson('',data);
   fprintf(t,json_com);
   %pause(3)
   while (1)
       if t.BytesAvailable >= 480*640*20
             t.BytesAvailable
             receive = fscanf(t);
             if first == 1
                 [C,matches] = strsplit(receive,{'"'});
                 if size(C,2)>=32
                     length = fix((size(C,2)-32)/31)
                     for j = 1 : 5
                        point_cloud = cat(1,point_cloud,decode_t(C(32+(j-1)*31)));
                     end
                     disp('in');
                     figure(1)
                     plot3(point_cloud(:,1),point_cloud(:,2),point_cloud(:,3))
                     pause(10)
                     k = k+1;
                 end
%                  final = base64decode(num2str(cell2mat(C(32))))
%                  first = 0;
%              else
%                  final = [final, base64decode(receive)];
%                  if (size(final,2) >= 640*480)
%                      cloud(k,:) = final(1:640*480);
%                      k = k+1;
%                  end
             end
%       
       end
%        k=k+1
   end
end
    
    
fclose(t);