% Applied Control Systems
% Practical Week 4
% Matthew Forbes 5/9/26

%<*part1>
%% Step response with PID 'off'

Kp = 1.00;
Kd = 0.00;
Ki = 0.00;

scopeValues = ScopeData.signals.values;
scopeTime = ScopeData.time;
scopeStepResponse = stepinfo(scopeValues)
scopeSteadyState = scopeValues(end)         % if settled
%</part1>
%% Manual PID Gains
Kp = 2.00;
Kd = 0.09;
Ki = 0.12;

manualValues = ScopeDataManual.signals.values;
manualStepInfo = stepinfo(manualValues)
%% ITD Model

% line properties
m= 23.25;
time_point = 4.00;
radian_point = 90.23;

% ITD parameters
offset = radian_point - m*time_point;
a = -offset;
tau = -offset/m;

%% ZN PID Gains

Ti = 2*tau;
Td = tau/2;

Kp = 1.2/a;
Kd = Kp*Td;
Ki = Kp/Ti;

znValues = ScopeDataZN.signals.values;
znStepInfo = stepinfo(znValues)

%% SIMC PI Gains

tau_c = tau;

Ti = 4*(tau_c+tau);

Kp = 1/(a*(tau_c+tau));
Kd = 0;
Ki = Kp/Ti;

simcValues = ScopeDataSIMC.signals.values;
simcTime = ScopeData.time;
simcStepInfo = stepinfo(simcValues)

%% SIMC PI tuning tau_c

tau_c = 9.75*tau;

Ti = 4*(tau_c+tau);

Kp = 1/(a*(tau_c+tau));
Kd = 0;
Ki = Kp/Ti;

simcValuesTuned = ScopeDataSIMC2.signals.values;
simcStepInfo = stepinfo(simcValuesTuned)

%% Plot ITD responses

time = ScopeDataZN.time;
figure(44); clf; hold on; grid on
plot(time,manualValues)
plot(time,znValues)
plot(time,simcValues)
plot(time,simcValuesTuned)
yline(90,'--','Setpoint')
legend('Manual Tuned PID (trial-and-error)', 'ITD Ziegler-Nichols PID-Rule', 'ITD SIMC PI-Rule (\tau = \tau_c)', 'ITD SIMC PI-Rule (\tau_c tuned)')
ylim([0 140])
xlim([0 2.5])
xlabel('Time, s')
    ylabel('Angular position, deg')

%% Part 2
%<*part2>
% Adjusting stepinfo() to return a 63.2% Rise Time
scopeStepInfo = stepinfo(scopeValues,scopeTime,'RiseTimeLimits',[0 0.632]);
scopeStepInfo.RiseTime
%</part2>

%% Plot responses ITD used in FOTD

time = ScopeDataZNspeed.time;
figure(44); clf; hold on; grid on
plot(time,ScopeDataManualspeed.signals.values)
plot(time,ScopeDataZNspeed.signals.values)
plot(time,ScopeDataSIMC2.signals.values)
yline(20,'--','Setpoint')
legend('Manual Tuned PID (trial-and-error)', 'ITD Ziegler-Nichols PID-Rule', 'ITD SIMC PI-Rule (\tau_c tuned)')
ylim([0 30])
xlim([0 1.5])
xlabel('Time, s')
ylabel('Angular velocity, rad/s')

%% Find T from open loop response with PID off

Kp = 1.00;
Kd = 0.00;
Ki = 0.00;

scopeValues = ScopeDataOL.signals.values;
scopeTime = ScopeDataOL.time;

%<*part3>
% Adjusting stepinfo() to return a 63.2% Rise Time
t63stepInfo = stepinfo(scopeValues,scopeTime,'RiseTimeLimits',[0 0.632]);
t63 = t63stepInfo.RiseTime;
y63 = interp1(scopeTime,scopeValues,t63); % if curious
% Find the point of maximum slope
[m,idx]=max(gradient(scopeValues,scopeTime));
% Get the point where m was calculated
time_point = scopeTime(idx);
velocity_point = scopeValues(idx);
% Calculate a, tau, T
offset = velocity_point - m*time_point;
a = -offset;
tau = -offset/m;
T = t63 - tau;
%</part3>

%% CHR FOTD PID Gains

Ti = T;
Td = tau/2;

Kp = 0.6/a;
Kd = Kp*Td;
Ki = Kp/Ti;

chrValues = ScopeDataCHR.signals.values;
chrStepInfo = stepinfo(chrValues)

%% CC FOTD PID Gains

tau_n = tau/(tau+T);
Ti = tau*(2.5-2*tau_n)/(1-0.39*tau_n);
Td = tau*(0.37-0.37*tau_n)/(1-0.81*tau_n);

Kp = 1.35/a*(1+0.18*tau_n/(1-tau_n));
Kd = Kp*Td;
Ki = Kp/Ti;

ccValues = ScopeDataCC.signals.values;
ccStepInfo = stepinfo(ccValues)

%% Manual PID Gains
Kp = 2.00;
Kd = 0.09;
Ki = 0.32;

manual2Values = ScopeDataManual2.signals.values;
manualStepInfo = stepinfo(manual2Values)

%% Plot FOTD step responses 

time = ScopeDataCC.time;
figure(44); clf; hold on; grid on
plot(time,ScopeDataManualspeed.signals.values)
plot(time,chrValues)
plot(time,ccValues)
yline(20,'--','Setpoint')
legend('Manual Tuned PID (trial-and-error)', 'FOTD Chien-Hrones-Reswick PID-Rule', 'FOTD Cohen-Coon PID-Rule')
ylim([0 30])
xlim([0 2])
xlabel('Time, s')
ylabel('Angular velocity, rad/s')