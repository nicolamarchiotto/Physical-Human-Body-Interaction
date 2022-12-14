%% Tank based velocity velocity

%Sin frequency and amplitude of the reference signal
Fc_sin = 0.1;
Amp = 0.8; %0.8

delay = 10;
 
% % cutoff frequency of the wave transformation filter
% Fc_wave = 8;

%Frequency of the low pass filter
Fc_lp = 5;

%Human Controller/Human intention
Dh = 8;
Ph = 0;% 1;

%Master controller
Bm = 3;
Km = 40;

%Slave controller
Bs = 15;
Ks = 50;

% Human Impedance
Jh = 0;  
Bh = 1.5;  
Kh = 0.1; %1.0; 

%Environment Impedance
Je = 0;
Be = 20;
Ke = 210;

%Environment position
xe = 0.5;
    
%Slave robot Inertia
Ms = 2;
Ds = 0; %10;

Mm = 0.5;
Dm = 0;

%Sample time
Ts=0.001;

% Tank variables
beta = 0.2;
alpha = 1;

H_D = 1.5;

%Noise
posNoiseVar=0.0001;

A = [1 Ts
    0 1];
B = [Ts^2/2;Ts];
x0 = [0 0];
C = [1 0];

q_m = 1000000;
R_m = 1;
Q_m = q_m*B*B';

q_s = 1000000;
R_s = 1;
Q_s = q_s*B*B';