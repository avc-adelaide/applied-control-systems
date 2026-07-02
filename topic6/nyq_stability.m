%% Nyquist stability

%%

s = tf('s');
freq = logspace(-3,3,1000);
GH1 = 1/(s+1)^3;
GH2 = 2/(s+1)^3;
GH3 = 4/(s+1)^3;

figure(1);
figuresize(14,10,'cm')

p = nyquistplot(GH1,GH2,GH3,freq);

xlim([-1.1 1.1])
ylim([-0.8 0.8])

print -dpdf nyq_stability_ex1.pdf

%%

s = tf('s');

k = 1;
GH = k*(s-2)/(s+4)^2;

figure(1);
figuresize(18,12,'cm')

nyquistplot(GH)