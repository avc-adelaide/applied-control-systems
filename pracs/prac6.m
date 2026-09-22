
%<*part1>
% Plot Bode and Nyquist 
pendulum_TF = tf(<NUMERATOR>, <DENOMINATOR>)
LPfilter_TF = tf(<NUMERATOR>, <DENOMINATOR>)
BoFig = figure(1);clf; bode(pendulumTF); grid on;
NyFig = figure(2);clf; nyquist(pendulumTF); grid on
myTF = pendulum_TF*LPfilter_TF
BoFig = figure(3);clf; bode(myTF); grid on;
NyFig = figure(4);clf; nyquist(myTF); grid on;
%</part1>


%<*part2>
%Code to plot the Bode and Nyquist charts
ModelName = '<INSERT NAME OF SIMULINK MODEL HERE>';
FreqRange = <INSERT VECTOR OF FREQUENCIES HERE>;
for i = 1:length(FreqRange)
	Freq_i = FreqRange(i)
	% Run Simulation
	set_param(gcs,'SimulationCommand','start') 
	% Continously poll the simulation status to check if finished
        while ~strcmp(get_param(ModelName,'SimulationStatus'),'stopped')
            pause(0.1)
        end
	% Extract data (excluding 1st half transient effects)
        midpoint = floor(length(<ANY SIGNAL>.time)/2);
	outputData = <NAME OF OUTPUT SIGNAL>.signals().values(midpoint:end);
	inputData = <NAME OF INPUT SIGNAL>.signals().values(midpoint:end);
   	% Calculate amplitude:
   	pks = findpeaks(outputData);
    	trphs = -findpeaks(-outputData);
    	amp(i) = (median(pks)-median(trphs))/2;
    	ampdB(i) = mag2db(amp(i));
%</part2>
%<*part3>
    % Calculate phase (using cross correlation)
    [Corr, phi] = xcorr(outputData,inputData);
    [~, maxi] = max(Corr); % index of maximum correlation
    T = 2*pi/Freq_i;
    phaseOffset = -(2*pi*phi(maxi)*ts/T); % phase difference (rad)
    phaseOffset = mod(phaseOffset,2*pi)-2*pi; % modulo phase 
    phase(i) = phaseOffset*180/pi; % convert to degrees
end
% These might be useful :) [amp.*cosd(phase),  amp.*sind(phase)]
% Replot Bode
BoFigLP = figure;
omega = logspace(0,2,101);
[m,p] = bode(myTF,omega);
subplot(2,1,1);
semilogx(omega,mag2db(m(:)));
grid on;
subplot(2,1,2);
semilogx(omega,p(:));
grid on;

% Plotting results 
figure(BoFigLP); subplot(2,1,1); hold on; semilogx(<FREQUENCY>,<MAGNITUDE>,'r-o');
figure(BoFigLP); subplot(2,1,2); hold on; semilogx(<FREQUENCY>,<PHASE>,'r-o');
figure(NyFigLP); hold on; plot(<REAL PART>,<IMAGINARY PART>,'r-o');

%</part3>

