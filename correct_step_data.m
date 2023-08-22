function [step_data_modified,num_steps] = correct_step_data(step_data)
% irrespective of user input, step data must be continuous and start from
% zero
num_steps = size(step_data,1);
start_times=step_data(:,1);
end_times=step_data(:,2);
tstep = step_data(:,3);
for ii=1:num_steps
    if ii == 1
        start_times(ii) = 0;
    end
    if ii ~= 1
        start_times(ii) = end_times(ii-1);
    end
    numsteps(ii,1) = (end_times(ii) - start_times(ii))/tstep(ii);
end
step_data_modified=[start_times end_times tstep numsteps];