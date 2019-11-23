clear
close all
clc

% Install subfolders
addpath tools


%% EXERCISE: Linear convolution (LECTURE 03, SLIDE 26)
% •	write a function convolve.m 
% •	verify your output y = convolve(x,h) with the result on slide 24


%% CREATE SIGNALS
% 
% 
% Input signal
x = [1 2 4 1 3];

% Impulse response
h = [2 1 2];


%% PERFORM CONVOLUTION
% 
% 
y = conv(x,h)
yhat = convolve(x,h)

assert(sum(y-yhat)==0, 'Function is broke af')
