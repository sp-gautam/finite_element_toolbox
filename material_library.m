function [mat_data] = material_library(mat_no)
% active dof order u, v, w, rotx, roty, rotz, T
if mat_no == 1
% mat_no = 1, truss beam shaft material, EA, EI, GJ
no_of_parameters = 3;
no_of_ivars=0;
elseif mat_no == 2
% mat_no = 3, isotropic linear elastic material
% 1/2/3/4 (plane stress/plane strain/axisymm/3d), E, nu
no_of_parameters = 3;
no_of_ivars=0;
end
mat_data=[no_of_parameters no_of_ivars];

