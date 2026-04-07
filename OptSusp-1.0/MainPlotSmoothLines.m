clc; clear; close all

x  = linspace(-3,3,600).';
x0 = 0; y0 = 0; m1 = 0.5; m2 = 2.0;
eps_list = [0.001 0.5 1.0];

% Curva original (canto)
y_sharp = y0 + (x < x0).*m1.*(x-x0) + (x >= x0).*m2.*(x-x0);

figure; 
subplot(1,2,1); hold on; plot(x,y_sharp,'k--','DisplayName','sharp');
for eps = eps_list
    y = f_softplus(x,x0,y0,m1,m2,eps);
    plot(x,y);
end
title('Softplus'); grid on; legend show

subplot(1,2,2); hold on; plot(x,y_sharp,'k--','DisplayName','sharp');
for eps = eps_list
    y = f_smoothabs(x,x0,y0,m1,m2,eps);
    plot(x,y);
end
title('Smooth-abs'); grid on; legend show
