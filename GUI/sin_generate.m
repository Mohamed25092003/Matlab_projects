function signal=sin_generate(A,f,phi,t)
           % A = input('Enter the amplitude of the sinusoidal signal: ');
           % f = input('Enter the frequency of the sinusoidal signal: ');
           % phi = input('Enter the phase of the sinusoidal signal: ');
            signal = A*sin(2*pi*f*t+ phi);
 end