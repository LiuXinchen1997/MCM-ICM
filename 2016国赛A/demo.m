%风速为 12m/s 时：
disp('此时风速是 12m/s');
options = gaoptimset('PopInitRange', [0;2], 'Generations', 2000, 'StallGenLimit', 500);
[h, f] = ga(@fu, 1, options);

v = 36;
g = 9.8;
w = 0.8694 * 7 * g;

ffu = 1.025 * 1000 * g * pi * (25*0.001)*(25*0.001);
G0 = 1000 * g;
G = 10 * g - ffu;
G2 = 100 * g;
G3 = 1200 * g;
    
f0fu = 1.025 * 1000 * g * pi * h;
f1fu = 1.025 * 1000 * g * pi * (15 * 15 * 0.01 * 0.01);
Ffeng = 1.25*v*v*(2-h);
a = Ffeng / w;

b1 = atan(Ffeng/(f1fu+f0fu-G0-4*G-G2-G3));
a1 = atan(Ffeng/(f0fu-G0));
a2 = atan(Ffeng/(f0fu-G0-G));
a3 = atan(Ffeng/(f0fu-G0-2*G));
a4 = atan(Ffeng/(f0fu-G0-3*G));

Fla1 = (f0fu - G0) / cos(a1);
Fla4 = (Fla1*sin(a1)) / sin(a4);
a5 = atan(Fla4*sin(a4)/(Fla4*cos(a4)-G+ffu));
    
h0 = 18 - h - cos(a1) - cos(a2) - cos(a3) - cos(a4) - cos(a5);
    
s0 = 22.05;
sm = sqrt(h0*h0+2*a*h0);

if (s0>=sm)
    disp('自由悬链');
    %k = (h0+2*a) / a;
    k = (h0+a) / a;
    xm = a * log(abs(k + sqrt(k*k-1))); %此式子应当特别注意
    s = a*(exp(xm/a)+exp(-1*xm/a))/2;
    L = (s0-s)+xm+sin(a1)+sin(a2)+sin(a3)+sin(a4)+sin(a5);
else
    disp('约束悬链');
    %k = (s0 * sqrt(0.25+a*a/(s0*s0-h0*h0)) - h0/2)/a+1;
    %xa = a * log(abs(k + sqrt(k*k-1))); %此式子应当特别注意
    %ya = a * (k - 1) - h0 / 2;
    %k2 = (h0+ya+a)/a;
    %xb = a * log(abs(k2 + sqrt(k2*k2-1))); %此式子应当特别注意
    %L = xb - xa + sin(a1) + sin(a2) + sin(a3) + sin(a4) + sin(a5);
    ya = 22.05 * sqrt(0.25+a*a/(22.05*22.05-h0*h0)) - h0/2 - a;
    ka = ya/a + 1;
    xa = a * log(abs(ka + sqrt(ka*ka-1))); %\\\\\\\\\\\\\
    
    yb = ya + h0;
    kb = yb/a + 1;
    xb = a * log(abs(kb + sqrt(kb*kb-1)));  %\\\\\\\\\\\\\\\
    L = (xb - xa) + sin(a1) + sin(a2) + sin(a3) + sin(a4) + sin(a5);
end

%由弧度制转化成角度制
a1 = a1 * 180 / pi;
a2 = a2 * 180 / pi;
a3 = a3 * 180 / pi;
a4 = a4 * 180 / pi;
a5 = a5 * 180 / pi;

fprintf('吃水深度： %d\n', h);
fprintf('四根钢管的倾斜角度分别为： %d %d %d %d\n', a1, a2, a3, a4);
fprintf('钢桶倾斜角度为： %d\n', a5);
fprintf('轨迹方程参数为： %d\n', a);
fprintf('游动区域为： %d\n',L);