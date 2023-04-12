clc; clear; close all;

% Let's start Estimation of constant (person weight)
%
% we have 1,000 data.
% y = measured from digital scale
% x = estimated value, we assume 75kg
% 
% noise of measurement is zero-mean and variance is gaussian distribution 
%

x = 75; % weight

H = ones(1000,1);

v = randn(1000,1);

R = diag(v);

y = H*x + v; 

best_x = inv(H'*inv(R)*H)*H'*inv(R)*y;

average = mean(y);

%% plot
plot(1:1000, 75*ones(1,1000), 'b', LineWidth=2); hold on; grid on;
plot(1:1000, y(1:1000), 'r');
plot(1:1000, average*ones(1,1000), 'c', LineWidth=2);
plot(1:1000, best_x*ones(1,1000), '--k', 'linewidth',2);
title('Weighted Least square estimation (weight)');
xlabel('data index');
ylabel('weight(kg)');
legend('Estimated Value', 'Raw Measurement', 'Mean', 'Best Estimation (WLS)');
