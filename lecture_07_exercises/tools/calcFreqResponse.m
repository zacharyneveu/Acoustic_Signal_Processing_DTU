function [H,w] = calcFreqResponse(b,a,N_DFT)
    w = linspace(0, pi, N_DFT);
    top = sum(b .* exp(-1j.*w'*(1:size(b,2))), 2);
    bottom = sum(a .* exp(-1j.*w'*(1:size(a,2))), 2);
    H =  top ./ bottom;
end