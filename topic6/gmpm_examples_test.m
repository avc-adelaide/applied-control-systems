%%

close all
clear all

%%

color1 = [0.8 0 0];
gray   = 0.5*[1 1 1];

s = tf('s');
GH = 100/(s+2)/(s+4)/(s+5);

figure(99); bode(GH)

figure(1); clf; hold on
figuresize(10,10,'cm')
box on
axis([-1.1 2.6 -2.1 2.1])
draworigin

plot(cos(linspace(0,2*pi)),sin(linspace(0,2*pi)),'-','color',gray)
plot(-1,0,'p','markersize',8,'color',color1)

[re,im,freq] = nyquist(GH,logspace(-2,3,300));
plot(re(:),im(:),'-','color',color1)
plot(re(:),-im(:),'--','color',color1)

[re,im,freq] = nyquist(GH,2.89);
plot([0 re(:)],[0 im(:)],'-','color',gray)
plot(re(:),im(:),'.','markersize',12,'color',color1)
text(re(:),im-0.25,sprintf('(%1.3f,%1.3f)',re(1),im(1)),'horizontalalignment','center','background','white','edgecolor','black')

[re,im,freq] = nyquist(GH,6.16);
plot(re(:),im(:),'.','markersize',12,'color',color1)
text(re(:),0.25,sprintf('(%1.3f,0)',re(1)),'horizontalalignment','center','background','white','edgecolor','black')

print -dpdf gmpm_nyq_ex.pdf




figure(2); clf; hold on
figuresize(12,13,'cm')

subplot(2,1,1); cla; hold on
box on
set(gca,'xscale','log')
ylabel('Magnitude, dB')

freqrange = logspace(-1,2,300);

[mag,pha,freq] = bode(GH,freqrange);
plot(freq,20*log10(mag(:)),'-','color',color1,'linewidth',1)
ylim([-25 10])
xlim([0.2 50])

[mag1,pha1,freq1] = bode(GH,2.89);
plot(freq1(:),20*log10(mag1(:)),'.','color',gray,'markersize',20)
plot([0.01 100],20*log10([mag1(:) mag1(:)]),'-','color',gray,'linewidth',1)
plot([0.01 freq1(:) freq1(:)],20*log10([mag1(:) mag1(:) 1e-6]),'-','color',gray)

[mag2,pha2,freq2] = bode(GH,6.16);
plot([0.01 freq2(:) freq2(:)],20*log10([mag2(:) mag2(:) 1e-6]),'-','color',gray)

yticks([-20 round(20*log10(mag2(:)),1) 0 10])
set(gca,'xticklabel',[])

subplot(2,1,2); cla; hold on
box on
set(gca,'xscale','log')
ylabel('Phase, deg.')

ylim([-280 10])
yticks([-270 -180 round(pha1,1) -90 0])
[mag,pha,freq] = bode(GH,freqrange);
plot(freq,pha(:),'-','color',color1,'linewidth',1)
xlim([0.2 50])

plot(freq2(:),pha2(:),'.','markersize',20,'color',gray)
plot([0.01 freq1(:) freq1(:)],[pha1(:) pha1(:) 20],'-','color',gray)
plot([0.01 freq2(:) freq2(:)],[pha2(:) pha2(:) 20],'-','color',gray)
plot([0.01 100],[pha2(:) pha2(:)],'-','color',gray,'linewidth',1)

xlabel('Frequency, rad/s')

set(gca,'units','normalized')
pos = get(gca,'position');
set(gca,'pos',pos+[0 0.1 0 0])

print -dpdf gmpm_bode_ex.pdf




figure(3); clf; hold on
figuresize(10,10,'cm')

box on
xlabel('Phase, deg.')
ylabel('Magnitude, dB')

axis([-225 -45 -20 10])
freqrange = logspace(-1,2,300);

plot(-180,0,'p','markersize',8,'color',color1)

[mag,pha,freq] = bode(GH,freqrange);
plot(pha(:),20*log10(mag(:)),'-','color',color1,'linewidth',1)

[mag1,pha1,freq1] = bode(GH,2.89);
[mag2,pha2,freq2] = bode(GH,6.16);

plot([pha1 pha2 pha2],20*log10([mag1 mag1 mag2]),'-','color',gray,'linewidth',0.5)
plot([-270 -180],20*log10([1 1]),'--','color',gray,'linewidth',0.5)
plot([-180 -180],20*log10([0.001 mag2]),'--','color',gray,'linewidth',0.5)

plot(pha1(:),20*log10(mag1(:)),'.','color',gray,'markersize',20)
plot(pha2(:),20*log10(mag2(:)),'.','color',gray,'markersize',20)

xticks(sort([-225 -180 round(pha1,1) -90 -45]))
yticks(sort([-20 round(20*log10(mag2),1) 0 10 20]))

print -dpdf gmpm_nich_ex.pdf


%%

s = tf('s');

figure(10); clf; hold on
figuresize(12,12,'cm')

GH = 0.9*(s+0.005)*(s+0.1)/s^3/(s+2);

nichols(GH)

print -dpdf gmpm_nich_weird.pdf
