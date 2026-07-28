%% Time delays

close all
clear all


%%

figure(99); clf; hold on
figuresize(12,12,'cm')

s = tf('s');
GH1 = 2/(s+1)/(s+2);
tau = 0.2;
GH2 = GH1; GH2.OutputDelay = tau; 

[re1,im1] = nyquist(GH1,logspace(-3,2));
plot(re1(:),im1(:))
[re1,im1] = nyquist(GH2,logspace(-3,2));
plot(re1(:),im1(:))
grid on

xline(0)
yline(0)
axis square
axis equal
axis([-0.5 1.1 -0.8 0.8])
set(gca,'xtick',-0.4:0.2:1.0)

for ff = [0.5 1 2 4]
  [re1,im1] = nyquist(GH1,ff);
  [re2,im2] = nyquist(GH2,ff);
  hold on
  plot([re1 re2],[im1 im2],'k.-','markersize',8)
  t = text(re2,im2,[num2str(ff),' ']);
  set(t,'horizontalalignment','r')
  if ff == 0.5
    set(t,'horizontalalignment','l')
    set(t,'verticalalignment','t')
  end
  if ff == 1
    set(t,'verticalalignment','t')
  end
  if ff == 4
    set(t,'verticalalignment','bottom')
  end
end

ll = legend('$\tau=0$',['$\tau=',num2str(tau),'$']);
set(ll,'interpreter','latex')

print -dpdf timedelaynyq.pdf

%%

figure(11)
bode(GH1,GH2)

%%

figure(2); clf; hold on
figuresize(12,12,'cm')

s = tf('s');
TD = exp(-s);
bode(TD)

print -dpdf puretimedelaybode.pdf