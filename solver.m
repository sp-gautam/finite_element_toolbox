function [full_solution] = solver(Kg, rhs)
% prepare for solution
% squeeze out rows and columns that are all zeros
nsize=size(Kg,1);
full_solution=zeros(nsize,1);
non_zero_rows=find(any(Kg,2) == 1);
non_zero_cols=find(any(Kg,1) == 1);
non_zero_both=intersect(non_zero_rows,non_zero_cols);
zero_rows=find(any(Kg,2) == 0);
zero_cols=find(any(Kg,1) == 0);
zero_both=intersect(zero_rows,zero_cols);
Kdum1=Kg(non_zero_both,non_zero_both);
rhsdum1=rhs(non_zero_both);
% solve now
U = inv(Kdum1)*rhsdum1;
% revert to actual dof numbering
full_solution(non_zero_both)=U;