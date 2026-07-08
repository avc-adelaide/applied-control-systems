
clear all
close all

%% print simulink

Tmax = 10;
Kp = 1;
Ti = 1;
Td = 0;
N = 20;
S = 1;

open nowindupmodel
saveas(get_param(gcs,'Handle'),'nowindup_blocks.pdf')

open windupmodel
saveas(get_param(gcs,'Handle'),'windup_blocks.pdf')


%%

Tmax = 10;

Kp = 5;
Ti = 9999;
Td = 0;
N = 20;

sim('nowindupmodel')

figure(1); clf; hold on
figuresize(30,10,'cm')

R = get(logsout,'R');
Y = get(logsout,'Y');
U = get(logsout,'U');
E = get(logsout,'E');

subplot(1,3,1); cla; hold on
plot(Y.Values,'linewidth',2)
plot(R.Values,'--','linewidth',2)
ylim([0 1.1])
legend('Y','R','location','southeast')
box on
xlabel('Time, s')
ylabel('Y')

subplot(1,3,2)
plot(E.Values,'linewidth',2)
ylim([0 1.1])
xlabel('Time, s')
title('')

subplot(1,3,3)
plot(U.Values,'linewidth',2)
%ylim([0 1.1])
xlabel('Time, s')
title('')
box on

saveas(gcf,'nowindup_kp.pdf')

%%

Tmax = 10;

Kp = 5;
Ti = 1;
Td = 0;
N = 20;

sim('nowindupmodel')

figure(1); clf; hold on
figuresize(30,10,'cm')

R = get(logsout,'R');
Y = get(logsout,'Y');
U = get(logsout,'U');
Up = get(logsout,'Up');
Ui = get(logsout,'Ui');
E = get(logsout,'E');

subplot(1,3,1); cla; hold on
plot(Y.Values,'linewidth',2)
plot(R.Values,'--','linewidth',2)
ylim([0 1.1])
legend('Y','R','location','southeast')
box on
xlabel('Time, s')
ylabel('Y')

subplot(1,3,2)
plot(E.Values,'linewidth',2)
ylim([0 1.1])
title('')
xlabel('Time, s')

subplot(1,3,3); cla; hold on
plot(U.Values,'linewidth',2)
plot(Up.Values,'linewidth',2)
plot(Ui.Values,'linewidth',2)
xlabel('Time, s')
ylabel('U')
legend('U','Up','Ui','location','east')
box on

saveas(gcf,'nowindup_ki.pdf')



%%

Tmax = 10;

Kp = 5;
Ti = 1;
Td = 1;
N = 10;

sim('nowindupmodel')

figure(1); clf; hold on
figuresize(30,10,'cm')

R = get(logsout,'R');
Y = get(logsout,'Y');
U = get(logsout,'U');
Up = get(logsout,'Up');
Ui = get(logsout,'Ui');
Ud = get(logsout,'Ud');
E = get(logsout,'E');

subplot(1,3,1); cla; hold on
plot(Y.Values,'linewidth',2)
plot(R.Values,'--','linewidth',2)
ylim([0 1.1])
legend('Y','R','location','southeast')
box on
xlabel('Time, s')
ylabel('Y')

subplot(1,3,2)
plot(E.Values,'linewidth',2)
ylim([0 1.1])
title('')
xlabel('Time, s')

subplot(1,3,3); cla; hold on
plot(U.Values,'linewidth',2)
plot(Up.Values,'linewidth',2)
plot(Ui.Values,'linewidth',2)
plot(Ud.Values,'linewidth',2)
%ylim([0 1.1])
xlabel('Time, s')
ylabel('U')
legend('U','Up','Ui','Ud')
box on

saveas(gcf,'nowindup_kd.pdf')


%%

Tmax = 10;

Kp = 5;
Ti = 1;
Td = 1;
N = 10;
S = 4;

sim('windupmodel')

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

subplot(1,3,1); cla; hold on
plot(Y.Values,'linewidth',2)
plot(R.Values,'--','linewidth',2)
ylim([0 1.1])
legend('Y','R','location','southeast')
box on
xlabel('Time, s')
ylabel('Y')

subplot(1,3,2)
plot(E.Values,'linewidth',2)
ylim([0 1.1])
title('')
xlabel('Time, s')

subplot(1,3,3); cla; hold on
plot(U.Values,'linewidth',2)
plot(Usat.Values,'linewidth',2)
xlabel('Time, s')
ylabel('U')
legend('U','Usat','location','north')
box on

saveas(gcf,'windup_s1.pdf')




%%

Tmax = 20;

Kp = 5;
Ti = 1;
Td = 1;
N = 10;
S = 4;

sim('windupmodeldisturb')

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

subplot(1,3,1); cla; hold on
plot(Y.Values,'linewidth',2)
plot(R.Values,'--','linewidth',2)
ylim([0 1.1])
legend('Y','R','location','northeast')
box on
xlabel('Time, s')
ylabel('Y')

subplot(1,3,2); cla; hold on
plot(E.Values,'linewidth',2)
plot([10 10],ylim(),'k:','linewidth',1)
plot(11*[1 1],ylim(),'k:','linewidth',1)
text(11,0.6,' Delay zone')
title('')
xlabel('Time, s')
box on

subplot(1,3,3); cla; hold on
plot(U.Values,'linewidth',2)
plot(Usat.Values,'linewidth',2)
plot(Ui.Values,'linewidth',2)
plot([10 10],ylim(),'k:','linewidth',1)
plot(11*[1 1],ylim(),'k:','linewidth',1)

xlabel('Time, s')
ylabel('U')
legend('U','Usat','Ui','location','northeast')
box on

saveas(gcf,'windup_s2.pdf')