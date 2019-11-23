%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% convolve.m
% Written: 2019 Zach Neveu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function y = circonv(x, h)
	%% Convolves signal x with impulse response h
	y = zeros(1, numel(x)+numel(h)-1);
	for n=1:numel(y)
		for m=1:min(n, numel(x))
			y(n) = y(n) + x(m).*h(mod(n-m, numel(h)-1)+1);
		end
	end
end
	

