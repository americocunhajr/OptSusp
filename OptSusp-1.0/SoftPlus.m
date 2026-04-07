% -----------------------------------------------------------
% SoftPlus.m
% -----------------------------------------------------------
%  programmer: Americo Cunha Jr
%
%  Originally programmed on: Aug 28, 2025
%           Last updated on: Dec 31, 2025
% -----------------------------------------------------------
% This function returns a smooth approximation of max(0,x)
%
%             y = (1/beta) * log(1 + exp(beta*x))
% 
%   Inputs:
%       x     - scalar, vector, or matrix
%       beta  - positive sharpness parameter (default: 10)
%
%   Output:
%       y     - same size as x
%
%   Notes:
%   - Larger beta makes SoftPlus closer to max(0,x), but 
%     can increase numerical stiffness.
%   - This implementation is numerically stabilized.
% -----------------------------------------------------------
function y = SoftPlus(x, beta)
    if nargin < 2 || isempty(beta)
        beta = 10;
    end
    if beta <= 0
        error('beta must be positive.');
    end

    z = beta .* x;

    % Numerically stable SoftPlus:
    % softplus(z) = log(1+exp(z)) = max(z,0) + log(1+exp(-abs(z)))
    y = (max(z, 0) + log1p(exp(-abs(z)))) ./ beta;
end
% -----------------------------------------------------------