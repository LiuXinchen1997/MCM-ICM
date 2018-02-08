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
surf(x, y, z); % ��ά��ɫ����ͼ
%}

%{
% ����ɢ��ͼ
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
% ����Ӧ��������
x = -1:0.1:1;
y = cos(1./x);
figure;
fplot(@(x)cos(1./x), [-1,1]);
%}

%{
% ��ά���߻�ͼ
t = 0:0.1:8*pi;
plot3(sin(t), cos(t), t);
title('��������');
xlabel('sin(t)', 'FontWeight', 'bold', 'FontAngle', 'italic');
ylabel('cos(t)', 'FontWeight', 'bold', 'FontAngle', 'italic');
zlabel('t', 'FontWeight', 'bold', 'FontAngle', 'italic');
grid on;
%}

%{
% ��ά�������
% ƽ������������
[X, Y] = meshgrid(-2:0.1:2, -2:0.1:2);
Z = X .* exp(-X.^2 - Y.^2);
surf(X, Y, Z);
shading interp;
%}

%{
% ������ת��
t = pi:0.01:3*pi;
r = sin(t) + t;
cylinder(r, 30);
shading interp;
%}

%{
% ���ͼ
X = -2:2;
Y = [3,5,2,4,1; 5,4,2,3,5; 3,4,5,2,1];
area(X',Y');
legend('item1', 'item2', 'item3');
%}

x = [200, 360, 120, 400, 320];
pie3(x, [0 0 0 1 0]);