function encirclement(G,xy,r,N,Gstr)

%% examples of encirclement

s = tf('s');
theta = linspace(0,2*pi,N);
p = [xy(1)+r*cos(theta);xy(2)+r*sin(theta)];

%%

subplot(1,2,1); cla; hold on

plot(p(1,:),p(2,:))

plot(real(roots(G.num{1})),imag(roots(G.num{1})),'ko','markersize',10)
plot(real(roots(G.den{1})),imag(roots(G.den{1})),'r*','markersize',10)

t = 1.2*max([abs(xlim),abs(ylim)]);
axis([-t t -t t])
plot(xlim,[0 0],'k-')
plot([0,0],ylim,'k-')
axis tight

for ii = 1:(N-1)
  text(p(1,ii),p(2,ii),char('a'+ii-1),'margin',0.5,'horizontalalignment','center','backgroundcolor','white')
end

box on
xlabel('Real')
ylabel('Imag')
title({'PZMAP + CONTOUR','(poles red, zeros black)'})

%%

subplot(1,2,2); cla; hold on

q = nan(1,N);
for ii = 1:N
  q(ii) = evalfr(G,p(1,ii)+p(2,ii)*1i);
end

plot(real(q),imag(q))

t = 1.2*max([abs(xlim),abs(ylim)]);
axis([-t t -t t])
plot(xlim,[0 0],'k-')
plot([0,0],ylim,'k-')
axis tight

for ii = 1:(N-1)
  text(real(q(ii)),imag(q(ii)),char('A'+ii-1),'margin',0.5,'horizontalalignment','center','backgroundcolor','white')
end

box on
xlabel('Real')
ylabel('Imag')
title({['CONTOUR MAPPED THROUGH ',Gstr,'(s)'],['(e.g., A = ',Gstr,'(a), B = ',Gstr,'(b), etc.)']})