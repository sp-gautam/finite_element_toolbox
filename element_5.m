function [Ke, Fe, jacob, stress, strain, ivar, reac] = element_5(material_data, X, disp, stress, ivar, xg,yg,zg,mat_type)
% T3 element
% analysis_switch = 1: form element stiffness and rhs
Ke(6,6)=0;
Fe(6)=0;
jacob=1;
str0=['getD_' num2str(mat_type)];
D=feval(str0,material_data, X, disp, stress, ivar);
        % error trap
% nodal coordinates
x(1)=X(1); y(1)=X(2);
x(2)=X(4); y(2)=X(5);
x(3)=X(7); y(3)=X(8);
area=det([1 x(1) y(1);1 x(2) y(2);1 x(3) y(3)]);
% shape functions
N(1)=1 - xg - yg;
N(2) = xg;
N(3) = yg;
% shape function r and s derivatives
dNdr = [-1 1 0];
dNds = [-1 0 1];
% jacobian
J =[dot(dNdr,x) dot(dNdr, y);dot(dNds,x) dot(dNds,y)];
jacob=det(J);
Gamma=inv(J);
% shape function x and y derivatives
dNdx = [Gamma(1,1)*dNdr(1) + Gamma(1,2)*dNds(1)  Gamma(1,1)*dNdr(2) + Gamma(1,2)*dNds(2)  Gamma(1,1)*dNdr(3) + Gamma(1,2)*dNds(3)];
dNdy = [Gamma(2,1)*dNdr(1) + Gamma(2,2)*dNds(1)  Gamma(2,1)*dNdr(2) + Gamma(2,2)*dNds(2)  Gamma(2,1)*dNdr(3) + Gamma(2,2)*dNds(3)];
% B matrix
B(1,[1 3 5])=dNdx;
B(2,[2 4 6])=dNdy;
B(3,[1 3 5])=dNdy;
B(3,[2 4 6])=dNdx;
Ke = B'*D*B;
strain=B*disp';
stress=D*strain;
reac=B'*stress;
