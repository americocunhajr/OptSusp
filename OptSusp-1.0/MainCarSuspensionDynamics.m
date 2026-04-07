% -----------------------------------------------------------------
%  MainCarSuspensionDynamics.m
% -----------------------------------------------------------------
%  programmers: Jose Geraldo Telles Ribeiro
%               Americo Cunha Jr
%
%  Originally programmed on: Aug 28, 2025
%           Last updated on: Oct 17, 2025
% -----------------------------------------------------------------
%  This program integrates the dynamics of a quarter-car model 
%  to describe the behavior of the vehicle suspension.
% -----------------------------------------------------------------
%  Reference:
%  J. G. Telles Ribeiro and A. Cunha Jr, Scenario-driven 
%  optimization of passive vehicle suspensions: explaining 
%  the effectiveness of asymmetric damping, 2026
% -----------------------------------------------------------------

clc; clear; close all;

% program header
% -----------------------------------------------------------
disp(' ---------------------------------------------------')
disp(' MainCarSuspensionDynamics.m                        ')
disp(' ---------------------------------------------------')
disp(' Dynamics of an assymetric car suspension           ')
disp('                                                    ')
disp(' by                                                 ')
disp(' José Geraldo Telles Ribeiro                        ')
disp(' Americo Cunha Jr                                   ')
disp(' ---------------------------------------------------')
disp('                                                    ')
% -----------------------------------------------------------

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
fn    = 1.0;                % first natural frequency (Hz)
v     = 5.0;                % car velocity (m/s)
mt    = 40.0;               % tire mass (kg)
kt    = 200.0e3;            % tire stiffness (N/m)
ms    = 250.0;              % suspension mass (kg)
ks    = (2*pi*fn)^2*ms;     % suspension stiffness (N/m)
g     = 9.81;               % gravity acceleration (m/s^2)
xe    = RoadProfile.xe;     % road profile distance (m)
y     = RoadProfile.y;      % road profile heigth (m)
tspan = xe/v;               % temporal mesh (s)
ksi1  = 0.0;                % positive damping factor (-)
ksi2  = 0.0;                % positive damping factor (-)
cp    = 2*ksi1*sqrt(ks*ms); % positive damping coeff. (N/m/s)
cn    = 2*ksi2*sqrt(ks*ms); % negative damping coeff. (N/m/s)
y = sin(tspan);
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
ParamStruct.cp    = cp;
ParamStruct.cn    = cn;
ParamStruct.g     = g;
ParamStruct.y     = y;
ParamStruct.IC    = IC;
ParamStruct.tspan = tspan;
% -----------------------------------------------------------------


% Integration of the quarter car model dynamics
% -----------------------------------------------------------------
[time,x] = ode45(@(t,x)QuarterCarModel(t,x,ParamStruct),tspan,IC);

% field variables
x1 = x(:,1);
x2 = x(:,2);
x3 = x(:,3);
x4 = x(:,4);
    
% number of time steps
Ndt = length(time);
% -----------------------------------------------------------------


% Visualization of the dynamics
% -----------------------------------------------------------------
figure(1)
plot(time,x1)

figure(2)
plot(time,x3)
% -----------------------------------------------------------------
