clear
close all
clc

% Install subfolders 
addpath tools
addpath signals


%% EXERCISE: Uniform versus nonuniform quantization (LECTURE 01, SLIDE 44)
% •	write the functions compress.m and expand.m 
% •	initialize user parameters (e.g. signal levels, number of bits ... etc)  
% •	implement the signal-to-quantization-noise ratio (SQNR) metric
% •	loop over the number of signal levels and adjust the level of x
% •	for a given signal level, loop over the number of bits
% •	compare uniform and nonuniform quantization using the SQNR metric
% •	plot the SQNR as a function of the signal level for both uniform and
%   nununiform quantization


%% USER PARAMETERS
% 
% 
mu = 256;
bits = [12, 10, 8, 5];
range = [-1, 1];

min_level = -60;
max_level = 10;
levels = min_level:max_level;


%% CREATE SIGNAL
% 
% 
display("Generating signal")
[x, sr] = readAudio('signals/speech@24kHz.wav');
x = x / max(abs(x));


%% PERFORM QUANTIZATION AND SQNR ANALYSIS
% 

snrs_comped = ones(length(bits), length(min_level:max_level));
snrs = ones(length(bits), length(min_level:max_level));

for bit=1:length(bits)
	for lidx=1:length(levels)
		level = levels(lidx);
		xleveled = db2mag(level)*x;

		comped = expand(quantize(compress(xleveled, mu), bits(bit), range), mu);
		uncomped = quantize(xleveled, bits(bit), range);
		snrs_comped(bit, lidx) = SQNR(comped, xleveled);
		snrs(bit, lidx) = SQNR(uncomped, xleveled);
	end
end


%% PLOT RESULTS
% 
% 
figure
title('SQNR vs. Level for \mu law (\mu=512) and uncompressed signals')
hold on
for bit=1:length(bits)
	plot(levels, snrs(bit,:), 'DisplayName', ['Uncomped, Bits: ' num2str(bits(bit))])
	plot(levels, snrs_comped(bit,:), 'DisplayName', ['Comped, Bits: ' num2str(bits(bit))])

end
xlabel('Level (dB)')
ylabel('SQNR')
legend


