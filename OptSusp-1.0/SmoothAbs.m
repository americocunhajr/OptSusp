% -----------------------------------------------------------
% SmoothAbs.m
% -----------------------------------------------------------
%  programmer: Americo Cunha Jr
%
%  Originally programmed on: Dec 31, 2025
%           Last updated on: Dec 31, 2025
% -----------------------------------------------------------
% This function returns a smooth approximation of abs(x)
%
%   SmoothAbs(x) = sqrt(x.^2 + epsAbs^2)
%
%   Inputs:
%       x      - scalar, vector, or matrix
%       epsAbs - positive smoothing parameter (default: 1e-6)
%
%   Output:
%       y      - same size as x
%
%   Notes:
%   - Smaller epsAbs makes SmoothAbs closer to abs(x),
%     but may increase stiffness in gradient-based contexts.
% -----------------------------------------------------------
function y = SmoothAbs(x, epsAbs)
    if nargin < 2 || isempty(epsAbs)
        epsAbs = 1e-6;
    end
    if epsAbs <= 0
        error('epsAbs must be positive.');
    end

    y = sqrt(x.^2 + epsAbs.^2);
end
% -----------------------------------------------------------
