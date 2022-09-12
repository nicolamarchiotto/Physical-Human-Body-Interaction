%% hw5 - Identify the parameters k and tau (i.e J and D) using the LS, RLS and the Adaptive Algorithm on the DC motors data
clc
clear
data = readtable('master_slave_1kHz.txt','PreserveVariableNames',true);
data(1:370,:)=[];
Ts=0.001;

t=data.('%TIME');
q=data.('M_POS');
[q,dq,ddq]=kalmanFilter(q,Ts);
volt=data.('M_VOLT');

X=[ddq, dq];
Y=volt;

Y=lowPassFilter(Y,1,Ts);

% LS

b_hat_ls=inv(X'*X)*X'*Y;

Y_hat_ls=X*b_hat_ls;

k_ls=1/b_hat_ls(2);
tau_ls=b_hat_ls(1)*k_ls;
k_ls
tau_ls

% RLS, the lamba must be in the range 0.005 < lamba < 1 for computational
% reasons, if lamba < 0.005, lamba is set to 0.005

P0=diag([1 1]);
lamba=1;
[Y_hat_rls,k_rls,tau_rls]=RLS(X,Y,P0,lamba);
k_rls
tau_rls
% Adaptive algorithm

g=0.3;
[Y_hat_adpt, k_adpt, tau_adpt]=adativeAlgorithm(X,Y,Ts,g);

% Data vs LS
% figure;
% plot(t,Y);
% hold on;
% plot(t,Y_hat_ls);
% legend('Motors data','LS');
% xlabel('Time')
% ylabel('Voltage')
% title("LS: Parameters: k "+k_ls+" tau "+tau_ls)
% 
% % Data vs LS vs RLS
% 
% figure;
% plot(t,Y);
% hold on;
% plot(t,Y_hat_ls);
% plot(t,Y_hat_rls);
% legend('Motors data','LS', 'RLS');
% xlabel('Time')
% ylabel('Voltage')
% title("RLS: Final parameters: k "+k_rls+" tau "+tau_rls)

% Data vs LS vs RLS vs Adaptive Algorithm

figure;
plot(t,Y);
hold on;
plot(t,Y_hat_ls);
plot(t,Y_hat_rls);
plot(t,Y_hat_adpt);
legend('Motors data','LS', 'RLS','Adaptive');
xlabel('Time')
ylabel('Voltage')
