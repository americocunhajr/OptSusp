% -----------------------------------------------------------------
%  MainCarSuspensionAssymDesign_DOE.m
% -----------------------------------------------------------------
%  programmers: Jose Geraldo Telles Ribeiro
%               Americo Cunha Jr
%
%  Originally programmed on: Aug 28, 2025
%           Last updated on: Aug 28, 2025
% -----------------------------------------------------------------
%  This program solves a non-convex optimization problem associated
%  with the design of an asymmetric suspension for a car.
% -----------------------------------------------------------------
%  Reference:
%  J. G. Telles Ribeiro and A. Cunha Jr, Scenario-driven 
%  optimization of passive vehicle suspensions: explaining 
%  the effectiveness of asymmetric damping, 2026
% -----------------------------------------------------------------

clc; clear; close all;

% random number generator (fix the seed for reproducibility)
rng_stream = RandStream('mt19937ar','Seed',30081984);
RandStream.setGlobalStream(rng_stream);


% program header
% -----------------------------------------------------------
disp(' ---------------------------------------------------')
disp(' MainCarSuspensionAssymDesign_DOE.m                 ')
disp(' ---------------------------------------------------')
disp(' Optimal design of an assymetric car suspension     ')
disp('                                                    ')
disp(' by                                                 ')
disp(' José Geraldo Telles Ribeiro                        ')
disp(' Americo Cunha Jr                                   ')
disp(' ---------------------------------------------------')
disp('                                                    ')
% -----------------------------------------------------------


% values for design of experiments
% -----------------------------------------------------------------
 v_values = [5 15 30];
fn_values =[1 1.25 1.5 1.75 2];

Nv  = length(v_values);
Nfn = length(fn_values);
% -----------------------------------------------------------------


% run optimization process for the design of experiments values
% -----------------------------------------------------------------
OptDampingPairs = cell(length(v_values)*length(fn_values));

for i=1:Nv
    for j = 1:Nfn
        n    = (i-1)*Nv + j;
        Zopt = OptimizationRoutine(v_values(i),fn_values(j));
        OptDampingPairs(n) = Zopt;
    end
end
% -----------------------------------------------------------------


% -----------------------------------------------------------------
function Zopt = OptimizationRoutine(v,fn)

    % import road profile
    % -----------------------------------------------------------------
    RoadProfile = readtable('RoadProfileB.csv');
    %RoadProfile = readtable('RoadProfileD.csv');
    % -----------------------------------------------------------------

    % create an ISO Wd filter
    % -----------------------------------------------------------------
    freq1 = 0.4;   % frequency parameter for high-pass section
    freq2 = 100;   % frequency parameter for low-pass section
    freq3 = 12.5;  % frequency parameter for numerator of Ht
    freq4 = 12.5;  % frequency parameter for denominator of Ht
    freq5 = 2.37;  % frequency parameter for numerator of Hs
    freq6 = 3.35;  % frequency parameter for denominator of Hs
    Q4    = 0.63;  % quality factor for denominator of Ht
    Q5    = 0.94;  % quality factor for numerator of Hs
    Q6    = 0.91;  % quality factor for denominator of Hs
    
    Wd = isoWdFilter(freq1,freq2,freq3,freq4,freq5,freq6,Q4,Q5,Q6);
    % -----------------------------------------------------------------
    
    % physical parameters 
    % -----------------------------------------------------------------
    %fn    = 1.0;             % first natural frequency (Hz)
    %v     = 5.0;             % car velocity (m/s)
    mt    = 40.0;            % tire mass (kg)
    kt    = 200.0e3;         % tire stiffness (N/m)
    ms    = 250.0;           % suspension mass (kg)
    ks    = (2*pi*fn)^2*ms;  % suspension stiffness (N/m)
    g     = 9.81;            % gravity acceleration (m/s^2)
    xe    = RoadProfile.xe;  % road profile distance (m)
    y     = RoadProfile.y;   % road profile heigth (m)
    tspan = xe/v;            % temporal mesh (s)
    % -----------------------------------------------------------------

    % initial conditions
    % -----------------------------------------------------------------
    xt0 = -(ms+mt)*g/kt;
    xs0 = -ms*g/ks - (ms+mt)*g/kt;
    IC  = [xt0; 0; xs0; 0];
    % -----------------------------------------------------------------
    
    % model hyperparameters structure
    % -----------------------------------------------------------------
    ParamStruct.Wd    = Wd;
    ParamStruct.fn    = fn;
    ParamStruct.v     = v;
    ParamStruct.mt    = mt;
    ParamStruct.kt    = kt;
    ParamStruct.ms    = ms;
    ParamStruct.ks    = ks;
    ParamStruct.g     = g;
    ParamStruct.y     = y;
    ParamStruct.IC    = IC;
    ParamStruct.tspan = tspan;
    % -----------------------------------------------------------------
    
    % Cross-entropy (CE) method parameters (modify as needed)
    % -----------------------------------------------------------------
    CEstr.Verbose      = true;     % Elite samples percentage
    CEstr.EliteFactor  = 0.1;     % Elite samples percentage
    CEstr.Nsamp        = 50;      % Number of samples
    CEstr.MaxIter      = 80;      % Maximum of iterations
    CEstr.TolAbs       = 1.0e-2;  % Absolute tolerance
    CEstr.TolRel       = 1.0e-2;  % Relative tolerance
    % -----------------------------------------------------------------
    
     % design parameters (fn, ksi1, ksi2) bounds, mean and std. dev.
     % -----------------------------------------------------------------
    lb     = [0.0; 0.0];
    ub     = [1.0; 1.0];
    %mu0    = [0.4; 0.4];
    %sigma0 = [0.1; 0.1];
    % -----------------------------------------------------------------
    
    % Misfit function between experimental data and model prediction
    % -----------------------------------------------------------------
    J = @(z) ObjFunc(z,ParamStruct);
    % -----------------------------------------------------------------
    
    % Run the optimization using the CE method
    % "Since CE is a stochastic algorithm, different results 
    % will be obtained each execution of the solver."
    % -----------------------------------------------------------------
    disp('Running the optimization using cross-entropy method...');
    
    tic
    [Zopt,Fopt,ExitFlag,CEstr] = CEopt(J,[],[],lb,ub,[],CEstr);
    toc
    % -----------------------------------------------------------------
end
% -----------------------------------------------------------------