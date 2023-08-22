function [basic_data] = read_basic_data(fid)
max_ndof=6;
max_nmat=100;
tl=fgetl(fid);
data_line=str2num(tl);   
basic_data=[data_line(1:4) max_ndof max_nmat data_line(5)];

end
