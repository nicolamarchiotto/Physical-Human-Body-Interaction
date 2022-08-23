clc
data = readtable('master_slave_1kHz.txt','PreserveVariableNames',true);
Ts=0.001;
% data = readtable('master_slave_2kHz.txt','PreserveVariableNames',true);
% Ts=0.0004;
% data = readtable('master_slave_500kHz.txt','PreserveVariableNames',true);
% Ts=0.002;

%prompt column names
varNames=data.Properties.VariableNames;

%remove rows which corresponf to 0 master position
data(data.M_POS == 0, :) = [];

qm=data.('M_POS');
dqm=data.('M_VEL');
qs=data.('S_POS');
dqs=data.('M_VEL');

%% Kalman filter for position and velocity

q=qm;
dq=dqm;

A=[1 Ts;
   0 1];
B=[Ts^2/2 Ts]';
C=[1 0];

clc;
close all;

%Initial conditions and initialization

P0 = [1e-4  0
       0 1e-4 ];
x0=[q(1);dq(1)];

kq=[x0(1)];
kdq=[x0(2)];
P=[P0];

R=var(q);
Q=500;
P_prev=P0;
for k=1:size(data,1)-1

    xk_k=[kq(k);kdq(k)];
    y_kplusone=q(k+1);
    
    Pkplusone_k=A*P_prev*A'-A*P_prev*C'*inv((C*P_prev*C'+R))*C*P_prev*A'+Q;
    K_kplusone=Pkplusone_k*C'*inv((C*Pkplusone_k)*C'+R);
    
    x_new=A*xk_k+K_kplusone*(y_kplusone-C*A*xk_k);
    
    kq(k+1)=x_new(1);
    kdq(k+1)=x_new(2);
    P_prev=Pkplusone_k;
   
end
kq=kq';
kdq=kdq';

t = data.('%TIME');

figure;
sgtitle(['Kalman filter']);
subplot(1,2,1);
hold on 
plot(t,kq,t,q);
legend('kalman','measurements')
title('Master position')

subplot(1,2,2);
hold on 
plot(t,kdqm,t,dq);
title('Master velocity')
legend('kalman','measurements')
