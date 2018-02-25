% x1=linspace(0,35);
% y1=x1;
% 
% plot(x1,y1);
% hold on;
% 
% x2=linspace(13.3,33);
% y2=(-28./(x2-12))+22.55;
% plot(x2,y2);
% hold on;
% 
% axis([0 38 0 38]);
% 
% text(17, 17,'*','color','m')
% text(16, 18,'A','color','k')
% text(25, (-28/(25-12))+22.55, '*', 'color', 'm');
% text(25, 19,'B','color','k')

% x = linspace(3,17);
% y = -(0.5.*x - 5).^2+15;
% plot(x,y);
% axis([-1 20 -1 20]);


x1 = linspace(16,54);
y1 = -0.2.*(x1-35).^2+18;
x2 = linspace(6,14);
y2 = -0.5.*(x2-10).^2+7;
x3 = linspace(56,64);
y3 = -0.5.*(x3-60).^2+7;
plot(x1,y1); hold on;
plot(x2,y2); hold on;
plot(x3,y3); hold on;
axis([0 70 0 20]);








