function [xg,yg,zg,weight] = get_gauss(norder,ndim)
[points,wt]= lgwt(norder,-1,1);
numpoints = norder^ndim;
if ndim == 1
  xg=points;
  weight=wt;
  yg=zeros(size(xg));
  zg=zeros(size(xg));
end
if ndim == 2
   [xdum1,ydum1] = meshgrid(points,points);
   wdum = wt*wt';
   xg=reshape(xdum1,numpoints,1);
   yg=reshape(ydum1,numpoints,1);
   weight=reshape(wdum,numpoints,1);
   zg=zeros(size(xg));
end
if ndim == 3
   [xdum1,ydum1,zdum1] = meshgrid(points,points,points);
   for ii=1:norder
       wdum(:,:,ii)= wt(ii)*((wt*wt').*ones(norder,norder));
   end
   xg=reshape(xdum1,numpoints,1);
   yg=reshape(ydum1,numpoints,1);
   zg=reshape(zdum1,numpoints,1);
   weight=reshape(wdum,numpoints,1);
end   
   