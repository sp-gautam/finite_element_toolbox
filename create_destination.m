function [dest] = create_destination(max_ndof, elem_data, connectivity)
% create destination array. destination array is created assuming that
% every element has max_ndof number of dofs per node.
nelem = size(connectivity,1); % total number of elements
for ii=1:nelem
    elem_type=elem_data(ii,1);
    elem_info=element_library(elem_type);
    nodeperelem = elem_info(1);
    conn = connectivity(ii,:);
    idof=1;
    for jj=1:nodeperelem
    for kk=1:max_ndof
      dest(ii,idof) = (conn(jj)-1)*max_ndof + kk;
      idof = idof + 1;
    end
    end
end

