function [q,dq,ddq]=kalmanFilter(q,Ts)

A=[1    Ts  Ts^2/2;
    0    1   Ts;
    0    0   1];

B=[Ts^3/6   Ts^2/2  Ts]';

C=[1    0   0];

R=0.0001;
q_low_case=1;
Q=B*B'*q_low_case;

P0= [1  0       0
    0     1    0
    0     0       1];
x0=[0;0;0];

result=kalmanFilterPredictor(x0,P0,A,C,Q,R,q,[]);

% kalman filter
kf=[result.x_k_k];
q=kf(1,:)';
dq=kf(2,:)';
ddq=kf(3,:)';

end