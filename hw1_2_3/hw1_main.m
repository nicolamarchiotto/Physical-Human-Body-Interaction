%% 4 channel bilateral teleoperation architectures

%Sin frequency and amplitude of the reference signal
Fc = 0.5;
Amp = 0.8;

%Frequency of the low pass filter
Fip = 1;

%Human Controller/Human intention
Ph = 50;
Dh = 40;

%Master controller
Bm = 0.8;
Km = 1;

%Slave controller
Bs = Bm*4;
Ks = Km*4;

% Human Impedance
Jh = 0.5;
Bh = 1.5;
Kh = 1;

%Environment Impedance
Je = 0;
Be = 0;
Ke = 200;

%Environment position
xe = 0.5;
    
%Slave robot Inertia
Ms = 2;
Ds = 0; %10;

%Master robot Inertia
Mm = 0.5;
Dm = 0; %5;

%Sample time
Ts=0.001;

%Noise
posNoiseVar = 0.0001;
torqueNoiseVar = 0.01;

% Inner force loop
Cmf = 0; %1;
Csf = 0; %0.2;

%Kalman filter
A = [1 Ts;
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
