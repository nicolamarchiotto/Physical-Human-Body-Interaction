%Amplitude of slave desired position, env positoned at x=5
Amp = 1; %does NOT touch env
% A = 2; %does touch env

%Frequency of the slave desired position
Fc = 0.5; 

%Frequency of the low pass filter
Fip=100;


% Human impedance parameters
Jh = 0;%0.05;%0.5;
Bh = 0;%70;
Kh = 1;%200;

% Impedance master/slave
Mm = 2;
Dm = 4;

Ms = 40;
Ds = 50;

% Controller slave
Ks = 800;
Bs = 600; 

% Human intention controller (PI)
Ph = 1;
Dh = 10;

% Wave variables constant
b = 1;  

% Environment impedance parameters
Je = 0; 
Be = 10; 
Ke = 10;
%Environment position
xe = 1.5;

Ts = 0.001;

delay=1;

%Noise
posNoiseVar=0.00001;
torqueNoiseVar=0.01;

A = [1 Ts
    0 1];
B = [Ts^2/2;Ts];
x0 = [0 0];
C = [1 0];
q_m = 10000;
R_m = 1;
Q_m = q_m*B*B';


q_s = 1000000;
R_s = 1;
Q_s = q_s*B*B';