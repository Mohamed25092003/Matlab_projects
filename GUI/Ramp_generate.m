%function to generate RAMP SIGNAL
function[signal]=Ramp_generate(m,b,t)
    % m = input('Enter the (slope) of the ramp signal: ');
    % b = input('Enter the (intercept) of the ramp signal: ');
     signal = m*t + b;%equation of Ramp
end