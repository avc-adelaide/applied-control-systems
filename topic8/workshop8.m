
% From Adv PID Week 9
Kp = 1;
Ti = 2.9;
Td = 0.7;
PIDN = 100;
Tmax = 30;

s = tf('s');
P = 3000*(s+4)/((s+1)*(s+6)*(s+10)*(s+100)*(s^2+2*s+2));
C = pidstd(Kp,Ti,Td,PIDN);
Gcl = feedback(P*C,1);
stepinfo(Gcl)

% gang of four
S = 1/(1+P*C);
PS = P/(1+P*C);
T = P*C*S;
CS = C*S;

%<*part1>
figure
bodemag(S,PS,T,CS)
legend('Sensitivity','Load sensitivity',...
    'Complementary sensitivity','Noise sensitivity')
%</part1>


%<*part2>
wb = bandwidth(T); % bandwidth omega_b
%</part2>


%<*part3>
[Pnum,Pden] = tfdata(P);
%</part3>


%<*part4>
wm = bandwidth(T,-10); 
%</part4>


wd = bandwidth(S,10); 

