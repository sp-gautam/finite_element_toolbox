% script to read fpin.dat file for basic FEM data
fid = fopen('fpin.txt','r');
commandlist={'Basic Data','Nodal Data','Element Data','Material Data',...
    'Force Data','Boundary Data','Amplitude','Node Sets','Element Sets','Step','End'};

echo = ones(100,1);
% all initialisations here
amplitude_data=[];
step_data=[];
force=[];
force_vals=[];
force_amplitudes=[];
bound=[];
bound_vals=[];
bound_amplitudes=[];
while feof(fid) == 0
  tl=fgetl(fid); 
  
  %-----------------------------------------------
  % reading basic data
  %-----------------------------------------------
  if strcmp(commandlist{1}, tl) == 1
   [basic_data] = read_basic_data(fid);
   nnode=basic_data(1);   % number of nodes in the problem
   nelem=basic_data(2);   % number of elements
   nmat=basic_data(3);    % number of material sets
   ndim= basic_data(4);   % space dimension
   max_ndof = basic_data(5); %maxm no of dof per node
   max_nmat = basic_data(6); %maxm no of material property sets
  
  end 
  if echo(1) == 1
  disp(['Solving a ' num2str(ndim) '-dimensional problem']);
  disp(['Defined ' num2str(nnode) ' nodes ' num2str(nelem) ' elements and ' ...
     num2str(nmat) ' Material sets']);
  echo(1)=0;
  end
  %---------------------------------------------------
  % reading all nodal coordinates
  %---------------------------------------------------
  if strcmp(commandlist{2}, tl) == 1
   if echo(2) == 1
   disp('Starting with nodal data');
   echo(2)=0;
   end
   
   coor=zeros(nnode,3);
   [coor] = read_nodal_data(fid, basic_data, coor);
   
   if echo(3) == 1
   disp('Done with nodal data');
   echo(3)=0;
   end
  end 
  
%---------------------------------------------------
% reading all element data
%---------------------------------------------------
  if strcmp(commandlist{3}, tl) == 1
   if echo(4) == 1
   disp('Starting with element data');
   echo(4) = 0;
   end
   [elem_data, connectivity, dest_array] = read_element_data(fid, basic_data, coor);
   
   if echo(5) == 1
   disp('Done reading element data');
   echo(5) = 0;
   end
  end 
  
  

%---------------------------------------------------
% reading material property data
%---------------------------------------------------
  if strcmp(commandlist{4}, tl) == 1
   if echo(6) == 1
   disp('Starting with material property data');
   echo(6) = 0;
   end
   [mat_data] = read_material_data(fid);
   if echo(7) == 1
   disp('Done reading material property data');
   echo(7) = 0;
   end
  end 
%---------------------------------------------------
% reading boundary condition data
%---------------------------------------------------
  if strcmp(commandlist{6}, tl) == 1
   if echo(7) == 1
   disp('Starting with boundary conditions');
   echo(7) = 0;
   end
   [bound,bound_vals,bound_amplitudes]=read_boundary_data(fid, basic_data);
   if echo(8) == 1
   disp('Done reading boundary condition data');
   echo(8) = 0;
   end
  end 
%---------------------------------------------------
% reading force condition data
%---------------------------------------------------
  if strcmp(commandlist{5}, tl) == 1
   if echo(9) == 1
   disp('Starting with external force');
   echo(9) = 0;
   end
   [force,force_vals,force_amplitudes]=read_force_data(fid, basic_data);
   if echo(10) == 1
   disp('Done reading external force data');
   echo(10) = 0;
   end
  end 
%---------------------------------------------------
% reading time amplitude data
%---------------------------------------------------
  if strcmp(commandlist{7}, tl) == 1
   if echo(11) == 1
   disp('Starting with amplitude data');
   echo(11) = 0;
   end
   [amplitude_data]=read_amplitude_data(fid);
   if echo(12) == 1
   disp('Done reading amplitude data');
   echo(12) = 0;
   end
  end 
%---------------------------------------------------
% reading time step data
%---------------------------------------------------
  if strcmp(commandlist{10}, tl) == 1
   if echo(13) == 1
   disp('Starting with step data');
   echo(13) = 0;
   end
   [step_data]=read_step_data(fid);
   tstart=step_data(1);
   tend=step_data(2);
   dt=step_data(3);
   if echo(14) == 1
   disp('Done reading step data');
   echo(14) = 0;
   end
  end 
%---------------------------------------------------
% on encountering End, close input file and proceed for analysis
%---------------------------------------------------
  if strcmp(commandlist{11}, tl) == 1
   
   if echo(15) == 1
   disp('Completed reading input data');
   echo(15) = 0;
   end
   break;
  end 
  
  
% ----------------------------------------------------
% end of while loop. no changes below this.
% ---------------------------------------------------
end  % end while loop
fclose(fid);


   
    
    
    
    
    
