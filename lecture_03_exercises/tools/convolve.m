%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% convolve.m
% Written: 2019 Zach Neveu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function y = convolve(x, h)
	%% Convolves signal x with impulse response h
	y = zeros(1, numel(x)+numel(h)-1);
	for n=1:numel(y)
		for m=1:min(n, numel(x))
			if(n-m<numel(h))
				y(n) = y(n) + x(m).*h(n-m+1);
			end
		end
	end
end
	

