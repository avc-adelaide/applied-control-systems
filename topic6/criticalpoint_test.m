%% Stability margins and closed loop performance

%% The critical point


s = tf('s');
GH1 = 100*(s+10)/(s^2+5*s+7)^2/(s+20);
GH2 = 200*(s+10)/(s^2+5*s+7)^2/(s+20);
GH3 = 400*(s+10)/(s^2+5*s+7)^2/(s+20);
GH4 = 800*(s+10)/(s^2+5*s+7)^2/(s+20);

figure(1); clf; hold on
figuresize(10,10,'cm')
nyquist(GH1,GH2,GH3,logspace(-3,2,200))
axis equal
xlim([-1.5 2.5])
ylim([-2.0 2.0])

print -dpdf nyq-plain1.pdf

s = tf('s');
GH1 = 200*(s+10)/(s^2+5*s+7)^2/(s+20)*exp(-0*s);
GH2 = 200*(s+10)/(s^2+5*s+7)^2/(s+20)*exp(-0.2*s);
GH3 = 200*(s+10)/(s^2+5*s+7)^2/(s+20)*exp(-0.4*s);
GH4 = 200*(s+10)/(s^2+5*s+7)^2/(s+20)*exp(-0.6*s);

figure(2); clf; hold on
figuresize(10,10,'cm');
theta = linspace(0,2*pi);
plot( cos(theta), sin(theta), 'k--' )

nyquist(GH1,GH2,GH3,logspace(-3,2,200))

axis equal
xlim([-1.5 2.5])
ylim([-2.0 2.0])

print -dpdf nyq-plain2.pdf

%%

s = tf('s');
GH2 = 150*(s+10)/(s^2+5*s+7)^2/(s+20);
S2 = 1/(GH2+1);
s_m = getPeakGain(S2);
figure(3); clf; hold on
figuresize(10,10,'cm');

theta = linspace(0,2*pi);
plot( -1+1/(s_m)*cos(theta), 1/(s_m)*sin(theta), 'k--' )

nyquist(GH2,logspace(-3,2,200))

axis equal
xlim([-1.5 2.5])
ylim([-2.0 2.0])

print -dpdf nyq-plain3.pdf


%% The critical point stable


s = tf('s');
GH1 = 300*(s+10)/(s^2+5*s+7)^2/(s+20);
GH2 = 500*(s+10)/(s^2+5*s+7)^2/(s+20);
T1 = feedback(GH1,1);
T2 = feedback(GH2,1);

figure(1); clf; hold on
figuresize(10,10,'cm')
nyquist(GH1,GH2,logspace(-3,2,200))
xlim([-2.5 5.5])

print -dpdf gh1-nyq.pdf

figure(2); clf; hold on
figuresize(10,10,'cm')
pzmap(T1,T2)
xlim([-11 1])

print -dpdf gh1-pzmap.pdf


%% The critical point unstable


s = tf('s');
GH2 = 100*(s+10)/(s^2+5*s+7)^2/(s+5)/(s+1);
T2 = feedback(GH2,1);

figure(1); clf; hold on
figuresize(10,10,'cm')
nyquist(GH2,logspace(-3,2,200))
xlim([-2 4.5])

print -dpdf gh2-nyq.pdf

%%

figure(2); clf; hold on
figuresize(10,10,'cm')

z = zero(T2);
p = pole(T2);
k = dcgain(T2);
pu = p(real(p)>=0);
ps = p(real(p)<0);
T2s = zpk(z,ps,k);
T2u = zpk([],pu,1);

pzplot(T2s,T2u)
xlim([-10.5,0.5])

print -dpdf gh2-pzmap.pdf

