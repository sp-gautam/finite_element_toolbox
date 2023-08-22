function [Kg, Fg] = assemble(ielem,element_type,basic_data,elem_destination, Ke,Fe, Kg, Fg)

max_ndof=basic_data(5);
nsize=size(Kg,1);
[ielem_info, active_dof] = element_library(element_type);
nodeperelem = ielem_info(1); % nodes associated with ielem
[JJ,II]=meshgrid(elem_destination,elem_destination);
num_rows=max_ndof*nodeperelem;
Klocal_dum = diag(zeros(num_rows,1));
% find the active dofs
kk=1;
for inode=1:nodeperelem
    start=(inode-1)*max_ndof;
    for jj=1:length(active_dof(inode,:))
       active_dof_dest(kk) = start + active_dof(inode,jj);
       kk=kk+1;
    end
end  
Klocal_dum(active_dof_dest,active_dof_dest)=Ke;    
I=reshape(II,num_rows*num_rows,1);
J=reshape(JJ,num_rows*num_rows,1);
Klocal=reshape(Klocal_dum,num_rows*num_rows,1);
Kg=Kg + sparse(I,J,Klocal,nsize,nsize);
Fg(elem_destination(active_dof_dest)) = Fg(elem_destination(active_dof_dest)) + Fe;



    