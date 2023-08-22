function [N,dNdzeta, Nderiv,jacob] = shape_functions_1(X,zeta)
% shape functions N must be stored in a 1 X nodeperelem vector
% jacob is the Jacobian, a scalar
% Nderiv are shape function derivatives with respect to x, y, z and are
% stored as an ndim X nodeperelem matrix. similarly dNdzeta is a
% ndim X nodeperelem matrix containing derivatives wrt zeta, eta
N(1) = 0.5*(1 - zeta);
N(2) = 0.5*(1 + zeta);
jacob=sqrt((X(3)-X(1))^2 + (X(4) - X(2))^2)/2;
dNdzeta(1) = - 0.5;
dNdzeta(2) = 0.5;
dNdx(1) = (1/jacob)*dNdzeta(1);
dNdx(2) = (1/jacob)*dNdzeta(2);
Nderiv = dNdx;
