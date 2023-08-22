function [amp_data] = read_amplitude_data(fid)


amp_data=[];
dum_data=[];
amp_num=1;
tl=strtrim(fgetl(fid));
data_line=str2num(tl);
amp_data=data_line;
while tl ~= -1
         if tl(length(tl)) == ','
            
             tl=strtrim(fgetl(fid));
             data_line=[data_line str2num(tl)];
             amp_data(amp_num,1:length(data_line))=data_line;
         else
             amp_num=amp_num+1;
             
             tl=strtrim(fgetl(fid));
             data_line=str2num(tl);
             if isempty(data_line) ~= 1
             amp_data(amp_num,1:length(data_line))=data_line;
             end
         end    
end
end


