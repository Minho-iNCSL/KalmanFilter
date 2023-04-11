clc; clear; close all;

%% Load Drone Data

data = load('viet_drone.mat'); 

%% Data Alignment

% Ground Truth

GT = data.gT;

% Data from GPS

GPS = data.GPS;
GPS_fs = GPS.Hz;
GPS_data = GPS.Measurement;
GPS_velocity = GT.Velocity;
GPS_Noise = GPS.Noise;

% Data From IMU

IMU = data.IMU;
IMU_fs = IMU.Spec.Accel.Hz;

IMU_ba = IMU.Spec.Accel.Bias;
IMU_bg = IMU.Spec.Gyro.Bias;

IMU_Na = IMU.Spec.Accel.Noise;
IMU_Ng = IMU.Spec.Gyro.Noise;

IMU_acc = IMU.Measurement.Accel;
IMU_gyro = IMU.Measurement.Gyro;

g = [0 0 9.8]';
T = 0.01;

for k = 1:length(GT.Time)

    if k==1
        %% Define Initial State
        x_po = zeros(15,length(GT.Time));
        x_po(:,1) = [GT.Position(:,k); GT.Velocity(:,k); GT.Euler(:,k); zeros(3,1); zeros(3,1)];
        x_pr = zeros(15,1);

        P_po = diag([(1e-6)*ones(3,1); (1e-6)*ones(3,1); (1e-6)*ones(3,1); (GT.biasGyro(:,k)-x_po(10:12,k)).^2; (GT.biasAccel(:,k)-x_po(13:15,k)).^2]);
        Q = diag([(1e-6)*ones(3,1); (IMU_Na.^2)* ones(3,1); (IMU_Ng.^2)* ones(3,1); (1e-6)*ones(3,1); (1e-6)*ones(3,1)]);
        
        Q_Na = Q(4:6, 4:6);
        Q_Ng = Q(7:9, 7:9);

        % R = diag((GPS_Noise.^2)*ones(3,1));  % No velocity
        % Correction 
        R = diag([(GPS_Noise.^2)*ones(3,1); 0.01^2 * ones(3,1)]);
        % H = [eye(6) zeros(3) zeros(3) zeros(3) zeros(3)]; % No velocity
        % Correction 
        H = [eye(6) zeros(6,3) zeros(6,3) zeros(6,3)];

        dx_pr = zeros(15,1);
        dx_po = zeros(15,1);

        % Euler to Quaternion
        Cbn_q = euler2quat(x_po(7,k), x_po(8,k), x_po(9,k));

        % Quaternion to DCM
        Cbn_d = quat2dcm(Cbn_q);
  
        omega = zeros(4,4,length(GT.Time));
        omega(:,:,1) = skew_sym_quat(IMU_gyro(:,1));
    else
        %% IMU, Gyro Sensor Correction
        IMU_gyro(:,k) = IMU_gyro(:,k) - x_po(10:12,k-1);
        IMU_acc(:,k) = IMU_acc(:,k) - x_po(13:15,k-1);
        
        % (a) Calculate by integration Gyroscope's Angular Velocty Data
        omega(:,:,k) = skew_sym_quat(IMU_gyro(:,k));

        % Euler to Quaternion
        
        Cbn_q = quat_update(Cbn_q, IMU_gyro(:,k), omega(:,:,k-1), omega(:,:,k), T);
        % Cbn_q = Cbn_q / norm(Cbn_q);

        % Quaternion to DCM
        Cbn_d = quat2dcm(Cbn_q);

        % (b) Calculate Position and Velocity from Acceleromter
        acc = Cbn_d*IMU_acc(:,k) + g;
        vel = x_po(4:6,k-1) + acc*T;
        pos = x_po(1:3,k-1) + vel*T + 0.5*acc*T^2;
        ang = dcm2euler(Cbn_d);

        bg = x_po(10:12, k-1);
        ba = x_po(13:15, k-1);

        x_pr(:,k) = [pos; vel; ang; bg; ba];

        % body to NED
        fn = Cbn_d*IMU_acc(:,k);
        fn_skew = skew_sym(fn);
        
        % Define F matrix
        F = [  eye(3) eye(3)*T   zeros(3) zeros(3)  zeros(3)
             zeros(3)   eye(3) -fn_skew*T zeros(3)  -Cbn_d*T
             zeros(3) zeros(3)     eye(3) -Cbn_d*T  zeros(3)
             zeros(3) zeros(3)   zeros(3)   eye(3)  zeros(3)
             zeros(3) zeros(3)   zeros(3) zeros(3)    eye(3)];
        
        Q(4:6, 4:6) = Cbn_d*Q_Na*Cbn_d';
        Q(7:9, 7:9) = Cbn_d*Q_Ng*Cbn_d';

        P_pr = F*P_po*F' + Q*T;

        %% If Measurement is available, the Measurement update.

        if isnan(GPS_data(1,k))
            x_po(:,k) = x_pr(:,k);
            P_po = P_pr;
        else
            % (a) Calculate Kalman Gain
            Kk = (P_pr*H')* inv(H*P_pr*H' + R); %#ok<*MINV>
            
            % (b) Calculate the resudual
            % rk = GPS_data(:,k) - H*x_pr(:,k);  % No velocity

            rk = [GPS_data(:,k); GPS_velocity(:,k)] - H*x_pr(:,k);

            % (c) Calculate delta \hat{x}_k^+
            dx_po = Kk*rk;

            % (d) Posteriori Covariance P  
            P_po = (eye(15) - Kk*H)*P_pr*(eye(15)-Kk*H)' + Kk*R*Kk';

            %% Correction
            x_po(1:3,k) = x_pr(1:3,k) + dx_po(1:3);
            x_po(4:6,k) = x_pr(4:6,k) + dx_po(4:6);
            x_po(10:12,k) = x_pr(10:12,k) + dx_po(10:12);
            x_po(13:15,k) = x_pr(13:15,k) + dx_po(13:15);

            Cbn_d_po = (eye(3) + skew_sym(dx_po(7:9)))*Cbn_d;
            x_po(7:9,k) = dcm2euler(Cbn_d_po);

            % Quaternion Update
            Cbn_q = euler2quat(x_po(7,k),x_po(8,k),x_po(9,k));
        end
    end
end

%% Plot 
figure(1)
title('3D Trajectory Estimation');
plot3(GT.Position(2,:), GT.Position(1,:), -GT.Position(3,:), 'b', LineWidth=2); grid on; hold on;
plot3(x_po(2,:), x_po(1,:), -x_po(3,:), 'r', LineWidth=2);
legend('Ground Truth', 'Estimation', Location='southwest');
xlabel('Y [m]');
ylabel('X [m]');
zlabel('Z [m]');
