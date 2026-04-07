% -----------------------------------------------------------
% dTanhStep.m
% -----------------------------------------------------------
%  programmer: Americo Cunha Jr
%
%  Originally programmed on: Dec 31, 2025
%           Last updated on: Dec 31, 2025
% -----------------------------------------------------------
% This function returns the derivative of TanhStep(x)
%
%   TanhStep(x) = 0.5 * (1 + tanh(beta*x))
%
%   d/dx TanhStep(x) = 0.5*beta*sech(beta*x)^2
%
%   Inputs:
%       x     - scalar, vector, or matrix
%       beta  - positive sharpness parameter (default: 10)
%
%   Output:
%       dy    - same size as x
% -----------------------------------------------------------
function dy = dTanhStep(x, beta)
    if nargin < 2 || isempty(beta)
        beta = 10;
    end
    if beta <= 0
        error('beta must be positive.');
    end

    z  = beta .* x;
    dy = 0.5 .* beta .* (sech(z).^2);
end
% -----------------------------------------------------------