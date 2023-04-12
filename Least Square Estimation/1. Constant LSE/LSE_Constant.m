clc; clear; close all;

% Let's start Estimation of constant 
% we have one guy's weight data ( 1,000 data ).
% But scale has random noise.. So how can we decide best estimation of his weight from 1,000 data??
%
% y = measured from digital scale
% x = estimated value, we assume 75kg
%

x = 75; % weight

H = ones(1000,1);

y = H*x; 
% Put some noise
for i=1:1000
    y(i) = y(i) + 2*randn;
end

best_x = inv(H'*H)*H'*y

average = mean(y)

%% plot
plot(1:1000, 75*ones(1,1000), 'b', LineWidth=2); hold on; grid on;
plot(1:1000, y(1:1000), 'r');
plot(1:1000, best_x*ones(1,1000), '--k', 'linewidth',2);
title('Least square estimation of constant (weight)');
xlabel('data index');
ylabel('weight(kg)');
ylim([50 100]);
legend('Estimated Value', 'Raw Measurement', 'Best Estimation (Least Square)');
