%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% convolveFFT_OLS.m
% Written: 2019 Zach Neveu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function y=convolveFFT_OLS(x,h,varargin)
	%% Computes a block-based convolution using the Overlap-Save method
	% x: input signal
	% h: impulse response
	% N (optional): block size for FFT
	% bZeroPad (optional): If false, return signal has same length as input
	% 					   If true, x is zero padded to get full length convolution
	if numel(h) > numel(x)
		temp = h;
		h = x;
		x = temp;
	end

	M = numel(h);
	Nx = numel(x);

	if nargin < 3
		bases = ceil(log2(M)):log2(Nx);
		nrange = 2.^bases;
		complexities = ceil(Nx./(nrange-M-1)).*nrange.*(log2(nrange)+1);
		[complexity,N] = min(complexities);
		N = nrange(N)
	else
		N = varargin{1};
	end

	if nargin < 4
		bZeroPad = false;
	else
		bZeroPad = varargin{2};
	end

	L = M+N-1;

	hb = [h; zeros(L-M, 1)];
	Sh = fft(hb, L);
	assert(numel(hb)==L, 'hb not same length as N')

	if bZeroPad == true
		y = zeros(1, L);
		xb = [zeros(M-1,1); x; zeros(M-1,1)];
	else
		y = zeros(1, Nx);
		xb = [zeros(M-1,1);x];
	end

	nblocks = floor((numel(xb)-M) / N);
	for b=1:nblocks
		bl = xb((b-1)*N+1:b*N+M-1);

		assert(numel(bl)==numel(hb), 'hb and bl not same length')

		yb = ifft(fft(bl, L) .* Sh);

		y((b-1)*N+1:b*N) = yb(M:end);
	end
end


