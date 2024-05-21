function [y] = Amp_scale(signal, scale_factor)
  % Scales the amplitude of a signal by a given factor.

  % check validity 
  if ~isscalar(scale_factor)
    error('Scale factor must be a scalar value.');
  end

  y = signal .* scale_factor;
end
