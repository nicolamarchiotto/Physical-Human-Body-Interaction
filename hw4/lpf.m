s=tf('s');
Fc=10;
Ts=0.001;
G=2*pi*Fc/(s+2*pi*Fc);
P=c2d(G,Ts);

p_s=-2*pi*Fc;
p_z=exp(p_s*Ts);


figure;
bode(G)
hold on;
bode(P)

