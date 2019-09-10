function outSig = quantize(inSig, nBits, range, qmode)
% Quantizes a signal to the number of bits specified
% using uniform scaling between bits

	if nargin < 4
		qmode = 'midrise';
	end

    delta = (range(2)-range(1))/(2^nBits-1);
    if strcmp(qmode, 'midtread')
        outSig = delta .* floor(inSig/delta + 0.5);
    else
        outSig = delta .* (floor(inSig/delta) + 0.5);
    end        
end

