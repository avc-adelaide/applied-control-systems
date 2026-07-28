



%<*part1>
% Parameters
m = 2; % mass
k = 5; % spring
b = 1; % damper

% System matrices
A = [0, 1; -k/m, -b/m];
B = [0; 1/m];
C = [1, 0];
D = 0;

msd_ss = ss(A,B,C,D);

% Transfer function
s = tf('s'); 
G = C*inv(s*eye(2)-A)*B+D;
%</part1>

%<*part2>
[num, den] = ss2tf(A,B,C,D);
G = tf(num,den);
%</part2>

%<*part3>
% Pole locations
pole(G) 
damp(G)
% Step response
figure
step(G)
%</part3>

%<*part3.1>
% Step response characteristics
stepinfo(G)
%</part3.1>


%%

%<*part4>
% Bode plot
figure
bode(G)
%</part4>



