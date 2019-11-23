function [outSig] = sdofBox(inSig,fs,Model_par,n)
	%The SDOF system in the frequency domain
	m=Model_par(1);
	r=Model_par(2);
	s=Model_par(3);
	w0 = sqrt(s/m);
	H = 1/m * 1./(w0^2-w.^2+1i*w*r/m);
	X = fft(inSig);
	Y = H.*X;
	y = ifft(Y, 'symmetric');
	outSig = y(1:size(inSig,1)); % return signal with same length as input
end
