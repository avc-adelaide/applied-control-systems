%% Ultimate gain visualisation

s = tf('s');

Gall{1} = 1/(s+1)^4;
Gall{2} = 1/(s^2+2*s+5)/(s^2+s+15);

N = numel(Gall);

figure(1); clf; hold on
figuresize(12,10,'cm')

s = 1.1;

co = 0.6;

xline(0)
yline(0)

for ii = 1:N

  G = Gall{ii};
  gm = margin(G);
  K = gm*co;
  G = G*K;
  
  [RR,II] = nyquist(G,logspace(-2,2,2000));
  RR = squeeze(RR);
  II = squeeze(II);
  
  figure(1);
  hp = plot(RR,II,'linewidth',2);
  
  dcg = dcgain(G);
  plot(dcg,0,'k.','markersize',20)
  text(dcg,0.06,'$\omega=0$','horizontalalignment','left','interpreter','latex','backgroundcolor','white','margin',1)
  
  p1 = freqresp(G,1.7);
  plot(real(p1),imag(p1),'.','color',hp.Color,'markersize',12)
  switch ii
    case 1
      ha = 'right';
      va = 'top';
      xn = -0.01;
      yn = -0.01;
    case 2
      ha = 'left';
      va = 'top';
      xn = 0.01;
      yn = 0;
  end
  
  text(real(p1)+xn,imag(p1)+yn,['$G_{',num2str(ii),'}(j\omega_1)$'],...
    'interpreter','latex',...
    'horizontalalignment',ha,...
    'verticalalignment',va)
  
end

plot(-1,0,'dk','markersize',8,'markerfacecolor','black')

plot(-co,0,'sk','markersize',8,'markerfacecolor','black')

plot([-co -co],[-1 1],'k--')

axis([-1.1 1.1 -0.9 0.5])

grid on
box on
title('Nyquist plot')
xlabel('Real')
ylabel('Imaginary')
xticks([-0.8,-co,-0.4:0.4:0.8])
xticklabels({'$-0.8$','$a$','$-0.4$','$0$','$0.4$','$0.8$'});
set(gca,'TickLabelInterpreter','latex')

text(-co+0.05,-0.05,'$G(j\omega_c)$','interpreter','latex')

text(-0.77,-0.7,'$\uparrow~\omega~\textrm{incr.}$','interpreter','latex','backgroundcolor','white','margin',1)

text(0.1,0.3,'$\downarrow~\omega~\textrm{incr.}$','interpreter','latex','backgroundcolor','white','margin',1)

saveas(gcf,'ultimate-gain.pdf')
