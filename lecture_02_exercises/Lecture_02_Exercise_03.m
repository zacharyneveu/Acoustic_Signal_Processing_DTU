clear
close all
clc

% Install subfolders
addpath tools
addpath signals


%% EXERCISE: STFT (LECTURE 02, SLIDE 46)
% •	write a function stft.m 
% •	initialize user parameters (sampling frequency, STFT parameters ... etc)
% •	load a signal x (e.g. speech or a linear chirp signal)
% •	visualize the STFT in dB for different window sizes


%% USER PARAMETERS
w = hanning(512);
R = 128;
M = 1024;

%% CREATE SIGNAL
[x, fs] = readAudio('signals/DoYouDareToComputeTheSTFT.wav');

%% STFT
[X,t,f] = stft(x,fs,w,R,M);
Xdb = mag2db(X);
figure
colormap(colormapVoicebox)
image(abs(Xdb))
