function [D] = getD_2(material_properties, X, disp, stress, ivar)
num_constants=length(material_properties);
analysis_type=material_properties(1);
E=material_properties(2);
nu=material_properties(3);
if analysis_type == 1
% plane stress case
D = (E/(1-nu^2))*[1 nu 0;nu 1 0;0 0 (1-nu)/2];
end
if analysis_type == 2
% plane strain case
D = (E/((1+nu)*(1-2*nu)))*[1-nu nu 0;nu 1-nu 0;0 0 (1-2*nu)/2];
end
if analysis_type == 3
% axisymmetric case order rr, zz, theta theta, rz
D = (E/((1+nu)*(1-2*nu)))*[1-nu nu nu 0;nu 1-nu nu 0;nu nu 1-nu 0;0 0 0 (1-2*nu)/2];
end
if analysis_type == 4
    disp('Linear elastic 3dcase not yet coded');
end    