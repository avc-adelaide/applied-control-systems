%% Gain margin

s = tf('s');
GH1 = 100/(s+2)/(s+4)/(s+5);

figure(1); clf; hold on
figuresize(12,12,'cm')
plot(cos(linspace(0,2*pi)),sin(linspace(0,2*pi)),'-','color',0.5*[1 1 1])

h = nyquistplot(GH1,logspace(-2,3,200));

xlim([-1.5 2.5])
ylim([-2 2])