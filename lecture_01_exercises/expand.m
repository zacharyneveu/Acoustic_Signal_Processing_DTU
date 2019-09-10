%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% expand.m
% Written: 2019 Zach Neveu
%
% Performa mu law expansion on array y with compression factor mu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function x = expand(y, mu)
	x = sign(y).*((1+mu).^abs(y)-1)/mu;
end


