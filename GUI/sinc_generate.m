function [signal]=sinc_generate(A,shift,t)
      
           
           c=round(((t(1)+t(end))/2)+shift);
           
            signal = A*sinc((t - c));
end
