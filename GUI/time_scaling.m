function [new_t]=time_scaling(t)  % get the old time 
t_scale=input("enter the scale of time : "); %enter the scaling_time in all cases
%-ve -->reverse
%+ve --> scale>1 --> compressed
%+ve --> scale<1 --> expanded

new_t=t./t_scale;

    

end
