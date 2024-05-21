function [y, t_rev] = time_reverse(signal, linspace_start, linspace_end)
 % This function reverses a signal and generates a reversed linspace.

 % Reverse the signal
 y = fliplr(signal);

 % Calculate reversed linspace with exact number of samples
 ts_rev = -1 .* linspace_end; % Reversed starting time (negative of original end)
 tf_rev = -1 .* linspace_start; % Reversed ending time (negative of original start)
 t_rev = linspace(ts_rev, tf_rev, length(y)); % Reversed linspace with exact number of samples

end
