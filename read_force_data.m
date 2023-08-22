function [force,force_vals,force_amplitudes] = read_force_data(fid,basic_data)
nnode=basic_data(1);   % number of nodes in the problem
nelem=basic_data(2);   % number of elements
nmat=basic_data(3);    % number of material sets
ndim= basic_data(4);
max_ndof = basic_data(5);
force(1:max_ndof*nnode)=0;
force_vals(1:max_ndof*nnode) = 0;
force_amplitudes(1:max_ndof*nnode) = 0;
tl=fgetl(fid);
while tl ~= -1
    data_line=str2num(tl); 
    node_num=data_line(1);
    amp_num=data_line(2);
    dof_min=data_line(3);
    dof_max=data_line(4);
    if dof_min > max_ndof || dof_max > max_ndof
        disp(['Warning: Boundary condition number =' num2str(numbound) ' has illegal dof numbers']);
    end    
    val_dum = data_line(5);
    dum1=dof_min:dof_max;
    dum2=length(dum1);
    dum3= (node_num - 1)*max_ndof;
    dof_nums = dum3*ones(1,dum2) + dum1;
    force(dof_nums)=1;
    force_vals(dof_nums)=val_dum;
    force_amplitudes(dof_nums)=amp_num;
    tl=fgetl(fid);
end


