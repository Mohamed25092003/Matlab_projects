function [y,new_time]=differentiation(x,t,fs)  % get the signal and the time and sample_frequency
y=(fs)*diff(x);  % get the diff of signaland then multiply it to sample frequency 
               % to get the diff with respect of time
new_time=t(2:end); % time reduced because of reducing the signal by one element 
end