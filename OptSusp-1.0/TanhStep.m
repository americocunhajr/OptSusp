% -----------------------------------------------------------
% TanhStep.m
% -----------------------------------------------------------
%  programmer: Americo Cunha Jr
%
%  Originally programmed on: Aug 28, 2025
%           Last updated on: Dec 31, 2025
% -----------------------------------------------------------
% This function returns a smooth approximation of the Heaviside step
%
%   TanhStep(x) = 0.5 * (1 + tanh(beta*x))
%
%   Inputs:
%       x     - scalar, vector, or matrix
%       beta  - positive sharpness parameter (default: 10)
%
%   Output:
%       y     - same size as x
%
%   Notes:
%   - Larger beta produces a sharper transition.
% -----------------------------------------------------------
function y = TanhStep(x, beta)
    if nargin < 2 || isempty(beta)
        beta = 10;
    end
    if beta <= 0
        error('beta must be positive.');
    end

    y = 0.5 .* (1 + tanh(beta .* x));
end
% -----------------------------------------------------------