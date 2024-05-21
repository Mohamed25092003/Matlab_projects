function signal = poly_generate(coefficients,t)
 % N = input('Enter number of coefficients of the polynomial signal: ');
 % coefficients = zeros(1,length(N));
%{
for i = 1:N
    coefficients(i) = input(['Enter coefficient ', num2str(i), ': ']);%[higher power,....0]
end
%}
 signal=zeros(size(coefficients));
 
for i = 1:length(t)
   poly_value = 0;
   for j = 1:length(coefficients)
      poly_value = poly_value * t(i) + coefficients(j);% Horner's method
   end
   signal(i) = poly_value;
    
end