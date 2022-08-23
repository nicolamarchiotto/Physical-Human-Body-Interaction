% If legend color of plot does not show properly
opengl software;

clc; clear;
data = readtable('master_slave_1kHz.txt','PreserveVariableNames',true);
Ts=0.001;
data(1:370,:)=[];

% data = readtable('master_slave_2kHz.txt','PreserveVariableNames',true);
% Ts=0.0004;
% data(1:301,:)=[];

% data = readtable('master_slave_500Hz.txt','PreserveVariableNames',true);
% Ts=0.002;
% data(1:364,:)=[];


%prompt column names
% varNames=data.Properties.VariableNames;

%remove rows which correspond to 0 master position

qm=data.('M_POS');
dqm=data.('M_VEL');
qs=data.('S_POS');
dqs=data.('S_VEL');

%Discrete appox of the system
A=[1    Ts  Ts^2/2;
    0    1   Ts;
    0    0   1];

B=[Ts^3/6   Ts^2/2  Ts]';

C=[1    0   0];
%%
close all; 
clc;
% Initialization
q=qm;
dq=dqm;
N=size(q,1);

dq_euler=eulerVelocity(q,Ts);

% TO SUBSTITUTE WITH ACTUAL FILTERED ONE
dq_euler_filtered=dq_euler;

R=0.0001;
q_low_case=1;
Q=B*B'*q_low_case;

P0= [1  0       0
    0     1    0
    0     0       1];
x0=[0;0;0];

%
%
%
% KALMAN FILTER/PREDICTOR
%
%

result=kalmanFilterPredictor(x0,P0,A,C,Q,R,q,[]);

% kalman filter
kf=[result.x_k_k];
kf_q=kf(1,:)';
kf_dq=kf(2,:)';

% kalman predictor
kp=[result.x_kp1_k];
kp_q=kp(1,:)';
kp_dq=kp(2,:)';

%
%
% KALMAN SMOOTHER
%
%


result=kalmanSmoother(A,q,result);
ks=[result.xs_k];
ks_q=ks(1,:)';
ks_dq=ks(2,:)';


%
%
% STEADY STATE KALMAN FILTER/PREDICTOR
%
%

result=steadyKalmanFilterPredictor(x0,A,C,Q,R,q,result);

% steady kalman filter
S_kf=[result.S_x_k_k];
S_kf_q=S_kf(1,:)';
S_kf_dq=S_kf(2,:)';

% steady kalman predictor
S_kp=[result.S_x_kp1_k];
S_kp_q=S_kp(1,:)';
S_kp_dq=S_kp(2,:)';


% 
% 
% VISUALIZATION
% 
% 
t = data.('%TIME');

%% Filter, Predictor, Smoother

figure;
hold on
plot(t,q,t,kf_q,t,kp_q,t,ks_q);
legend('Measurements','Kalman filter', 'Kalman predictor','Kalman Smoother')
title('Position')

figure;
hold on
plot(t,dq,t,kf_dq,t,kp_dq,t,ks_dq);
title('Velocity')
legend('Measurements','Kalman filter', 'Kalman predictor', 'Kalman Smoother')

%% Steady filter/predictor
figure;
hold on
plot(t,dq,t,kf_dq,t,S_kf_dq);
title('Velocity - Kalman Filter vs Steady State Filter')
legend('Measurements','Kalman filter', 'Steady filter')


figure;
hold on
plot(t,dq,t,kp_dq,t,S_kp_dq);
title('Velocity - Kalman Predictor vs Steady State Predictor')
legend('Measurements', 'Kalman predictor', 'Steady predictor')

%% Measurements, Kalman Filter, Euler velocity
figure;
hold on 
plot(t(1:end-1),dq_euler,t(1:end-1),dq(1:end-1),t(1:end-1),kf_dq(1:end-1),t(1:end-1),dq_euler_filtered);
title('Euler vel')
legend('Euler velocity','Measurements','Kalman velocity','Filtered Euler Velocity')

