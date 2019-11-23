clear
close all
clc

% Install subfolders
addpath signals
addpath tools

% Reset seed of random generator to guarantee reproducibility
rng(0);


%% USER PARAMETERS
% 
% 
% Sampling frequency
fsHz = 16E3;

% SNR in dB
snrdB = 5;

% Source signal
fileName = 'l01s09.wav';

% Window length
winSec = 32E-3;

% Initial noise-only segment
initSec = 100E-3;

% Smoothing time constant for the decision-direct approach
tauSec = 0.396;

% Gain functions
gain = {...
    'gss'     ,...
    'logmmse' ,...
    };


%% CREATE SIGNALS
% 
% 
% Load source signal
s = readAudio(fileName,fsHz);

% Number of zeros
nZeros = round(initSec*fsHz);

% Zero-pad speech signal
s = cat(1,zeros(nZeros,1),s);

% Create white Gaussian noise
d = randn(size(s));

% Compute scaling factor
[~,~,~,G] = adjustSNR(s(nZeros+1:end),d(nZeros+1:end),snrdB);

% Scale the noise
d = d * G;

% Mix speech with noise
x = s + d;


%% PERFORM NOISE REDUCTION
%
%
% Number of gain functions
nMethods = numel(gain);

% Allocate memory
sHat = zeros(numel(x),nMethods);

% Loop over the number of gain functions
for ii = 1 : numel(gain)
    
    % Perform noise reduction
    sHat(:,ii) = denoise(x,fsHz,winSec,tauSec,initSec,gain{ii});
end


%% LISTEN 
% 
% 
if 0
	soundsc(x,fsHz);
	pause(size(x, 1)/fsHz)
	soundsc(sHat(:,1),fsHz);
	pause(size(sHat, 1)/fsHz)
	soundsc(sHat(:,2),fsHz);
end

addpath ~/Documents/github/SoundZone_Tools

disp('STOI:')
pesq_mex_fast_vec(s, x, fsHz)
pesq_mex_fast_vec(s, sHat(:,1), fsHz)
pesq_mex_fast_vec(s, sHat(:,2), fsHz)
