% -----------------------------------------------------------
% QuaterCarModel.m
% -----------------------------------------------------------
%  programmers: Jose Geraldo Telles Ribeiro
%               Americo Cunha Jr
%
%  Originally programmed on: Aug 28, 2025
%           Last updated on: Aug 28, 2025
% -----------------------------------------------------------
% This function defines the evolution equations for a 
% dynamical system that represents a quarter-car model.
% -----------------------------------------------------------
function dxdt = QuarterCarModel(t,x,ParamStruct)
    
    % field variables
    x1 = x(1);
    x2 = x(2);
    x3 = x(3);
    x4 = x(4);

    % model hyperparameters
    tspan = ParamStruct.tspan;
    y     = ParamStruct.y;
    mt    = ParamStruct.mt;
    kt    = ParamStruct.kt;
    ms    = ParamStruct.ms;
    ks    = ParamStruct.ks;
    cp    = ParamStruct.cp;
    cn    = ParamStruct.cn;
    g     = ParamStruct.g;
    
    % base excitation interpolation
    y_t = interp1(tspan,y,t);
    
    % quarter car model evolution equations
    dxdt    = zeros(4,1);
    %cs      = 0.5*(cp+cn) + 0.5*(cp-cn)*sign(x4-x2);
    cs      = m_tanhstep(x4-x2,0.0,cn,cp,0.001);
    kt_eff  = 0.5*kt*(1.0 - sign(x1-y_t));
    dxdt(1) = x2;
    dxdt(2) = (-(kt_eff+ks)*x1-cs*(x2-x4)+ks*x3+kt_eff*y_t)/mt-g;
    dxdt(3) = x4;
    dxdt(4) = (-ks*(x3-x1)+cs*(x2-x4))/ms-g;
end
% -----------------------------------------------------------