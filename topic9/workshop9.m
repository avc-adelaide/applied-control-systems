

s = tf('s');
P = 1/(s+1)^3;

figure
step(P)

[Pnum,Pden] = tfdata(P);

%%
Kp = 1.8;
Ti = 1.6;
Td = 0.8;
N = 100;
C = pidstd(Kp,Ti,Td,N);

T = P*C/(1+P*C);

figure
step(T)


%%

% k = 0.3 seems like instability limit
k = 0.3;
add_un = k/(s^2+0.7*s+1)^2;
[UNnum,UNden] = tfdata(add_un);

figure
nyquist(add_un,P);


add_bound = (1+P*C)/C;

figure
bode(add_bound,add_un)



%%


% k = 0.6 seems like instability limit
k = 0.6;
mult_un = k/(s^2+0.7*s+1)^2;
[UNnum2,UNden2] = tfdata(mult_un);

figure
nyquist(mult_un,P);


mult_bound = (1+P*C)/(P*C);

figure
bode(mult_bound,mult_un)

