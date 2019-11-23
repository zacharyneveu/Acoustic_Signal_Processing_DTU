%% Clear stuff
clear variables
close all

% Install subfolders
addpath tools


%% EXERCISE: Exponential sweep (LECTURE 04, Slide 21)
%
% (1) Derive the expression for the exponential sweep
% (2) Extend the function genChirp.m to include exponential sweeps
% (3) Create a linear and an exponential chirp
% (4) Compare the two signals in the time, frequency and STFT domain
% w(t) = ae^{bt}
% a = w1
% b = ln(w2/w1)/T

%% USER PARAMETERS
% 
fs = 48000; % Sampling frequency
T = 1; % Sweep duration
f0 = 10; % Start frequency
f1 = fs/2; % Stop frequency
phi0 = 0; % Phase offset

% Select linear or exponential frequency increase
isExp1 = false;
isExp2 = true;


%% CREATE SIGNALS
% 
% Create a linear sweep 
linsig = genChirp(fs, f0, T, f1, phi0, false);

% Create a logarithmic sweep
logsig = genChirp(fs, f0, T, f1, phi0, true);


%% FREQUENCY ANALYSIS
% Calculate the magnitude spectra
linfft = abs(fft(linsig, numel(linsig)));
logfft = abs(fft(logsig, numel(logsig)));

% Calculate the STFTs
linstft = abs(stft(linsig));
logstft = abs(stft(logsig));

%% SHOW RESULTS
% 
% Plot the time-domain signals
figure
subplot(2,2,1)
plot(linsig, 'DisplayName', 'Linear Chirp')
hold on
plot(logsig, 'DisplayName', 'Exponential Chirp')
title('Time Domain')
legend

% Plot the magnitude spectra
subplot(2,2,2)
plot(mag2db(linfft(1:numel(linfft)/2)), 'DisplayName', 'Linear Chirp')
hold on
plot(mag2db(logfft(1:numel(linfft)/2)), 'DisplayName', 'Exponential Chirp')
title('Frequency Domain')
legend

% Plot the STFTs
subplot(2,2,3)
title('Linear Chirp STFT')
%image(linstft)
specgram(linsig)
title('Time-Frequency (Linear)')

subplot(2,2,4)
title('Exponential Chirp STFT')
%image(logstft)
specgram(logsig)
title('Time-Frequency (Exponential)')

