%% Scattering-based bilateral teleoperation architecture

%% Force-Position case
clear;
%Amplitude of slave desired position, env positoned at x=5
Amp = 1; %does NOT touch env
% A = 10; %does touch env

%Frequency of the slave desired position
Fc = 1; 

%Frequency of the low pass filter
Fip=10;

% Impedance master/slave
Mm = 0.5;
Dm = 5;

Ms = 2;
Ds = 0;%0.4;

% Controller slave
Ks = 0;%100; %Km*4;
Bs = 100;%80;  %Bm*4;

% Human impedance parameters
Jh = 1;%0;%0.05;%0.5;
Bh = 70;%0.6;%70;
Kh = 2000;%1;%200;

% Human intention controller (PI)
Ph = 13000;%1.5;%5;
Dh = 700;%1;

% Wave variables constant

b = 1;  

% Environment impedance parameters
Je = 0;
Be = 10;%10; 
Ke = 200;%50;
%Environment position
xe = 4;

Ts = 0.001;

delay=1;

%Noise
posNoiseVar=0.0001;
torqueNoiseVar=0.000;

A = [1 Ts;  
    0 1];
B = [Ts^2/2;Ts];
x0 = [0 0];
C = [1 0];
q_m = 10000;
R_m = 1;
Q_m = q_m*B*B';


q_s = 100000000;
R_s = 1;
Q_s = q_s*B*B';

