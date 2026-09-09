


a = 3.2; b = 0.6; c = 50; 
d = 0.56; k = 125; r = 1.6;
tmax = 70; H_0 = 25; L_0 = 20;


%%
%<*part1>
% System parameters
a = 3.2; b = 0.6; c = 50; 
d = 0.56; k = 125; r = 1.6;

% Simulation parameters
tmax = 10; H_0 = 25; L_0 = 20;

function dq = predprey(q,param)
a = param(1); b = param(2); c = param(3);
d = param(4); k = param(5); r = param(6);
H = q(1,:);
L = q(2,:);
dH = r*H.*(1-H/k)-a*H.*L./(c+H);
dL = b*a*H.*L./(c+H)-d*L;
dq = [dH; dL];
end
%</part1>

%%

%<*part2>
% Simulate uncontrolled system
[t, x] = ode45(@(tt,xx) predprey(xx,[a,b,c,d,k,r]), ...
    [0 tmax], [H_0; L_0]);

% Plot
figure(2); clf
plot(t,x)
box on; grid on
xlabel("Time (years)")
ylabel("Population")
legend("Hare","Lynx")
%</part2>

%% Part 2B

%<*part2b>
figure(22); 

HH0 = [25, 70];
LL0 = [20, 50];

for ii = 1:2
    subplot(1,2,ii); cla
    box on; grid on; axis square

    [~, x] = ode45(@(tt,xx) predprey(xx,[a,b,c,d,k,r]), ...
        0:tmax/100:10*tmax, [HH0(ii); LL0(ii)]);
    plot(x(:,1),x(:,2))

    xlabel("Number of hares")
    ylabel("Number of lynxes")
    axis([0 90 0 90])
end

saveas(gcf,"workshop4-limit-cycle.pdf")
%</part2b>

%% 

%<*part2c>
figure(23); clf

Hrange = linspace(1,50);
Lrange = linspace(1,50);

[Hmesh, Lmesh] = meshgrid(Hrange,Lrange);
dq = predprey( [Hmesh(:).'; Lmesh(:).'], [a,b,c,d,k,r] );
rms_dq = sqrt(dq(1,:).^2 + dq(2,:).^2);

imagesc(Hrange,Lrange,reshape(rms_dq,size(Hmesh)))
axis xy

box on; grid on; axis square
xlabel("Number of hares")
ylabel("Number of lynxes")
colorbar

saveas(gcf,"workshop4-fixed-points.pdf")
%</part2c>

%% Part 3

%<*part3>
% Linearised open loop system
A = [0.13, -0.93; 0.57, 0];
B = [17.2; 0];
C = [0, 1];
D = 0;

predpray_ss_ol = ss(A,B,C,D);
%</part3>

%<*part7>
% Reachability matrix
Wr = [B A*B]; % could also use ctrb(A,B)
rank(Wr)
%</part7>


%% Part 4

%<*part4>
% Eigenvalue assignment
lambda = [-0.1, -0.2]; % desired poles
K = place(A,B,lambda); % resulting gains
kf = -1/(C*inv(A-B*K)*B);

% Closed loop system
A_closed = A-B*K;
predpray_ss_cl = ss(A_closed,B,C,D);

% Initial condition response
[y,t] = initial(predpray_ss_cl, [10; 0]);

% Plot
figure(4); clf
plot(t,y)
box on; grid on
xlabel("Time (years)")
ylabel("Controlled lynx population around equilibrium point (linearised")
%</part4>

%% Part 5

%<*part5>
% Simulate controlled system
[t, x] = ode45(@(tt,xx) predprey_cl(xx,K,kf,...
    [a,b,c,d,k,r]), [0 tmax], [15; 20]);

% Plot
figure
plot(t,x)
box on; grid on
xlabel("Time (years)")
ylabel("Population")
legend("Hare","Lynx")

function dq = predprey_cl(q,K,kf,param)
a = param(1); b = param(2); c = param(3);
d = param(4); k = param(5); r = param(6);
H = q(1,:);
L = q(2,:);
He = 20.6; % equilibrium values
Le = 29.5; 
Ld = 30; % reference value
u = -K*[H-He; L-Le]+kf*(Ld-L);
dH = (r+u)*H*(1-H/k)-a*H*L/(c+H);
dL = b*a*H*L/(c+H)-d*L;
dq = [dH; dL];
end
%</part5>


%<*part6>
% Observability matrix
Wo = [C; C*A]; % could also use obsv(A,C)
rank(Wo)
%</part6>

