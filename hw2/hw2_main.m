%% Discretization of the four channel bilateral teleleoperation architecture

%Sin frequency and amplitude of the reference signal
Fc=1;
A=1;

%Frequency of the low pass filter
Fip=1;

%Human Controller/Human intention
Ph = 20000;
Dh = 1000;

%Master controller
Bm = 0.8;
Km = 1;

%Slave controller
Bs = 3.2;
Ks = 4;

% Human Impedance
Jh=0.5;
Bh=70;
Kh=2000;

%Environment Impedance
%Continuos parameters
% Je=0;
% Be=0;
% Ke=100;
Je=0;
Be=30;
Ke=50;
%Environment position
xe=2;
    
%Slave robot Inertia
Ms=2;
% Ds=0;
Ds=10;

%Master robot Inertia
Mm=0.5;
% Dm=0;
Dm=5;

%Sample time
Ts=0.001;

%Noise
posNoiseVar=0.00001;
torqueNoiseVar=0.01;
