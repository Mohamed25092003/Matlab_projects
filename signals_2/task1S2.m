%_____________________________transmitter________________________________
% Clear workspace and command window
clc;
clear;
% Read and play the sound file
[y,fs] = audioread('example.wav');
% Uncomment the line below if you want to hear the sound
% sound(y,fs);
t = (0:length(y)-1)/fs;

ch_num= size(y);
ch_num= ch_num(2);

% Plot in time domain
figure;
subplot(2,2,[1 2]);
plot(t,y);
xlabel('Time');
ylabel('Amp');
title('Time-Domain');

% Plot in frequency domain
y_fft = fft(y);
y_shifted = fftshift(y_fft);
freq = linspace(-fs/2, fs/2, length(y));

subplot(2,2,3);
plot(freq, abs(y_shifted));
xlabel('Freq');
ylabel('Mag');
title('Freq-Domain Magnitude');

subplot(2,2,4);
plot(freq, angle(y_shifted));
xlabel('Freq');
ylabel('Phase');
title('Freq-Domain Phase');

%_____________________________channel________________________________

% Channel impulse responses

% Ideal impulse function
h1 = [1 zeros(1, length(y)-1)];

% High-frequency attenuation
h2 = exp(-2*pi*5000*t); 
h2 = h2 / norm(h2); % Normalize h2

% Moderate-frequency attenuation
h3 = exp(-2*pi*1000*t); 

% Weighted shifted impulse function
delay_seconds = 0.1; % Delay in seconds for h4
attenuation_factor = 0.5; % Attenuation factor for h4
delay_samples = round(delay_seconds * fs); % Convert delay to samples
h4 = [zeros(1, delay_samples-1) attenuation_factor zeros(1, length(y)-delay_samples)];

% Initialize channel matrices
ch1= zeros(length(y)*2-1,ch_num);
ch2= zeros(length(y)*2-1,ch_num);
ch3= zeros(length(y)*2-1,ch_num);
ch4= zeros(length(y)*2-1,ch_num);

% Apply impulse responses to each channel
for i=1:ch_num
    ch1(:,i)= conv(y(:,i),h1'); % NOTE: convolution must be done on column vectors
    ch2(:,i)= conv(y(:,i),h2');
    ch3(:,i)= conv(y(:,i),h3');
    ch4(:,i)= conv(y(:,i),h4');
end

t_conv= linspace(0,(length(y)/fs)*2,length(y)*2-1);

% Plotting signals after applying channel
figure;
subplot(2,2,1);
plot(t, ch1(1:length(y),:));
xlabel('Time');
ylabel('Amp');
title('After Channel 1');

subplot(2,2,2);
plot(t, ch2(1:length(y),:)); 
xlabel('Time');
ylabel('Amp');
title('After Channel 2 - High Attenuation');

subplot(2,2,3);
plot(t, ch3(1:length(y),:)); 
xlabel('Time');
ylabel('Amp');
title('After Channel 3 - Moderate Attenuation');

subplot(2,2,4);
plot(t, ch4(1:length(y),:));
xlabel('Time');
ylabel('Amp');
title('After Channel 4');
%---------------------------------3.Noise----------------------------------

%generating noise
sigma= input('Enter the value of sigma for noise generation : ');
Z= sigma*randn(1,length(ch1)); %take the length of any channel output

%applying noise
noise_1= ch1+Z';
noise_2= ch2+Z';
noise_3= ch3+Z';
noise_4= ch4+Z';

%plotting with noise
figure;
subplot(2,2,1); plot(t,noise_1(1:length(y),:)); title('Signal on Channel 1 with noise');
subplot(2,2,2); plot(t,noise_2(1:length(y),:)); title('Signal on Channel 2 with noise');
subplot(2,2,3); plot(t,noise_3(1:length(y),:)); title('Signal on Channel 3 with noise');
subplot(2,2,4); plot(t,noise_4(1:length(y),:)); title('Signal on Channel 4 with noise');

%--------------------------------4.Receiver--------------------------------

%transforming to frequancy domain to apply filter
filtered_ch1= fftshift(fft(noise_1(1:length(y),:)));
filtered_ch2= fftshift(fft(noise_2(1:length(y),:)));
filtered_ch3= fftshift(fft(noise_3(1:length(y),:)));
filtered_ch4= fftshift(fft(noise_4(1:length(y),:)));

low_critical_point= -3400;
high_critical_point= 3400;
filter= zeros(size(filtered_ch1)); %take the size of any channel output
filter(freq>-3400,:)= 1;
filter(freq>3400,:)= 0;

%filtering the unwanted frequency in the spectrum
filtered_ch1= filtered_ch1.*filter;
filtered_ch2= filtered_ch2.*filter;
filtered_ch3= filtered_ch3.*filter;
filtered_ch4= filtered_ch4.*filter;

%returning to time domain
filtered_ch1= real(ifft(ifftshift(filtered_ch1)));
filtered_ch2= real(ifft(ifftshift(filtered_ch2)));
filtered_ch3= real(ifft(ifftshift(filtered_ch3)));
filtered_ch4= real(ifft(ifftshift(filtered_ch4)));

%ploting in time domain
figure;
subplot(2,2,1); plot(t,filtered_ch1); title('Filtered signal from channel 1 in time domain');
subplot(2,2,2); plot(t,filtered_ch2); title('Filtered signal from channel 2 in time domain');
subplot(2,2,3); plot(t,filtered_ch3); title('Filtered signal from channel 3 in time domain');
subplot(2,2,4); plot(t,filtered_ch4); title('Filtered signal from channel 4 in time domain');

%ploting in frequancy domain
figure;
subplot(2,2,1); plot(freq,abs(filtered_ch1)); title('filtered signal from channel 1 in frequancy domain');
subplot(2,2,2); plot(freq,abs(filtered_ch2)); title('filtered signal from channel 2 in frequancy domain');
subplot(2,2,3); plot(freq,abs(filtered_ch3)); title('filtered signal from channel 3 in frequancy domain');
subplot(2,2,4); plot(freq,abs(filtered_ch4)); title('filtered signal from channel 4 in frequancy domain');

%play sounds
disp('Now playing filtered signal from channel 1 ...');
sound(filtered_ch1,fs);
pause(length(y)/fs);
disp('Now playing filtered signal from channel 2 ...');
sound(filtered_ch2,fs);
pause(length(y)/fs);
disp('Now playing filtered signal from channel 3 ...');
sound(filtered_ch3,fs);
pause(length(y)/fs);
disp('Now playing filtered signal from channel 4 ...');
sound(filtered_ch4,fs);
pause(length(y)/fs);
