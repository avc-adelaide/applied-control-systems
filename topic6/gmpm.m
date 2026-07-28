%%

%%

clearvars
close all
clc

%%

colgrey = 0.6*[1 1 1];
ms = 13;

s = tf('s')

G = 3/(s+2)^3;
H = pidstd(5,1,0);



figure(1); clf; hold on; box on
figuresize()
set(gcf,'color','white')

ax = 1.2;
axis(ax*[-1 1 -1 1])
text(ax,0,'Re','verticalalignment','top')
text(0,ax,' Im','horizontalalignment','left')

text(1,0,'~$+1$','interpreter','latex','verticalalignment','bottom')
text(-1,0,'$-1$~','interpreter','latex','verticalalignment','bottom','horizontalalignment','right')
text(0,1,'~$+1$','interpreter','latex','verticalalignment','bottom')
text(0,-1,'~$-1$','interpreter','latex','verticalalignment','top')
text(0,ax,' Im','horizontalalignment','left')

plot([-ax ax],[0 0],'k')
plot([0 0],[-ax ax],'k')

t = linspace(0,2*pi);
plot(cos(t),sin(t),'-','color',colgrey,'linewidth',1.5)

freq = logspace(0,2,500);
[GHre,GHim] = nyquist(G*H,freq);
plot(GHre(:),GHim(:),'color',[0 0.8 0.2],'linewidth',2)

[GM,PM] = margin(G*H);

aa = 1/GM;

plot(-aa,0,'.','markersize',ms,'color','k')
yy = 0.15;
plot([-aa -aa],[0 yy],'-','color','k')
text(-aa,1.1*yy,'$GH(\omega_P) = -\displaystyle\frac{1}{G_M}$','interpreter','latex','verticalalignment','bottom','horizontalalignment','center')

plot([0 -cosd(PM)],[0 -sind(PM)],'-','color',colgrey,'linewidth',1.5)
plot(-cosd(PM),-sind(PM),'.','markersize',ms,'color','k')
%text(0.1+mean([0 -cosd(PM)]),mean([0 -sind(PM)]),'1')

plot(-cosd(PM)*[1 1]+[0 yy],-sind(PM)*[1 1]+[0 0],'-','color','k')
text(-cosd(PM)*[1 1]+yy,-sind(PM)*[1 1],'~$|GH(\omega_G)| = 1$','interpreter','latex','verticalalignment','middle','horizontalalignment','left')

rr = 0.4;
text(-rr*cosd(PM/2.5),-rr*sind(PM/2.5),'$\Phi_M$','interpreter','latex')


axis equal
axis off

saveas(gca,'gmpm.pdf')
