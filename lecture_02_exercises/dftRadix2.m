%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% dftRadix2.m
% Written: 2019 Zach Neveu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [X,w] = dftRadix2(x)
	N = length(x);
	w = 2*pi/N*(0:N-1);
	% assert(rem(log2(N),1) == 0, 'x length Not a power of 2');
	K = 0:N/2;
	Ws = exp(-1j*2*pi/N*K);
	xo = x(2:2:N)
	xe = x(1:2:N)
	Xo = fft(xo);
	Xe = fft(xe);

	Xohat = Xo .* Ws(1:N/2)
	X = zeros(N,1)
	for i=1:N
		if i <= N/2
			X(i) = Xe(i)+Xohat(i);
		else
			X(i) = Xe(i-N/2)-Xohat(i-N/2);
		end
	end
end

