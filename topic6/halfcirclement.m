function halfcirclement(G,r,N,Gstr)

s = tf('s');
theta = linspace(0,pi,N);
p1 = [zeros(1,N);linspace(r,-r,N)];
p2 = [r*cos(pi/2-theta);r*sin(pi/2-theta)];

%%

subplot(1,2,1); cla; hold on

plot(p1(1,:),p1(2,:),'.-','color',[0 0.8 0.2],'linewidth',2,'markersize',15)
plot(p2(1,:),p2(2,:),'.-','color',[0 0.2 0.8],'linewidth',2,'markersize',15)

plot(real(roots(G.num{1})),imag(roots(G.num{1})),'ko','markersize',10)
plot(real(roots(G.den{1})),imag(roots(G.den{1})),'r*','markersize',10)

t = 1.2*max([abs(xlim),abs(ylim)]);
axis([-t t -t t])
h1 = plot(xlim,[0 0],'-','color',0.5*[1 1 1]);
h2 = plot([0,0],ylim,'-','color',0.5*[1 1 1]);
uistack(h1,'bottom');
uistack(h2,'bottom');
axis tight


box on
xlabel('Real')
ylabel('Imag')
title({'PZMAP + CONTOUR','(poles red, zeros black)'})

%%

subplot(1,2,2); cla; hold on

q1 = nan(1,N);
q2 = nan(1,N);
for ii = 1:N
  q1(ii) = evalfr(G,p1(1,ii)+p1(2,ii)*1i);
  q2(ii) = evalfr(G,p2(1,ii)+p2(2,ii)*1i);
end

plot(real(q1),imag(q1),'.-','color',[0 0.8 0.2],'linewidth',2,'markersize',15)
plot(real(q2),imag(q2),'.-','color',[0 0.2 0.8],'linewidth',2,'markersize',15)

t = 1.2*max([abs(xlim),abs(ylim)]);
axis([-t t -t t])
h1 = plot(xlim,[0 0],'-','color',0.5*[1 1 1]);
h2 = plot([0,0],ylim,'-','color',0.5*[1 1 1]);
uistack(h1,'bottom');
uistack(h2,'bottom');
axis tight

box on
xlabel('Real')
ylabel('Imag')
title({['CONTOUR MAPPED THROUGH ',Gstr,'(s)'],['(e.g., A = ',Gstr,'(a), B = ',Gstr,'(b), etc.)']})