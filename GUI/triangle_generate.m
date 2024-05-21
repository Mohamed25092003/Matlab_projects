function [signal]=triangle_generate(A,c,w,t)
           % A = input('Enter the amplitude of the triangle pulse: ');
            %c = input('Enter the center shift of the triangle pulse: ');
            %w = input('Enter the width of the triangle pulse: ');
           signal =A*tripuls(t-c,w);
end

