function [factor_list] = determine_amplitude(amplitude_data,amplitude_list,time_now)
factor_list=zeros(size(amplitude_list));
for ii=1:size(amplitude_data,1)
    time_data = amplitude_data(ii,1:2:size(amplitude_data,2));
    factor_data = amplitude_data(ii,2:2:size(amplitude_data,2));
    factor(ii) = interp1(time_data,factor_data,time_now);
    idum1 = find(amplitude_list == ii);
    factor_list(idum1) = factor(ii); 
end
