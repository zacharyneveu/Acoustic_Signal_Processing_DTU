%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SQNR.m
% Written: 2019 Zach Neveu
% Computes the Signal-to-Quantization Noise Ratio
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ratio = SQNR(signal, reference)
	ratio = 10*log10(var(signal)/var(signal-reference));
end




