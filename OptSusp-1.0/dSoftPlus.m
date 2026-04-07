% -----------------------------------------------------------
% dSoftPlus.m
% -----------------------------------------------------------
%  programmer: Americo Cunha Jr
%
%  Originally programmed on: Aug 28, 2025
%           Last updated on: Dec 31, 2025
% -----------------------------------------------------------
% This function returns the derivative of SoftPlus(x)
%
%   SoftPlus(x) = (1/beta) * log(1 + exp(beta*x))
%
%   d/dx SoftPlus(x) = 1 / (1 + exp(-beta*x))  (logistic function)
%
%   Inputs:
%       x     - scalar, vector, or matrix
%       beta  - positive sharpness parameter (default: 10)
%
%   Output:
%       dy    - same size as x
%
%   Notes:
%   - This implementation is numerically stabilized using a
%     piecewise logistic evaluation to avoid overflow.
% -----------------------------------------------------------
function dy = dSoftPlus(x, beta)
    if nargin < 2 || isempty(beta)
        beta = 10;
    end
    if beta <= 0
        error('beta must be positive.');
    end

    z = beta .* x;

    % Stable logistic evaluation:
    % sigmoid(z) = 1/(1+exp(-z))
    dy = zeros(size(z));
    idx = (z >= 0);
    dy(idx)  = 1 ./ (1 + exp(-z(idx)));
    ez       = exp(z(~idx));
    dy(~idx) = ez ./ (1 + ez);
end
% -----------------------------------------------------------