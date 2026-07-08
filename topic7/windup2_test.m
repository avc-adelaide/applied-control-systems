
clear all
close all

lw = 1.5;
Tmax = 50;

%% print simulink


Kd = 2.7;
Ti = 7.5;
Td = 0.8;
N = 10;
S = 0.1;
Tt = 9999;

%open windup2
%saveas(get_param(gcs,'Handle'),'windup_act_tracking.pdf')


%open windup3
%saveas(get_param(gcs,'Handle'),'windup_anti_sat.pdf')



%%


Kd = 2.7;
Ti = 7.5;
Td = 0.8;
N = 10;
S = 0.1;
Tt = 9999;

sim('windup2')

figure(1); clf; hold on
figuresize(30,10,'cm')

R = get(logsout,'R');
Y = get(logsout,'Y');
U = get(logsout,'U');
Up = get(logsout,'Up');
Ui = get(logsout,'Ui');
Ud = get(logsout,'Ud');
Usat = get(logsout,'Usat');
E = get(logsout,'E');

p = [12 18.3];

subplot(1,3,1); cla; hold on
plot(Y.Values,'linewidth',lw)
plot(R.Values,'--','linewidth',lw)
for pp = p
  plot(pp*[1 1],ylim(),'k:','linewidth',1)
end
legend('Y','R','location','northeast')
box on
xlabel('Time, s')
ylabel('Y')

subplot(1,3,2); cla; hold on
plot([0 Tmax],[0 0],'k-','linewidth',1)
plot(E.Values,'linewidth',lw)
for pp = p
  plot(pp*[1 1],ylim(),'k:','linewidth',1)
end
title('')
xlabel('Time, s')
ylabel('E')
box on

subplot(1,3,3); cla; hold on
plot(U.Values,'linewidth',lw)
plot(Usat.Values,'linewidth',lw)
plot(Up.Values,'linewidth',lw)
plot(Ud.Values,'linewidth',lw)
plot(Ui.Values,'linewidth',lw*1.5)
for pp = p
  plot(pp*[1 1],ylim(),'k:','linewidth',1)
end

xlabel('Time, s')
ylabel('U')
legend('U','Usat','Up','Ud','Ui','location','northeast')
box on

saveas(gcf,'windup_s3.pdf')


%%

if ~exist('Ysat')
  Ysat = Y;
end

Tmax = 50;

Kd = 2.7;
Ti = 7.5;
Td = 0.8;
N = 10;
S = 0.1;
Tt = sqrt(Ti*Td);

sim('windup2')

figure(1); clf; hold on
figuresize(30,10,'cm')

R = get(logsout,'R');
Y = get(logsout,'Y');
U = get(logsout,'U');
Up = get(logsout,'Up');
Ui = get(logsout,'Ui');
Ud = get(logsout,'Ud');
Usat = get(logsout,'Usat');
E = get(logsout,'E');

p = [];

subplot(1,3,1); cla; hold on
hp = plot(Y.Values,'linewidth',lw);
plot(Ysat.Values,'linewidth',1,'color',hp.Color)
plot(R.Values,'--','linewidth',lw)
for pp = p
  plot(pp*[1 1],ylim(),'k:','linewidth',1)
end
legend('Y','Y windup','R','location','northeast')
box on
xlabel('Time, s')
ylabel('Y')

subplot(1,3,2); cla; hold on
plot([0 Tmax],[0 0],'k-','linewidth',1)
plot(E.Values,'linewidth',lw)
for pp = p
  plot(pp*[1 1],ylim(),'k:','linewidth',1)
end
title('')
xlabel('Time, s')
box on

subplot(1,3,3); cla; hold on
plot(U.Values,'linewidth',lw)
plot(Usat.Values,'linewidth',lw)
plot(Up.Values,'linewidth',lw)
plot(Ud.Values,'linewidth',lw)
plot(Ui.Values,'linewidth',lw*1.5)
for pp = p
  plot(pp*[1 1],ylim(),'k:','linewidth',1)
end

xlabel('Time, s')
ylabel('U')
legend('U','Usat','Up','Ud','Ui','location','northeast')
box on

saveas(gcf,'windup_anti_Tt.pdf')