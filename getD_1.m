function [D] = getD_1(material_properties, X, disp, stress, ivar)
num_constants=length(material_properties);
material_properties(num_constants+1:3) = 0;
EA=material_properties(1);
EI=material_properties(2);
GJ=material_properties(3);
D = [EA EI GJ];