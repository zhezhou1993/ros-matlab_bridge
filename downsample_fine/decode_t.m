function point_cloud = decode_t(cell)
    point_cloud = [];
    buff_string  = num2str(cell2mat(cell));
    string = buff_string(1:(size(buff_string,2)-1));
    decode_data = base64decode(string);
%    decode_data(size(decode_data,2)) = [];
    decode_data = reshape(decode_data(1:fix(size(decode_data,2)/4)*4),4,[])';
    
    uint8_data = uint8(decode_data);
    for i = 1 : size(uint8_data,1)
        point_cloud = [point_cloud,typecast(uint8_data(i,:),'single')];
    end
    point_cloud = reshape(point_cloud(1:fix(size(point_cloud,2)/4)*4),4,[])';
    plot3(point_cloud(:,1),point_cloud(:,2),point_cloud(:,3))






end