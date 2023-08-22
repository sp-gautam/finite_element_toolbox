function [Kgprime,rhsprime] = force_and_displacement(time_now,bound,bound_vals,bound_amplitudes, ...
    force,force_vals, force_amplitudes, amplitude_data, Kg)
% modify global stiffness and rhs to account for boundary conditions
% form constraint matrix. this is now coded for simple boundary conditions
% only but can be extended for equation boundary conditions. when equation constraints are 
% included, the code
% should 
% follow Ainsworth, M., 2001. Essential boundary conditions and multi-point constraints in finite element analysis
% Computer Methods in Applied Mechanics and Engineering 190(48):6323-6339
% DOI: 10.1016/S0045-7825(01)00236-5
nsize=length(bound);
rhs=zeros(nsize,1);
g=zeros(nsize,1);
if ~isempty(bound)
for ii = 1:nsize
    if bound(ii) == 1 && bound_amplitudes(ii) ~= 0
       amp_number = bound_amplitudes(ii);
       bound_factors=determine_amplitude(amplitude_data,bound_amplitudes,time_now);
       g(ii) = bound_vals(ii)*bound_factors(amp_number);
    end   
    if bound(ii) == 1 && bound_amplitudes(ii) == 0
       % no amplitude specified, dof value given directly
       g(ii) = bound_vals(ii);
    end  
end    
end
if ~isempty(force)
for ii = 1:nsize
    if force(ii) == 1 && force_amplitudes(ii) ~= 0
       amp_number = force_amplitudes(ii);
       force_factors=determine_amplitude(amplitude_data,force_amplitudes,time_now);
       rhs(ii) = force_vals(ii)*force_factors(amp_number);
    end   
    if force(ii) == 1 && force_amplitudes(ii) == 0
       % no amplitude specified, force given directly
       rhs(ii) = force_vals(ii);
    end  
end 
end
idum=find(bound == 1);
idum2=ones(length(idum),1);
g=bound_vals(idum);
Kshift = zeros(size(Kg,1),1);
for ii=1:length(idum)
Kshift=Kshift + g(ii)*Kg(:,idum(ii));
end
rhs = rhs - Kshift;
rhs(idum) = bound_vals(idum);
Kg(idum,:)=0;
Kg(:,idum)=0;
for ii=1:length(idum)
Kg(idum(ii),idum(ii))=1;
end
% Kg(:,idum)=0;
Kgprime=Kg;
rhsprime=rhs;

