%{
x = 0:pi/4:4*pi;
y = sin(x);
i = find(y>0.5);
x(i) = NaN;
plot(x, y, 'b');
%}

%{
subplot(2,2,1);
ezplot('x^2+y^2-9'); axis equal;
%}

%{
xi = -10:0.5:10;
yi = -10:0.5:10;
[x, y] = meshgrid(xi, yi);
z = sin(sqrt(x.^2+y.^2))./sqrt(x.^2+y.^2);
surf(x, y, z); % 三维着色表面图
%}

%{
% 绘制散点图
x = 1:10;
y = x + rand(size(x));
z = x + rand(size(x));
scatter3(x, y, z, 'filled', 'r');
hold on;
x = 1:10;
y = x + rand(size(x));
z = x + rand(size(x));
scatter3(x, y, z, 'filled', 'b');
%}

%{
% 自适应函数曲线
x = -1:0.1:1;
y = cos(1./x);
figure;
fplot(@(x)cos(1./x), [-1,1]);
%}

t = 0:0.1:8*pi;
plot3(sin(t), cos(t), t);
title('螺旋曲线');
xlabel('sin(t)', 'FontWeight', 'Font');