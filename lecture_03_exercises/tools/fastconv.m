%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fastConvolution.m
% Written: 2019 Zach Neveu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function y = fastconv(x,h)
	%% Convolve x with IR h using FFT
	N = numel(x);
	M = numel(h);
	L = N+M-1;
	xb = zeros(1,L);
	hb = zeros(1,L);
	xb(1:N) = x;
	hb(1:M) = h;
	y = ifft(fft(xb,numel(xb)) .* fft(hb, numel(hb)))
end

