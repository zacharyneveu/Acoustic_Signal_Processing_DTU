clear
close all
clc

% Install subfolders 
addpath tools
addpath signals


%% EXERCISE: Uniform quantization (LECTURE 01, SLIDE 36)
% �	write a function quantize.m 
% �	initialize user parameters (e.g. number of bits)  
% �	load and normalize a speech signal x such that its maximum is 1
% �	perform quantization 
% �	listen to the quantized signal 


%% USER PARAMETERS
% 
% 
nBits = 12;
range = [-1, 1];



%% CREATE SIGNAL
% 
% 
[a, fs] = readAudio('signals/speech@24kHz.wav');


%% PERFORM QUANTIZATION
%
%

qfloor = quantize(a, nBits, range, "midtread");
q = quantize(a, nBits, range, "midrise");

plot(a(1:100), 'DisplayName', 'True Signal')
hold on
plot(q(1:100), 'DisplayName', 'Midrise')
plot(qfloor(1:100), 'DisplayName', 'Midtread')
legend()

sound(q, fs)
pause(5)
sound(qfloor, fs)
