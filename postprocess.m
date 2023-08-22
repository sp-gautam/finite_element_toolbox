% postprocessing module. after solution calculate quadrature point
% variables, reactions etc
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
X(max_ndof*idum+1) = coor(:,1); X(max_ndof*idum+2) = coor(:,2); X(max_ndof*idum+3) = coor(:,3); %nodal coordinates
global_displacement(1:max_ndof*nnode) = full_solution; % nodal displacement
global_force(1:max_ndof*nnode) = rhsprime;
% ---------------------------------------------------------------
% initialise global stiffness and rhs
%----------------------------------------------------------------
nsize=max_ndof*nnode;
Freac=zeros(max_ndof*nnode,1);
%---------------------------------------------------------------
% initialise all elemental analysis variables
%---------------------------------------------------------------
%stress = [];
%ivar = [];
for ielem = 1:nelem
    ielem_data=elem_data(ielem,:);
    element_type=ielem_data(1);
    mat_type=ielem_data(2);
    ielem_info=element_library(element_type);
    mat_info = material_library(mat_type);
    nodeperelem = ielem_info(1);
    ngauss = ielem_info(2);
    %nstress = ielem_info(3);
    %stress(1:(ngauss^ndim)*nstress,ielem)=0;
    %nivar = mat_info(2);
    %ivar(1:nivar*ngauss,ielem) = 0;
end    

%---------------------------------------------------------------
% form element stiffness matrices and rhs vectors 
%---------------------------------------------------------------
for ielem=1:nelem
    % fetching all data pertaining to element ielem
    % fetching data from element data
    ielem_data=elem_data(ielem,:); % basic data about ielem from element data
    element_type=ielem_data(1); % element type
    mat_num=ielem_data(2);% number of the material set associated with ielem
    tot_dof=ielem_data(3);% total number of dofs
    ielem_info=element_library(element_type);
    ielem_info=element_library(element_type); % information about element type
    nodeperelem = ielem_info(1); % nodes associated with ielem
    ngauss = ielem_info(2); % order of gauss quadrature
    nstress = ielem_info(3); % number of stress components
    ielem_shape=ielem_info(4); % element shape
    mat_type = mat_data(mat_num,1); % material type for the material number associated with ielem
    mat_info = material_library(mat_type); % basic information about the material type
    num_material_parameters = mat_info(1); %number of parameters in the material model
    elem_material_parameters = mat_data(mat_num,2:num_material_parameters+1); % values of the parameters for ielem
    nivar = mat_info(2); % no of internal variables for ielem
    % fetch element solution variables
    % gauss point variables
    elem_stress = stress(1:nstress*(ngauss^ndim),ielem); %stresses
    elem_ivar = ivar(1:nivar*(ngauss^ndim), ielem); %internal variables
    % nodal variables
    coord_to_isolate=isolate_coords(max_ndof,elem_data,connectivity, ielem);
    [destination,dof_to_isolate] = isolate_elem(max_ndof, elem_data, connectivity, ielem);
    elem_X=X(coord_to_isolate); %nodal positions
    elem_disp=global_displacement(dof_to_isolate); %nodal solution variables
    elem_reac=zeros(tot_dof,1);
    [elem_info, active_dofs] = element_library(1);
    % call element routine
    str0=['element_' num2str(element_type)];
    % get gauss quadrature points for quads and hexs
    if ielem_shape == 1 || ielem_shape == 3 || ielem_shape == 5 
    [xg,yg,zg,weights]=get_gauss(ngauss,ndim);
    end
    % get gauss points for triangles and tets
    if ielem_shape == 2 || ielem_shape == 4
    [xg,yg,zg,weights]=get_gauss_triangular(ngauss,ndim);
    end
    for lint = 1:length(weights)
    elem_stress_gp=elem_stress((lint-1)*nstress+1:lint*nstress);
    elem_ivar_gp=elem_ivar((lint-1)*nivar+1:lint*nivar);
    [Ke, rhse, jacob, stress((lint-1)*nstress+1:lint*nstress,ielem), strain((lint-1)*nstress+1:lint*nstress,ielem), ...
        ivar((lint-1)*nivar+1:lint*nivar,ielem), ...
     reac]=feval(str0,elem_material_parameters,elem_X, elem_disp,elem_stress_gp, elem_ivar_gp, ...
        xg(lint),yg(lint),zg(lint),mat_type);
    elem_reac = elem_reac + weights(lint)*jacob*reac;
    end
    elem_destination=dest_array(ielem,:);
    [dum, Freac]=assemble(ielem, element_type, basic_data, elem_destination, Ke, elem_reac, Kg, Freac);
end

%------------------------------------------------------------------------------------------------------------------

