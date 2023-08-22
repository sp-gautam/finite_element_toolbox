function [elem_data, connectivity, dest_array] = read_element_data(fid,basic_data,coor)
nnode=basic_data(1);   % number of nodes in the problem
nelem=basic_data(2);   % number of elements
nmat=basic_data(3);    % number of material sets
ndim= basic_data(4);
max_ndof=basic_data(5);

for ii=1:nelem
    tl=fgetl(fid);
    if isempty(tl)
        disp("ERROR: Enough element data not entered");
        break;
    end    
    data_line=str2num(tl);  
    elem_no = data_line(1);
    elem_type = data_line(2);
    elem_mat = data_line(3);
    tot_dof=getnumdofs(elem_type);
    elem_data(ii,1:3) = [elem_type elem_mat tot_dof];
    elem_info = element_library(elem_type);
    nodeperelem=elem_info(1);
    connectivity(ii,1:nodeperelem)= data_line(4:3+nodeperelem);
        
    
end
dest_array=create_destination(max_ndof,elem_data, connectivity);

