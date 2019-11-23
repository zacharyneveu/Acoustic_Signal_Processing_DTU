function [X,t,f] = stft_own(x,fs,w,R,M,dR)
%stft   Compute the short-time discrete Fourier transform
%
%USAGE
%   [X,t,f] = stft(x,fs)
%   [X,t,f] = stft(x,fs,w,R,M)
%
%INPUT ARGUMENTS
%    x : input signal [Nx x 1 | 1 x Nx] (x must be a vector)
%   fs : sampling frequency in Hertz
%    w : length-N vector containing the window function [N x 1 | 1 x N]
%        (default, w = hamming(2*round(fs*32E-3/2),'periodic'))
%    R : shift between adjacent windows in samples 
%        (default, R = round(numel(w)/4))
%    M : DFT size, windows are zero-padded if M > N
%        (default, M = pow2(nextpow2(numel(w))))
%    dR: Dynamic range of the stft plot, use only when this function should
%        plot
%
%OUTPUT ARGUMENTS
%   X : complex STFT matrix [M x L]
%   t : time vector in seconds [1 x L]
%   f : frequency vector in Hertz [M x 1]
%
%   stft(...) plots the STFT in a new figure.

%   Developed with Matlab 9.2.0.538062 (R2017a). Please send bug reports to
%
%   Author  :  Tobias May, ? 2017
%              Technical University of Denmark
%              tobmay@elektro.dtu.dk
%
%   History :
%   v.0.1   2017/09/18
%   ***********************************************************************


%% CHECK INPUT ARGUMENTS
%
%
% Check for proper input arguments
if nargin < 2 || nargin > 6
    help(mfilename);
    error('Wrong number of input arguments!')
end

% Set default values
if nargin < 3 || isempty(w)
    % Use a periodic window of length 32 milliseconds
    w = hamming(2*round(fs*32E-3/2),'periodic');
end
if nargin < 4 || isempty(R); R = round(numel(w)/4);        end
if nargin < 5 || isempty(M); M = pow2(nextpow2(numel(w))); end

% Check if input is a vector
if min(size(x)) > 1
    error('Input signal x must be a vector.')
else
    % Ensure x is a colum vector
    x = x(:);
end

% Check if window is a vector
if min(size(w)) > 1
    error('Window function w must be a vector.')
else
    % Ensure w is a colum vector
    w = w(:);% * (length(w) / sum(w)); 
    A = 1/sum(w); 
end

% Window size
N = numel(w);

% Check if M is larger or equal to N
if M < N
    error('DFT size M must be larger or equal to the window size N.')
else
    % Size of zero-padding
    nZeros = M - N;
end

if nargout > 0 && nargin == 6 && ~isempty(dR)
    warning('WARNING: dR only used when no output and this function should plot the data')
elseif nargout < 1 && (nargin < 6 || isempty(dR))
    dR = 150; 
end


%% INITIALIZE PARAMETERS
O = N - R; 
L = ceil((numel(x) - O) / R); 
f = 0:fs/M:fs/2; 
t = (0:R:numel(x) - N)/fs; 

tmp = zeros((O + L*R),1);
tmp(1:numel(x)) = x; 
x = tmp; 

X = zeros(M,L); 

%% FRAME-BASED PROCSESING
for l = 0:L-1
%     tmp = zeros(1,M); 
%     tmp(1:N) = x(R*l+1:R*l+N) .* w; 
      X(:,l+1) = fft(x(R*l+1:R*l+N) .* w,M); 
%     X(:,l+1) = (1/M) * fft(x(R*l+1:R*l+N) .* w,M); 
end


if nargout < 1
    X = X(1:floor(M/2)+1,:) * A; 
    X(2:end-1) = X(2:end-1) * (2); 
    X = 10*log10(abs(X(1:M/2+1,1:length(t))).^2);
    k = find(X == -inf); 
    X(k) = min(X(X > -inf));  
    surf(t,f,X);
    view(0,90); 
    set(gca,'yscale','log','clim',[-abs(dR) inf])
    fLogHz = 2.^(-20:20) * 1E3;
    fLogHz = fLogHz(fLogHz >= f(2) & fLogHz <= fs/2); 
    xlim([min(t) max(t)])
    ylim([0 fs/2])
    set(gca,'ytick',fLogHz,'yticklabel',num2str(fLogHz'))
    xlabel('Time [s]'), ylabel('Frequency [kHz]')
    shading interp
    colorbar
end

end

































