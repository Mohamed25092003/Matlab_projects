% Function: compress
% Description: This function compresses the input signal 'x' by downsampling it with a specified compressing value.
% Inputs:
%   - x: Input signal
%   - start: Start time of the original signal
%   - endd: End time of the original signal
%   - fs: Sampling frequency of the original signal
%   - compressing_value: Factor by which to compress the signal
% Outputs:
%   - y: Compressed signal
%   - new_time: Time vector corresponding to the compressed signal

function [y, new_time] = compress_signal(x, start, endd, compressing_value)
    % Downsample the input signal with the specified compressing value
    y = downsample(x, compressing_value);
    
    % Generate a new time vector for the compressed signal
    new_time = linspace(start / compressing_value, endd / compressing_value, length(y));
end
