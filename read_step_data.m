function [step_data] = read_step_data(fid)


step_data=[];
dum_data=[];
step_num=1;
tl=strtrim(fgetl(fid));
data_line=str2num(tl);
step_data=data_line;
while tl ~= -1
         if tl(length(tl)) == ','
            
             tl=strtrim(fgetl(fid));
             data_line=[data_line str2num(tl)];
             step_data(step_num,1:length(data_line))=data_line;
         else
             step_num=step_num+1;
             
             tl=strtrim(fgetl(fid));
             data_line=str2num(tl);
             if isempty(data_line) ~= 1
             step_data(step_num,1:length(data_line))=data_line;
             end
         end    
end
end


