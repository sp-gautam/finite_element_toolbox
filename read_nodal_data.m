function [coor] = read_nodal_data(fid,basic_data, coor)
nnode=basic_data(1);   % number of nodes in the problem
nelem=basic_data(2);   % number of elements
nmat=basic_data(3);    % number of material sets
ndim= basic_data(4);

for ii=1:nnode
    tl=fgetl(fid);
    if ~isempty(tl)
    data_line=str2num(tl);
    % error trap 1
    if length(data_line) < ndim+1
        disp(["Input Error: not enough coordinate values specified for node no "  str2num(ii)]);
    else    
    for jj=1:ndim
        coor(data_line(1),1:ndim) = data_line(2:ndim+1);
    end    
    end
    end
end

