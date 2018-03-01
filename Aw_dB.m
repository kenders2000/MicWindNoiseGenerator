function W_dB = Aw_dB(f)
%
% W_dB = Aw(f)
%
% Evaluates A weighting in dB for each frequency in f
% according to equation in ISO EN 61672-1:2003
 
% constants (section 5.4.11)
f1 = 20.60; % Hz
f2 = 107.7; % Hz
f3 = 737.9; % Hz
f4 = 12194; % Hz
W1000 = (f4.^2) .* (1000.^4) ./ ((1000.^2 + f1.^2) .* sqrt(1000.^2 + f2.^2) .* sqrt(1000.^2 + f3.^2) .* (1000.^2 + f4.^2));

% evaluate A weighting (section 5.4.8, equation 7)
warning off % 0Hz causes a log of zero error
W_dB = 20*log10((f4.^2) .* (f.^4) ./ ((f.^2 + f1.^2) .* sqrt(f.^2 + f2.^2) .* sqrt(f.^2 + f3.^2) .* (f.^2 + f4.^2)) ./ W1000);
warning on

