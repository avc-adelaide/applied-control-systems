%% Params

R_m = 8.4; % ohms
k_m = 0.042; % V/(rad/s)
D_r = 2*10^-5; % N.m.s/rad
J_m = 4*10^-6; % kg.m^2
J_h = 0.65*10^-6; % kg.m^2
m_d = 0.053; % kg
r_d = 0.0248; % m
J_d = 0.5*m_d*r_d^2;

A_22 = -(R_m*D_r+k_m^2)/(R_m*(J_m+J_h+J_d));
B21  = k_m / (R_m*(J_m+J_h+J_d));

A = [0, 1; 0, A_22];
B = [0; B21];
C = [1, 0];
D = 0;

%% Part 1
figure;
% Set up state space model
model_inertia_disk = ss(A,B,C,D);
% Define state, input, and output names
State_names = str2mat('theta','omega');
set(model_inertia_disk,'StateName',State_names);
set(model_inertia_disk,'InputName',{'V\_{command}'},...
'OutputName',{'theta'});
% Simulate system response to a step input
step(model_inertia_disk)
xlim([0, 1.5])

%% Part 2
hold on 

m= 22.6;
% ITD parameters
a = 35.14 - m*2.66;
tau = -a/m;
% Define ITD model
s = tf('s');
ITD_inertia_disk = -a/(tau*s)*exp(-s*tau);

% Simulate system response to a step input
[y,tOut] = step(ITD_inertia_disk);
plot(tOut-1,y)
xlim([0, 2.5])

%%

%<*part1>
%% Part 3
close all
modelname = 'QubeModel';

% Update the sine wave block in Simulink programmatically 
amp =           % V (peak limited to 2V)
freq =          % Hz

% Faster rebuild/run time (maybe)
set_param(modelname, 'DefaultParameterBehavior','Tunable');

% Pre-initialise array size
results = cell(length(amp),length(freq));
%</part1>
%<*part2>
figure;
for aa = 1:length(amp)
    for ff = 1:length(freq)

    % Update the sine wave block parameters
    set_param(strcat(modelname,'/Sine Wave'), ...
                 'Amplitude', sprintf('%g', amp(aa)), ...
                 'Bias', '0',...
                 'Frequency', sprintf('2*pi*%g', freq(ff)), ...
                 'Phase', '0' ...
              );

    % Start the Simulink simulation
    set_param(modelname, 'SimulationCommand','start');

        % Continously poll the simulation status to check if finished
        while ~strcmp(get_param(modelname, 'SimulationStatus'),'stopped')
            pause(0.1)
        end

    end
end
%</part2>


%<*part3>
% Save the results for later
results{aa,ff}=ScopeData;

% Plot the results as they come
subplot(length(amp),length(freq),sub2ind(size(results),aa,ff))

plot(ScopeData.time, ScopeData.signals(1).values);
hold on; grid on
plot(ScopeData.time, ScopeData.signals(2).values);

title(sprintf('Amplitude %.2fV, Frequency %0.2fHz',amp(aa),freq(ff)))
xlabel('Time, s')
ylabel('Angular position, rad')
legend('Real System', "State-Space Model", 'Location','Best')

%</part3>