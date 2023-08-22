% gauss elimination of a NXN matrix
nsize=size(A,1);
A_aug=[A b];
L=diag(ones(nsize,1));
% go through all columns
for ii = 1:1
% perform pivoting
[dumval,dum_r]=max(A(ii:nsize,ii));
r=dum_r+(ii-1);
A_aug=permute_rows(A_aug,ii,r);
% perform elimination
[A_aug, q_factors]=frobenius(A_aug,ii);
L(ii+1:nsize,ii)=-q_factors';
end
% U=A_aug(:,1:nsize);
% b=A_aug(:,nsize+1);
% y=fwdsub(L,b);
% x=backsub(U,y);