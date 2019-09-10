%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% compress.m
% Written: 2019 Zach Neveu
%
% Performs mu law compression on aray x with compression factor mu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function y = compress(x, mu)
	y = sign(x).*(log(1+mu*abs(x))/log(1+mu));
end

