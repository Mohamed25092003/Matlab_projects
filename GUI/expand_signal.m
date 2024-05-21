function [y, t_expanded] = expand_signal(x, start, endd, signal, break_points, t, expanding_value)
    t_expanded = linspace(start * expanding_value, endd * expanding_value, length(t) * expanding_value);
    y = zeros(size(t_expanded));

    if length(break_points) + 1 ~= length(signal)
        error('Number of break points should be one less than the number of signals.');
    end

    for i = 1:length(break_points) + 1
        if i == 1
            region_start = start;
        else
            region_start = break_points(i - 1);
        end
        
        if i <= length(break_points)
            region_end = break_points(i);
        else
            region_end = endd;
        end

        region_x = (t >= region_start) & (t <= region_end);
        region_y = (t_expanded >= region_start * expanding_value) & (t_expanded <= region_end * expanding_value);

        % Check the signal type
        signal_type = signal(i);
        
        if signal_type == "Dc"
            y(region_y) = ones(1, sum(region_y)) * mean(x(region_x));
        elseif signal_type == "Ramp"
            % Interpolate the values of x in the region to create a ramp
            region_x_values = x(region_x);
            ramp_values = linspace(region_x_values(1), region_x_values(end), length(x(region_x))*expanding_value);
            disp(length( ramp_values));
            disp("*********");
            disp(length(y(region_y)));
            y(region_y) = ramp_values;
           
            
        else
            % Resample the input signal with the specified expanding value
            y(region_y) = resample(x(region_x), expanding_value, 1);
        end
    end
end
