clc; clear; close all;

% Suppose that a tank contains a concentration x1 and x2 liquid.
% We can detect the combined concentration of two liquid (x1+x2)
% but, our sensor cannot distinguish between the two liquild
%
% x2 is removed from the tank through a leaching process.
% so that its concentration decreases by 1% from one measurement 
% time to the next
%
% The measurement equation is given below
%
% yk = x1 + 0.99^(k-1)x2 + vk
%
% Suppose that, x1 = 10, x2 = 5,
% Further our initial estimate are hat{x1} = 8, and hat{x2} = 7
% with an initial estimation-error variance P0 = I.

n_step = 50;
x1 = 10; x2 = 5;
hat_x1 = 8; hat_x2 = 7;

R = 0.01;

x = [x1 x2]';

x_est = zeros(2,n_step);
x_est(:,1) = [hat_x1 hat_x2]'; 

P = [1 0;0 1];
P_x1 = zeros(n_step,1);
P_x1(1) = 1;

P_x2 = zeros(n_step,1);
P_x2(1) = 1;

% Recursive step 

y_save = zeros(n_step,1);
y_save(1) = 15 + 0.01*randn;

for k=2:n_step
    H = [1 0.99^(k-1)];
    
    y_save(k) = H*x + (0.01*randn);
    
    K = P*H'*inv(H*P*H' + R);
    x_est(:,k) = x_est(:,k-1) + K*(y_save(k) - H*x_est(:,k-1));

    P = (eye(2) - K*H)*P*(eye(2) - K*H)' + K*R*K';

    P_x1(k) = P(1,1);
    P_x2(k) = P(2,2);
end

%% plot
subplot(2,1,1)
plot(0:n_step-1, x_est(1,:), "r"); hold on; grid on;
plot(0:n_step-1, x_est(2,:), "b");
title("Recursive Least Square Estimation");
xlabel('time step');
ylabel('value');
legend('estimated x1','estimated x2');

subplot(2,1,2)
plot(0:n_step-1, P_x1(:), 'r');  hold on; grid on;
plot(0:n_step-1, P_x2(:), "b");
title("P Covariance change");
xlabel('time step');
ylabel('covariance');
legend('covariance x1', 'covariance x2');
