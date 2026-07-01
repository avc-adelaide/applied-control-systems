

%<*part1>
H = pidstd(1,1,1);
%</part1>


%<*part2>
tf(H)
%</part2>


%<*part3>
H.Kp % output the value of Kp 
H.Ti = 2; % change the value of Ti 
H.Td = H.Td*2; % increase Td by 2
%</part3>

%%

%<*part4>
s = tf('s');
G = 1/(s+1)^3;
H = pidstd(5,2,1);

% Closed loop transfer function
Gcl = feedback(G*H,1);
%</part4>

step(Gcl)



%%

P = 3/(s-2);

Kp = 8/3;
Ki = 5/3;
Ti = Kp/Ki;

H1 = pidstd(Kp,Ti,0);

Pcl = feedback(P*H1,1);
pole(Pcl)
