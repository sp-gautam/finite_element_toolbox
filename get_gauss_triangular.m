function [xg,yg,zg,weight] = get_gauss_triangular(norder,ndim)
if ndim == 1
  disp('Incorrect Element Shape Used');
end
if ndim == 2
   if norder == 1
     xg=1/3;
     yg=1/3;
     weight = 1/2;
   end
   if norder == 2
       xg=[1/2 0 1/2]';
       yg=[1/2 1/2 0]';
       weight = [1/6 1/6 1/6]';
   end
   if norder == 3
       xg = [1/3 1/5 1/5 3/5]';
       yg = [1/3 1/5 1/5 3/5]';
       weights = [-27/96 25/96 25/96 25/96]';
   end  
   if norder > 3
       disp('Gauss points > 3 not yet coded');
   end    
   zg=zeros(size(xg));
end
if ndim == 3
   disp('Gauss points for tets not yet coded');
end   
   