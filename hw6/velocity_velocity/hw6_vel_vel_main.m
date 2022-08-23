%% Scattering-based bilateral teleoperation architecture

%% Force-Position case
clear;
%Amplitude of slave desired position, env positoned at x=5
Amp = 1; %does NOT touch env
% A = 2; %does touch env

%Frequency of the slave desired position
Fc = 0.5; 

%Frequency of the low pass filter
Fip=100;


% Human impedance parameters
Jh = 0;%0.05;%0.5;
Bh = 1.5;%70;
Kh = 1;%200;

% Impedance master/slave
Mm = 0.5;
Dm = 0.1;

Ms = 2;
Ds = 0.4;

% Controller master
Km = 100;
Bm = 50;

% Controller slave
Ks = 400;
Bs = 200; 

% Human intention controller (PI)
Ph = 5;
Dh = 5  ;

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
