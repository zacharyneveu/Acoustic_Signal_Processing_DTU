%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% stft.m
% Written: 2019 Zach Neveu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [X,t,f] = stft(x,fs,w,R,M)
	%%  x: signal 
	%	fs: sampling frequency
	%	w: window (as samples, not function)
	%	R: Hop size
	%	M: DFT size after zero padding
	N = numel(w);
	L = ceil((numel(x)-N)/ R);
	padded = zeros(1, L*R+N);
	numel(padded)
	padded(1:numel(x)) = x;
	t = 0:L-1 / fs;
	f = 0:M-1;

	X = zeros(M/2, L);
	% Frame Processing
	for frame=0:L-1
		f = padded(R*frame+1:R*frame+N);
		fw = f'.*w;
		res = fft(fw, M);
		X(:,frame+1) = res(M/2+1:end);
	end
end
