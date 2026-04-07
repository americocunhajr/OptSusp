% -----------------------------------------------------------
% isoWdFilter.m
% -----------------------------------------------------------
%  programmers: Jose Geraldo Telles Ribeiro
%               Americo Cunha Jr
%
%  Originally programmed in: Aug 28, 2025
%           Last updated in: Aug 28, 2025
% -----------------------------------------------------------
% This function constructs an ISO Wd weighting filter.
%
% Inputs (all must be provided by user):
%   f1  - frequency parameter for high-pass section
%   f2  - frequency parameter for low-pass section
%   f3  - frequency parameter for numerator of Ht
%   f4  - frequency parameter for denominator of Ht
%   f5  - frequency parameter for numerator of Hs
%   f6  - frequency parameter for denominator of Hs
%   Q4  - quality factor for denominator of Ht
%   Q5  - quality factor for numerator of Hs
%   Q6  - quality factor for denominator of Hs
%
% Outputs:
%   Wd : overall transfer function (tf object)
%   H  : struct with fields Hh, Hl, Ht, Hs (each tf object)
% -----------------------------------------------------------
function [Wd, H] = isoWdFilter(f1,f2,f3,f4,f5,f6,Q4,Q5,Q6)

    % Laplace variable
    s = tf('s');

    % High-pass section
    Hh = 1 / ( 1 + sqrt(2)*2*pi*f1/s + (2*pi*f1/s)^2 );

    % Low-pass section
    Hl = 1 / ( 1 + sqrt(2)/(2*pi*f2) + (s/(2*pi*f2)^2) );

    % Band-shaping section
    Ht = ( 1 + 2/(2*pi*f3) ) / ...
         ( 1 + s/(Q4*2*pi*f4) + (s/(2*pi*f4))^2 );

    % Resonance section
    Hs = ( (2*pi*f5)/(2*pi*f6) )^2 * ...
         ( 1 + s/(Q5*2*pi*f5) + (s/(2*pi*f5))^2 ) / ...
         ( 1 + s/(Q6*2*pi*f6) + (s/(2*pi*f6))^2 );

    % Final filter
    Wd = Hh * Hl * Hs * Ht;

    if nargout > 1
        H = struct('Hh',Hh, 'Hl',Hl, 'Ht',Ht, 'Hs',Hs);
    end
end
% -----------------------------------------------------------