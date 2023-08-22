function [tot_dof] = getnumdofs(element_num)
[elem_info, active_dofs] = element_library(element_num);
nodeperelem=elem_info(1);
ngauss = elem_info(2); 
nstress = elem_info(3);
tot_dof=0;
for ii=1:nodeperelem
    num_dof_in_node=length(find(active_dofs(ii,:) ~= 0));
    tot_dof=tot_dof+num_dof_in_node;
end    