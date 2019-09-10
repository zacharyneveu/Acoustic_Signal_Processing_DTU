clear
close all
clc

% Install subfolders 
addpath tools
addpath signals


%% EXERCISE: Aliasing (LECTURE 01, SLIDE 22 - 24)
% �	write a function genChirp.m 
% �	initialize user parameters (e.g. sampling frequency, chirp parameters,
%   decimation factors ... etc)  
% �	create a chirp signal x
% �	downsample x using various decimation factors (D = 1, 2 and 4) and
%   listen to the resulting signals 
% �	preprocess x with an FIR filter (b = fir1(31,0.95/D)) prior to
%   downsampling and listen to the resulting signals
% �	repeat the previous two points using a speech signal


%% USER PARAMETERS
% 
% 
fs = 44100
minf = 100
maxf = 20000


%% CREATE CHIRP SIGNAL
%
%
chrp = dsp.Chirp('SweepDirection', 'Unidirectional',...
    'TargetFrequency', maxf,...
    'InitialFrequency', minf,...
    'TargetTime', 1,...
    'SweepTime', 1,...
    'SamplesPerFrame', 44100,...
    'SampleRate', fs);
    
chrp_data = (step(chrp))';


%% ITERATE ACROSS DECIMATION FACTORS
%  
% 


for i=0:4
    decf = 2^i;
    sound(chrp_data(1:decf:end), fs)
    pause(1)
    % spectrogram(chrp_data(1:decf:end), fs)
end

