% initialisation module. 
trim_data;
nnode=basic_data(1);   % number of nodes in the problem
nelem=basic_data(2);   % number of elements
nmat=basic_data(3);    % number of material sets
ndim= basic_data(4);   % space dimension
max_ndof = basic_data(5); %maxm no of dof per node
max_nmat = basic_data(6); %maxm no of material property sets
anal_type = basic_data(7);
%---------------------------------------------------------------
% initialise all nodal analysis variables
%---------------------------------------------------------------
idum=0:nnode-1;
X(max_ndof*nnode)=0;
X(max_ndof*idum+1) = coor(:,1); X(max_ndof*idum+2) = coor(:,2); X(max_ndof*idum+3) = coor(:,3); %initial nodal coordinates
global_displacement(1:max_ndof*nnode) = 0; % nodal displacement
global_force(1:max_ndof*nnode) = 0;
% ---------------------------------------------------------------
% initialise global stiffness and rhs
%----------------------------------------------------------------
nsize=max_ndof*nnode;
Kg = sparse(nsize,nsize);
Fg(1:nsize)=0;
Freac=zeros(max_ndof*nnode,1);
%---------------------------------------------------------------
% initialise all elemental analysis variables
%---------------------------------------------------------------

for ielem = 1:nelem
    ielem_data=elem_data(ielem,:);
    element_type=ielem_data(1);
    mat_type=ielem_data(2);
    ielem_info=element_library(element_type);
    mat_info = material_library(mat_type);
    nodeperelem = ielem_info(1);
    ngauss = ielem_info(2);
    nstress = ielem_info(3);
    stress(1:(ngauss^ndim)*nstress,ielem)=0;
    nivar = mat_info(2);
    ivar(1:nivar*(ngauss^ndim),ielem) = 0;
end    