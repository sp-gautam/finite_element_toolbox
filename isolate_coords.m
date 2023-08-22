function [dof_to_isolate] = isolate_coords(max_ndof, elem_data, connectivity, ielem)
elem_type=elem_data(ielem,1);
dest_array=create_destination(max_ndof,elem_data, connectivity);
[elem_info active_dof]=element_library(elem_type);
nodeperelem = elem_info(1);
conn = connectivity(ielem,:);
dof_list=[];
idof=1;
for ii=1:nodeperelem
    num_dof = 3;
    for jj=1:num_dof
        dof_list(idof) = (ii-1)*max_ndof + jj;
        idof=idof+1;
    end
end 
destination=dest_array(ielem,:);
dof_to_isolate=destination(dof_list);
