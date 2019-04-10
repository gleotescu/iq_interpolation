
% calcul transformata Park abc->dq
load ('calc_fi_d.mat'); 
omega=0;t=0;
D_d=[];
Q_d=[];
for i=1:3:57 %end=cate coloane are matricea
    fiaD=fabcD(:,i);
    fibD=fabcD(:,i+1);
    ficD=fabcD(:,i+2);
    fidD=(2/3)*(fiaD*cos(omega*t)+fibD*cos(omega*t-2*pi/3)+ficD*cos(omega*t+2*pi/3));
    fiqD=(-2/3)*(fiaD*sin(omega*t)+fibD*sin(omega*t-2*pi/3)+ficD*sin(omega*t+2*pi/3));
    D_d=[D_d fidD];
    Q_d=[Q_d fiqD];
end


% cod original
% load('fia_q_140.mat');load('fib_q_140.mat');load('fic_q_140.mat');
% omega=0;t=0;
% fia=fabcD(:,1);fib=fabcD(:,2);fic=fabcD(:,3);
% fid=(2/3)*(fia*cos(omega*t)+fib*cos(omega*t-2*pi/3)+fic*cos(omega*t+2*pi/3));
% fiq=(-2/3)*(fia*sin(omega*t)+fib*sin(omega*t-2*pi/3)+fic*sin(omega*t+2*pi/3));
% i=0:20:220;
% plot(i,fid,i,fiq);grid


load ('calc_fi_q.mat');
omega=0;t=0;
D_q=[];
Q_q=[];
for j=1:3:57 %end=cate coloane are matricea
    fiaQ=fabcQ(:,j);
    fibQ=fabcQ(:,j+1);
    ficQ=fabcQ(:,j+2);
    fiqQ=(-2/3)*(fiaQ*sin(omega*t-pi/2)+fibQ*sin(omega*t-2*pi/3-pi/2)+ficQ*sin(omega*t+2*pi/3-pi/2));
    fidQ=(2/3)*(fiaQ*cos(omega*t-pi/2)+fibQ*cos(omega*t-2*pi/3-pi/2)+ficQ*cos(omega*t+2*pi/3-pi/2));
    D_q=[D_q fidQ];
    Q_q=[Q_q fiqQ];
end
i=0:10:180;
j=0:10:180;

figure;
d=subplot(2,1,1);
plot(i, D_d);grid %D_d este fluxul pe axa D
xlabel('I_d');
ylabel('Flux_d cu Id var si Iq const');
legend('Iq=180 A','Iq=170 A','Iq=160 A','Iq=150 A','Iq=140 A','Iq=130 A','Iq=120 A','Iq=110 A','Iq=100 A','Iq=90 A','Iq=80 A','Iq=70 A','Iq=60 A','Iq=50 A','Iq=40 A','Iq=30 A','Iq=20 A','Iq=10 A','Iq=0 A');
%%%%%%
axis([0 180 0 0.23]);
q=subplot(2,1,2);
plot(i, Q_d);grid %D_d este fluxul pe axa D 
ylabel('Flux_q cu Id var si Iq const')
xlabel('I_d');
legend('Iq=180 A','Iq=170 A','Iq=160 A','Iq=150 A','Iq=140 A','Iq=130 A','Iq=120 A','Iq=110 A','Iq=100 A','Iq=90 A','Iq=80 A','Iq=70 A','Iq=60 A','Iq=50 A','Iq=40 A','Iq=30 A','Iq=20 A','Iq=10 A','Iq=0 A');
%%%%%%legend('fluxD Iq=220A', 'fluxQ Iq=220A');
%axis([0 70 0 0.2]);

figure;
d=subplot(2,1,1);
title('Flux_d')
plot(j, D_q); grid %Q_q este fluxul pe axa Q 
ylabel('Flux_d cu Iq var si Id const')
xlabel('I_q');
legend('Id=180 A','Id=170 A','Id=160 A','Id=150 A','Id=140 A','Id=130 A','Id=120 A','Id=110 A','Id=100 A','Id=90 A','Id=80 A','Id=70 A','Id=60 A','Id=50 A','Id=40 A','Id=30 A','Id=20 A','Id=10 A','Id=0 A');

q=subplot(2,1,2);
plot(j, Q_q); grid %Q_q este fluxul pe axa Q 
xlabel('I_q');
ylabel('Flux_q cu Iq var si Id const');
legend('Id=180 A','Id=170 A','Id=160 A','Id=150 A','Id=140 A','Id=130 A','Id=120 A','Id=110 A','Id=100 A','Id=90 A','Id=80 A','Id=70 A','Id=60 A','Id=50 A','Id=40 A','Id=30 A','Id=20 A','Id=10 A','Id=0 A');
%%%%%%legend('fluxD Id=220A', 'fluxQ Id=220A');
axis([0 180 -0.04 0.23]);

% initial
%%plot(i, D_d, i, Q_d);grid %D_d este fluxul pe axa D
%%xlabel('I_d');
%%%%%%legend('fluxD Iq=180A', 'fluxQ Iq=180A');

%%axis([0 180 0 0.2]);
%%q=subplot(2,1,2);
%%plot(j, D_q,j, Q_q); grid %Q_q este fluxul pe axa Q 
%%xlabel('I_q');
%%%%%%legend('fluxD Id=180A', 'fluxQ Id=180A');
%%axis([0 180 -0.04 0.2]);



%%load ('I.mat');%Id var @Iq constant
%load ('Iq.mat');
 %D_d - fluxD cu Id var si Iq const!!!!
 %Q_d - fluxQ cu Id var si Iq const
 %D_q - fluxD cu Iq var si Id const
 %Q_q - fluxQ cu Iq var si Id const!!!!
 %Iconst
 %Ivar

%%L_d=[];% - inductanta D cu Id var si Iq const
%%L_q=[];% - inductanta Q cu Iq var si Id const

%%L_d=rdivide(D_d,Ivar);
%%L_q=rdivide (Q_q,Ivar);
%%figure;
%%Ld=subplot(2,1,1);
%%plot(i, L_d);grid
%%xlabel('L_d=f(I_d)');
%%Lq=subplot(2,1,2);
%%plot(i, L_q); grid
%%xlabel('L_q=f(I_q)');
%axis([0 180 0 0.2]);


%dlmwrite('D_d.txt',i);
%dlmwrite('D_d.txt',D_d, 'delimiter',' ','-append');

%dlmwrite('Q_d.txt',i);
%dlmwrite('Q_d.txt',Q_d, 'delimiter',' ','-append');

