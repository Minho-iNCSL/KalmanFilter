clc; clear; close all;

% Let's start Estimation of constant 
% we have one guy's weight data ( 1,000 data ).
% But scale has random noise and different each time because he weighs in 2 scales. 
% even-numbered of v is expensive scale (accuracy) but odd-numbered of v is cheaper scale (inaccuracy) 
% In this case, how can we decide best estimation of his weight from 1,000 data??
%
% we have 1,000 data.
% y = measured from digital scale
% x = estimated value, we assume 75kg
% v = measurement noise
%

x = 75; % weight

H = ones(1000,1);

v = ones(1000,1);
for k=1:1000
    if rem(k,2) == 0
        v(k) = randn(1);
    else
        v(k) = 3*randn(1);
    end
end

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
