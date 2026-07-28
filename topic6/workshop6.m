

G = s/(s+10);


%<*part1>
% Nyquist plot
figure
nyquist(G)
%</part1>



%%
%<*part2>
k = 1;
s = tf('s');
L = k/(s+1)^3; % open loop TF

Gcl = feedback(L,1); % closed loop TF
%</part2>

figure
subplot(2,1,1)
nyquist(L)
subplot(2,1,2)
step(Gcl)


%%

k = 5;
s = tf('s');
L = k/(s+1)^3; % open loop TF
Gcl = feedback(L,1); % closed loop TF

%<*part3>
[GM, PM] = margin(L); % gain and phase margin calculation
%</part3>

