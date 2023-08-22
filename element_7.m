function [Ke, Fe, jacob, stress, strain, ivar, reac] = element_7(material_data, X, disp, stress, ivar, xg,yg,zg,mat_type)
% Q4 element
% analysis_switch = 1: form element stiffness and rhs
Ke(8,8)=0;
Fe(8)=0;
jacob=1;
str0=['getD_' num2str(mat_type)];
D=feval(str0,material_data, X, disp, stress, ivar);
% nodal coordinates
x(1)=X(1); y(1)=X(2);
x(2)=X(4); y(2)=X(5);
x(3)=X(7); y(3)=X(8);
x(4)=X(10);y(4)=X(11);
% shape functions
N(1)=(1/4)*(1+xg)*(1+yg);
N(2) = (1/4)*(1-xg)*(1+yg);
N(3) = (1/4)*(1-xg)*(1-yg);
N(4) = (1/4)*(1+xg)*(1-yg);
% shape function r and s derivatives
dNdr = [(1/4)*(1+yg) -(1/4)*(1+yg) -(1/4)*(1-yg) (1/4)*(1-yg)];
dNds = [(1/4)*(1+xg) (1/4)*(1-xg) -(1/4)*(1-xg) -(1/4)*(1+xg)];
% jacobian
J =[dot(dNdr,x) dot(dNdr, y);dot(dNds,x) dot(dNds,y)];
jacob=det(J);
Gamma=inv(J);
% shape function x and y derivatives
dNdx = [Gamma(1,1)*dNdr(1) + Gamma(1,2)*dNds(1)  Gamma(1,1)*dNdr(2) + Gamma(1,2)*dNds(2)  Gamma(1,1)*dNdr(3) + Gamma(1,2)*dNds(3) ...
    Gamma(1,1)*dNdr(4) + Gamma(1,2)*dNds(4)];
dNdy = [Gamma(2,1)*dNdr(1) + Gamma(2,2)*dNds(1)  Gamma(2,1)*dNdr(2) + Gamma(2,2)*dNds(2)  Gamma(2,1)*dNdr(3) + Gamma(2,2)*dNds(3) ...
    Gamma(2,1)*dNdr(4) + Gamma(2,2)*dNds(4)];
% B matrix
B(1,[1 3 5 7])=dNdx;
B(2,[2 4 6 8])=dNdy;
B(3,[1 3 5 7])=dNdy;
B(3,[2 4 6 8])=dNdx;
Ke = B'*D*B;
strain=B*disp';
stress=D*strain;
reac=B'*stress;
