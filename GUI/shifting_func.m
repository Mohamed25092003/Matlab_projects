function [t] = shifting_func(t_in,time_shift) %get the t of the signal and the shifted time
    %t_shifted is -ve so shifted right 
    %t_shifted is +ve so shifted left 
    t = t_in-time_shift ;
  
end
