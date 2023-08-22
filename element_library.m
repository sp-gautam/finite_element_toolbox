function [elem_data, active] = element_library(elem_type)
% active dof order u, v, w, rotx, roty, rotz, T
% elem_shapes are 1,2,3,4,5: 1-d line, 2-d triangle, 2-d
% quadrilateral, 3-d tetrahedron, 3-d hexahedron
if elem_type == 1
% elem_type = 1 2-d linear truss element
nodeperelem = 2;
ngauss = 1;
nstress=1;
elem_shape=1;
active = [1 2;1 2];
elseif elem_type == 2
% elem_type = 2 3-d linear truss element
nodeperelem = 2;
ngauss = 2;
nstress=1;
  
elem_shape=1;
active = [1 2 3;1 2 3];
elseif elem_type == 3
% elem_type = 3 2-d beam+truss (frame) element
ndofpernode = 3;
nodeperelem = 2;
ngauss = 1;
nstress=1;
  
elem_shape=1;
active = [1 2 6; 1 2 6];
elseif elem_type == 4
% elem_type = 4 3-d beam element
ndofpernode = 6;
nodeperelem = 2;
ngauss = 3;
ngauss = 0;
nstress=1;
  
elem_shape=1;
active = [1 2 3 4 5 6; 1 2 3 4 5 6];
elseif elem_type == 5
% elem_type = 5 2-d linear triangle T3 for plane strain/plane stress
ndofpernode = 2;
nodeperelem = 3;
ngauss = 1;
nstress=3;
  
elem_shape=2;
active = [1 2;1 2;1 2];
elseif elem_type == 6
% elem_type = 6 2-d quadratic triangle T^
ndofpernode = 2;
nodeperelem = 6;
ngauss = 3;
ngauss = 0;
nstress=1;
  
elem_shape=2;
active = [1 2;1 2;1 2;1 2; 1 2; 1 2];
elseif elem_type == 7
% elem type = 7 2-d linear quadrilateral Q4
ndofpernode = 2;
nodeperelem = 4;
ngauss = 2;
nstress=3;
elem_shape=3;
active = [1 2;1 2;1 2;1 2];
elseif elem_type == 8
% elem type = 8 2-d quadratic quadrilateral
ndofpernode = 2;
nodeperelem = 8;
ngauss = 3;
ngauss = 0;
nstress=1;
  
elem_shape=3;
active = [1 2;1 2;1 2;1 2;1 2;1 2;1 2;1 2];
elseif elem_type == 9
% elem type = 9 3-d linear tetrahedron
ndofpernode = 3;
nodeperelem = 4;
ngauss = 2;
ngauss = 0;
nstress=1;
  
elem_shape=4;
active = [1 2 3;1 2 3;1 2 3;1 2 3];
elseif elem_type == 10
% elem type = 10 3-d linear tetrahedron
ndofpernode = 3;
nodeperelem = 8;
ngauss = 2;
ngauss = 0;
nstress=1;
 ;
elem_shape=4;
active = [1 2 3;1 2 3;1 2 3;1 2 3;1 2 3;1 2 3;1 2 3;1 2 3];
elseif elem_type == 11
% elem type = 11 2-d linear quadrilateral with central pressure node
ndofpernode = 2;
nodeperelem = 5 ;
ngauss = 2;
ngauss = 0;
nstress=1;
elem_shape=3;
active = [1 2;1 2;1 2;1 2;1 0];
% user element type is 12; user element definition starts here
% elseif elem_type == 12
% % elem type = 12 user element 
% ndofpernode = ;
% nodeperelem =  ;
% ngauss = ;
% ngauss = ;
% nstress= ;
% nivar=;
% active = [ ];
% user element definition ends here
end
elem_data=[nodeperelem ngauss nstress elem_shape];

end

