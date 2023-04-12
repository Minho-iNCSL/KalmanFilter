clc; clear; close all;

% Let's start Estimation of constant (person weight)
%
% we have 1,000 data.
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
title('Least square estimation of constant (weight)');
plot(1:1000, 75*ones(1,1000), 'b', 1:1000, y(1:1000), 'r'); hold on; grid on;
plot(1:1000, best_x*ones(1,1000), '--k', 'linewidth',2);
xlabel('data index');
ylabel('weight(kg)');
ylim([50 100]);
legend('Estimated Value', 'Raw Measurement', 'Best Estimation (Least Square)');
