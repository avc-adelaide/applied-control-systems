%<*partA>

% Note: your naming might be different!

% Update the sine wave block in Simulink programmatically 
set_param('QubeModel/Sine Wave', ...
             'Amplitude', '0.5', ...
             'Bias', '0',...
             'Frequency', '1*2*pi', ...
             'Phase', '0' ...
          );

% Update the transfer function block in Simulink programmatically 
omega_c = 50;
set_param('QubeModel/Low-pass filter (rad)', ...
               'Numerator', sprintf('[%g]', omega_c), ...
               'Denominator', mat2str([1 omega_c])...
          );
%</partA>
%<*partB>

% Extract the Simulink scope output data structure (scopeData) with one channel

t = scopeData.time;
y = scopeData.signals.values;

figure(1); clf;
plot(t, y);
grid on
xlabel('Time, s')
ylabel('Amplitude')
%</partB>
%<*partC>
% Extract the Simulink scope output data structure (scopeData) with two channels

t = scopeData.time;
y1 = scopeData.signals(1).values;
y2 = scopeData.signals(2).values;

figure(2); clf; hold on;
plot(t, y1);
plot(t, y2);
grid on
xlabel('Time, s')
ylabel('Amplitude')
%</partC>