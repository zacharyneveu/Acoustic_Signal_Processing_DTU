function [H1,H2,C,f] = computeFRF(x,y,fsHz,w,R,M)
	assert(size(x,1) == size(y,1))

	[X,t,f] = stft_own(x, fsHz, w, R, M);
	[Y,t,f] = stft_own(y, fsHz, w, R, M);

	X = X(:,1:end-1);
	Y = Y(:,1:end-1);

	XX = mean(X .* conj(X),2);
	YY = mean(Y .* conj(Y),2);
	XY = mean(X .* conj(Y),2);

	H1 = XY ./ XX;
	H2 =YY ./ conj(XY);
	C = abs(XY).^2./(XX.*YY);
end
