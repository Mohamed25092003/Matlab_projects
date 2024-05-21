function [y] = clipping(Signal, lowerThreshold, upperThreshold)
    % This function clips the amplitude of a signal.
    % Inputs:
    %   inputSignal: The input signal to be clipped.
    %   lowerThreshold: The lower limit of the amplitude.
    %   upperThreshold: The upper limit of the amplitude.
    % Output:
    %   clippedSignal: The signal with clipped amplitude.
    
    % Initialize the clipped signal with the input signal
    y = Signal;
    
    % Find indices where the signal exceeds the upper threshold
    exceedsUpper = y > upperThreshold;
    
    % Set those values to the upper threshold
    y(exceedsUpper) = upperThreshold;
    
    % Find indices where the signal is below the lower threshold
    belowLower = y < lowerThreshold;
    
    % Set those values to the lower threshold
    y(belowLower) = lowerThreshold;
end
