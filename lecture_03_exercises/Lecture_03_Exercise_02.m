clear
close all
clc

% Install subfolders
addpath irs
addpath signals
addpath tools


%% EXERCISE: Overlap-save method (LECTURE 03, SLIDE 51)
% •	write a function convolveFFT_OLS.m 
% •	select various BRIRs
% •	process left and right BRIR channels separately
% •	construct a binaural signal by combining the processed left- and right-ear channels
% •	listen to the binaural signal using soundsc()
% •	compare processing speed when using the function convolve (be careful,
%   this will only be possible for relatively short impulse responses) 


%% USER PARAMETERS
% 
% 
% Name of binaural room impulse response (BRIR)
fNameIR = 'church_0.wav';
%fNameIR = 'telephone.wav'
%fNameIR = 'washing_machine.wav'
%fNameIR = 'church_30.wav';
%fNameIR = 'church_270.wav';

% Signal name
%fNameSignal = 'speech@24kHz.wav';
fNameSignal  = 'speech3@24kHz.wav'


%% LOAD SIGNALS
% 
% 
% Read impulse response
[h,fsHz] = readIR(fNameIR);

% Read audio signal (automatically resample input to match the sampling
% frequency of the impulse response)  
x = readAudio(fNameSignal,fsHz);


%% PERFORM CONVOLUTION
% 
% 
% Be careful, h is of dimension [nSamples x 2 channels]
y = convolveFFT_OLS(x,h(:,1), 131072, true);

soundsc(x, fsHz)

pause(numel(x)/fsHz)

soundsc(y, fsHz)
