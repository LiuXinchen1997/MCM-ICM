close all;clc;clear;
figure;
p=0.3; % 概率p
f=6e-5; % 概率f
axes;rand('state',0);
set(gcf,'DoubleBuffer','on');
% S=round((rand(300)/2+0.5)*2);
S=round(rand(300)*2);
Sk=zeros(302);
Sk(2:301,2:301)=S;
% 红色表示正在燃烧(S中等于2的位置)
% 绿色表示绿树(S中等于1的位置)
% 黑色表示空格位(S中等于0的位置)
C=zeros(302,302,3);
R=zeros(300);
G=zeros(300);
R(S==2)=1;
G(S==1)=1;
C(2:301,2:301,1)=R;
C(2:301,2:301,2)=G;
Ci=imshow(C);ti=0;
tp=title(['T = ',num2str(ti)]);
while 1;
    ti=ti+1;St=Sk;
    St(Sk==2)=0; % for rule (1)
    Su=zeros(302);Sf=Sk;Sf(Sf<1.5)=0;Sf=Sf/2;
    Su(2:301,2:301)=Sf(1:300,1:300)+Sf(1:300,2:301)+Sf(1:300,3:302)+Sf(2:301,1:300)+Sf(2:301,3:302)+Sf(3:302,1:300)+Sf(3:302,2:301)+Sf(3:302,3:302);
    St(Sf>0.5)=2; % for rule (2)
    Se=Sk(2:301,2:301);Se(Se<0.5)=4;Se(Se<3)=0;Se(Se>3)=1;
    St(2:301,2:301)=St(2:301,2:301)+Se.*(rand(300)<p); %for rule (3)
    Ss=zeros(302);Ss(Sk==1)=1;
    Ss(2:301,2:301)=Ss(1:300,1:300)+Ss(1:300,2:301)+Ss(1:300,3:302)+Ss(2:301,1:300)+Ss(2:301,3:302)+Ss(3:302,1:300)+Ss(3:302,2:301)+Ss(3:302,3:302);
    Ss(Ss<7.5)=0;Ss(Ss>7.5)=1;
    d=find(Ss==1 & Sk==1);
    for k=1:length(d);
        r=rand;
        St(d(k))=round(2*(r<=f)+(r>f));
    end; % for rule (4)
    Sk=St;
    R=zeros(302);
    G=zeros(302);
    R(Sk==2)=1;
    G(Sk==1)=1;
    C(:,:,1)=R;
    C(:,:,2)=G;
    set(Ci,'CData',C);
    set(tp,'string',['T = ',num2str(ti)])
    pause(0.2);
end