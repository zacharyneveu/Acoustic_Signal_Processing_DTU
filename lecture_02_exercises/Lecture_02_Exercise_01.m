clear
close all
clc

% Install subfolders
addpath tools


%% EXERCISE: DFT (LECTURE 02, SLIDE 17)
% •	write a function dft.m 
% •	write a function idft.m 
% •	write a function genSin.m 
% •	initialize user parameters (e.g. sampling frequency, parameters of the
%   sinusoid ... etc)  
% •	create a sinusoid x with multiple frequency components
% •	compute X = dft(x); and plot its magnitude spectrum in dB
% •	compute y = idft(X); and calculate the RMS between the reconstructed
%   time domain y signal and the original input signal x


%% USER PARAMETERS
fs = 16e3;
T = 0.02;
f0 = [1e3 2e3 5e3];
A0 = [1 1 1];


%% CREATE SIGNAL
% 
% 
[x,t] = genSin(fs, T, f0, A0);
%figure
%plot(t(1:100), x(1:100))

%% FREQUENCY ANALYSIS
% 
% 
[X,w] = dft(x)
figure
plot(w, abs(X))
xr = idft(X)

[Xradix,wRadix] = dftRadix2(x);
figure
plot(w, abs(Xradix))
xr2 = idft(Xradix)

Xfft = fft(x, length(x))
ixfft = ifft(Xfft)

figure
hold on
legend
plot(xr, 'DisplayName', 'Normal DFT')
plot(xr2, 'DisplayName', 'Radix')
plot(x, 'DisplayName', 'Original Signal')
plot(ixfft, 'DisplayName', 'FFT')


% assert(X - Xradix == zeros(1, length(x)))

%% RECONSTRUCT TIME DOMAIN SIGNAL
% 
% 
% xr = idft(X);
%figure
%plot(t(1:100), real(xr(1:100)))
