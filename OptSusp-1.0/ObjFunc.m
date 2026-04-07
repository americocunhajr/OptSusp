% -----------------------------------------------------------
% QuaterCarModel.m
% -----------------------------------------------------------
%  programmers: Jose Geraldo Telles Ribeiro
%               Americo Cunha Jr
%
%  Originally programmed on: Aug 28, 2025
%           Last updated on: Aug 28, 2025
% -----------------------------------------------------------
% This function defines the objective function for the 
% non-convex optimization problem associated with the 
% design of an asymmetric suspension for a car.
% -----------------------------------------------------------
function RMS_Acce_ms = ObjFunc(z,ParamStruct)

    % design variables
    ksi1 = z(1);
    ksi2 = z(2);

    % model hyperparameters
    Wd    = ParamStruct.Wd;
    %mt    = ParamStruct.mt;
    %kt    = ParamStruct.kt;
    ms    = ParamStruct.ms;
    ks    = ParamStruct.ks;
    g     = ParamStruct.g;
    IC    = ParamStruct.IC;
    tspan = ParamStruct.tspan;
    
    % design variables dependent parameters
    cp = 2*ksi1*sqrt(ks*ms);
    cn = 2*ksi2*sqrt(ks*ms);
    
    % update model hyperparameters structure
    ParamStruct.cp = cp;
    ParamStruct.cn = cn;
    
    % integration of the quarter car model dynamics
    [time,x] = ode45(@(t,x)QuarterCarModel(t,x,ParamStruct),tspan,IC);

    % field variables
    x1 = x(:,1);
    x2 = x(:,2);
    x3 = x(:,3);
    x4 = x(:,4);
    
    % number of time steps
    Ndt = length(time);
    
    % suspension mass acceleration RMS
    cs           = 0.5*(cp+cn) + 0.5*(cp-cn)*sign(x4-x2);
    Acce_ms      = (ks/ms)*x1 + (cs/ms).*x2 - (ks/ms)*x3 - (cs/ms).*x4 - g;
    Acce_ms_Wd   = lsim(Wd,Acce_ms,tspan);
    RMS_Acce_ms  = rms(Acce_ms_Wd(Ndt/2+1:Ndt));
end
% -----------------------------------------------------------