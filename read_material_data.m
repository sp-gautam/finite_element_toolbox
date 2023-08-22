function [mat_data] = read_material_data(fid)


mat_data=[];
dum_data=[];
mat_num=1;
tl= strtrim(fgetl(fid));
data_line=str2num(tl);
mat_data=data_line;
while tl ~= -1
         if tl(length(tl)) == ','
            
             tl=strtrim(fgetl(fid));
             data_line=[data_line str2num(tl)];
             mat_data(mat_num,1:length(data_line))=data_line;
         else
             mat_num=mat_num+1;
             
             tl=strtrim(fgetl(fid));
             data_line=str2num(tl);
             if isempty(data_line) ~= 1
             mat_data(mat_num,1:length(data_line))=data_line;
             end
         end    
end
end


