 
initialise;
%--------------------------------------------------------------
% sort step data
%--------------------------------------------------------------
[step_data_modified, numsteps]=correct_step_data(step_data);
for istep = 1:numsteps
    dt = step_data_modified(istep,3);
    start_time=step_data_modified(istep,1);
    num_time_steps=step_data_modified(istep,4);
    str0=['Step number = ' num2str(istep)];
    disp(str0);
for itime = 1:num_time_steps
    
    if istep == 1
        time_now = itime*dt;
    end
    if istep ~= 1
        time_now = start_time + itime*dt;
    end  
    str1=['Time step = ' num2str(itime) ' dt = ' num2str(dt) ' totaltime= ' num2str(time_now)];
    disp(str1);
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
    [elem_info, active_dofs] = element_library(1);
    % initialise element stiffness and rhs
    elem_K =zeros(tot_dof);
    elem_rhs(1:tot_dof)=0;
    
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
    % start loop over gauss points
    for lint = 1:length(weights)
    elem_stress_gp=elem_stress((lint-1)*nstress+1:lint*nstress);
    elem_ivar_gp=elem_ivar((lint-1)*nivar+1:lint*nivar);
    [Ke, rhse, jacob, stress((lint-1)*nstress+1:lint*nstress,ielem), strain((lint-1)*nstress+1:lint*nstress,ielem), ...
        ivar((lint-1)*nivar+1:lint*nivar,ielem), ...
     reac]=feval(str0,elem_material_parameters,elem_X, elem_disp,elem_stress_gp, elem_ivar_gp, ...
        xg(lint),yg(lint),zg(lint),mat_type);
        % error trap
        if size(elem_K,1) ~= tot_dof || size(elem_K,2) ~= tot_dof || length(elem_rhs) ~= tot_dof
        disp(['Element stiffness matrix and load vector must have dimensions of ' num2str(tot_dof) 'X' num2str(tot_dof) ...
            ' and ' num2str(tot_dof) 'X 1 respectively']);
        end
        % end error trap
        elem_K = elem_K + weights(lint)*jacob*Ke;
        elem_rhs = elem_rhs + weights(lint)*jacob*rhse;
    end
    % end loop over gauss points
    elem_destination=dest_array(ielem,:);
    [Kg, Fg]=assemble(ielem,element_type, basic_data, elem_destination, elem_K, elem_rhs, Kg, Fg);
end
% apply boundary condition and assemble nodal forces
time_now=1;
[Kgprime, rhsprime] = force_and_displacement(time_now,bound,bound_vals,bound_amplitudes, ...
    force,force_vals, force_amplitudes, amplitude_data, Kg);
full_solution = solver(Kgprime, rhsprime);
%------------------------------------------------------------------------------------------------------------------
end % end itime
end %istep
