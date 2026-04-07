% -----------------------------------------------------------
% dSmoothAbs.m
% -----------------------------------------------------------
%  programmer: Americo Cunha Jr
%
%  Originally programmed on: Aug 28, 2025
%           Last updated on: Dec 31, 2025
% -----------------------------------------------------------
% This function returns the derivative of SmoothAbs(x)
%
%   SmoothAbs(x) = sqrt(x.^2 + epsAbs^2)
%
%   d/dx SmoothAbs(x) = x / sqrt(x.^2 + epsAbs^2)
%
%   Inputs:
%       x      - scalar, vector, or matrix
%       epsAbs - positive smoothing parameter (default: 1e-6)
%
%   Output:
%       dy     - same size as x
% -----------------------------------------------------------
function dy = dSmoothAbs(x, epsAbs)
    if nargin < 2 || isempty(epsAbs)
        epsAbs = 1e-6;
    end
    if epsAbs <= 0
        error('epsAbs must be positive.');
    end

    denom = sqrt(x.^2 + epsAbs.^2);
    dy = x ./ denom;
end
% -----------------------------------------------------------