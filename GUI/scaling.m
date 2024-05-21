function [y]=scaling(x) %get the signal 
scale=input("Enter the scale value"); %enter the scaling value

y=scale .*x; %multiply every element in the signal with the amplitude f
end
