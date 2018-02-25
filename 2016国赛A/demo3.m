function [] = demo3()
    lis = [3.2, 7, 12.5, 19.5, 28.12];
    ds = [0.078, 0.105, 0.12, 0.15, 0.18];
    Hs = 16:0.5:20;
    
    global li;
    global d;
    global H;
    global a1;
    global a2;
    global a3;
    global a4;
    global a5;
    global en;
    global h;
    
    global zm;
    global G3;
    global n;
    global k;
    
    nns = zeros(length(lis), length(Hs));
    ks = zeros(length(lis), length(Hs));
    G3s = zeros(length(lis), length(Hs));
    zms = zeros(length(lis), length(Hs));
    
    a1s = zeros(length(lis), length(Hs));
    a2s = zeros(length(lis), length(Hs));
    a3s = zeros(length(lis), length(Hs));
    a4s = zeros(length(lis), length(Hs));
    a5s = zeros(length(lis), length(Hs));
    ens = zeros(length(lis), length(Hs));
    hs = zeros(length(lis), length(Hs));
    
    options = gaoptimset('PopInitRange', [0;2], 'Generations', 500, 'StallGenLimit', 500);
    
    
    
    %for i=1:length(lis)
        i = 4;
        li = lis(i);
        d = ds(i);
        for j = 1:length(Hs)
            H = Hs(j);
            [h, f] = ga(@func, 1, options);
            
            zms(i,j) = zm;
            G3s(i,j) = G3;
            disp(n);
            nns(i,j) = n;
            disp(k);
            ks(i,j) = k;
            a1s(i,j) = a1;
            a2s(i,j) = a2;
            a3s(i,j) = a3;
            a4s(i,j) = a4;
            a5s(i,j) = a5;
            ens(i,j) = en;
            hs(i,j) = h;
        end
    %end
    
    
    
    
    disp('n');
    for i=1:length(lis)
        for j = 1:length(Hs)
            fprintf('%d ', nns(i,j))
        end
        fprintf('\n');
    end
    fprintf('\n');
    
    disp('G3s');
    for i=1:length(lis)
        for j = 1:length(Hs)
            fprintf('%d ', G3s(i,j))
        end
        fprintf('\n');
    end
    fprintf('\n');
    
    disp('zms');
    for i=1:length(lis)
        for j = 1:length(Hs)
            fprintf('%d ', zms(i,j))
        end
        fprintf('\n');
    end
    fprintf('\n');
    
    disp('ks');
    for i=1:length(lis)
        for j = 1:length(Hs)
            fprintf('%d ', ks(i,j))
        end
        fprintf('\n');
    end
    fprintf('\n');
    
    disp('a1');
    for i=1:length(lis)
        for j = 1:length(Hs)
            fprintf('%d ', a1s(i,j))
        end
        fprintf('\n');
    end
    fprintf('\n');
    
    disp('a2');
    for i=1:length(lis)
        for j = 1:length(Hs)
            fprintf('%d ', a2s(i,j))
        end
        fprintf('\n');
    end
    fprintf('\n');
    
    disp('a3');
    for i=1:length(lis)
        for j = 1:length(Hs)
            fprintf('%d ', a3s(i,j))
        end
        fprintf('\n');
    end
    fprintf('\n');
    
    disp('a4');
    for i=1:length(lis)
        for j = 1:length(Hs)
            fprintf('%d ', a4s(i,j))
        end
        fprintf('\n');
    end
    fprintf('\n');
    
    disp('a5');
    for i=1:length(lis)
        for j = 1:length(Hs)
            fprintf('%d ', a5s(i,j))
        end
        fprintf('\n');
    end
    fprintf('\n');
    
    disp('ens');
    for i=1:length(lis)
        for j = 1:length(Hs)
            fprintf('%d ', ens(i,j))
        end
        fprintf('\n');
    end
    fprintf('\n');
    
    disp('hs');
    for i=1:length(lis)
        for j = 1:length(Hs)
            fprintf('%d ', hs(i,j))
        end
        fprintf('\n');
    end
    fprintf('\n');
end


function z = func(h)
    global li;
    global d;
    global H;
    global en;
    
    wucha1 = tan(30*pi/180);    % wucha1值越大，n越小   要想n增大，wucha1应当尽量小；要想n减小，wucha1应当尽量大
    wucha2 = d;
    vhai = 1.5;
    vfeng = 36;
    Thai = 374 * vhai * vhai * (50 * 0.001);
    g = 9.8;
    
    G = 10*g;
    G0 = 1000 * g;
    G2 = 100 * g;
    ffu = 1.025 * 1000 * g * pi * 25 * 25 * 0.001 * 0.001;
    f1fu = 1.025 * 1000 * g * pi * 15 * 15 * 0.01 * 0.01;
    T1hai = 374 * vhai * vhai * (30 * 0.01);
    
    w = 0.8694;
    
    P = w*li*g;
     
    %\\\\\\\\\\\\\\\\涉及到h的 变量
    F0hai = 374 * vhai * vhai * 2 * (2-h);
    f0fu = 1.025 * 1000 * g * pi * h;
    Ffeng = 0.625 * vfeng * vfeng * 2 * (2-h);
    
    global a1;
    a1 = atan((F0hai+Ffeng) / (f0fu-G));
    global a2;
    a2 = atan( ( Thai * cos(a1) + F0hai + Ffeng ) / (f0fu - G0 - G + ffu) );
    global a3;
    a3 = atan( ( Thai * (cos(a1) + cos(a2)) + F0hai + Ffeng ) / (f0fu - G0 - 2*G + 2*ffu) );
    global a4;
    a4 = atan( ( Thai * (cos(a1) + cos(a2) + cos(a3)) + F0hai + Ffeng ) / (f0fu - G0 - 3*G + 3*ffu) );
    global a5;
    a5 = atan( ( Thai * (cos(a1) + cos(a2) + cos(a3) + cos(a4)) + F0hai + Ffeng ) / (f0fu - G0 - 4*G + 4*ffu) );
    
    sita = zeros(1,1000);
    Ts = zeros(1,1000);
    D = zeros(1,1000);
    F = zeros(1,1000);
    x = zeros(1, 1000);
    y = zeros(1, 1000);
    
    x(1) = 0;
    y(1) = 0;
    sita(1) = 16*pi/180;  %\\\\\\\\\\\\ 需要修正的地方！
    %sita(1) = 0;  %\\\\\\\\\\\\\
    Ts(1) = 100;  %Ts(1) = 841.5 * li / 7 + 100;
    D(1) = 0.5 * 1.025 * 1000 * 1.2 * vhai * vhai * sin(sita(1)) * li / 7;
    F(1) = 0.5 * 1.025 * 1000 * 1.2 * vhai * vhai * sin(sita(1)) * 0.2 * li / 7;
    global n;
    n = 1;
    global G3;
    G3 = f1fu + f0fu - G0 - 4*G + 4*ffu - G2 - Ts(n)*cos(sita(n));
    
    fenzi = T1hai*cos(a5) + Thai*(cos(a2)+cos(a3)+cos(a4)+cos(a5)) + F0hai + Ffeng;
    fenmu = f1fu - G2 - G3 + f0fu - G0 - 4*G + 4*ffu;
    
    while ( abs( tan(pi/2 - sita(n)) -  fenzi / fenmu  ) > wucha1 && n < 999 )   %\\\\\\\\\\\\\\/////////////////////
%         fprintf('分子： %d\n', fenzi);
%         fprintf('分母： %d\n', fenmu);
%         fprintf('%d\n', fenzi / fenmu);
        D(n) = 0.5 * 1.025 * 1000 * 1.2 * vhai * vhai * sin(sita(n)) * li / 7;
        F(n) = 0.5 * 1.025 * 1000 * 1.2 * vhai * vhai * cos(sita(n)) * 0.2 * li / 7;
        sita(n+1) = sita(n) + (P*cos(sita(n)) + D(n) * d) / Ts(n);
        Ts(n+1) = Ts(n) + P*sin(sita(n)) - F(n)*d;
%         x(n+1) = x(n) + cos(sita(n)) * d;
%         y(n+1) = y(n) + sin(sita(n)) * d;
        
        n = n + 1;
        G3 = f1fu + f0fu - G0 - 4*G + 4*ffu - G2 - Ts(n)*cos(pi/2 - sita(n));   %\\\\\\\\\\\\\\/////////////////////
        fenzi = T1hai*cos(a5) + Thai*(cos(a2)+cos(a3)+cos(a4)+cos(a5)) + F0hai + Ffeng;
        fenmu = f1fu - G2 - G3 + f0fu - G0 - 4*G + 4*ffu;
%         fprintf('*************   %d\n', abs(sita(n)));
%         fprintf('*************   %d\n', abs(fenmu));
    end

    global k;
    k = 1;
    while (abs( H - y(k) - sin(a1) -sin(a2) - sin(a3) - sin(a4) - sin(a5)-h ) > wucha2 && k <= n)
        x(k+1) = x(k) + cos(sita(k)) * d;
        y(k+1) = y(k) + sin(sita(k)) * d;
        k = k + 1;
    end
    
    %系数
    p1 = 1;
    p2 = 1;
    p3 = 0.01;
    if (tan(a5) >= 0 && tan(a5) <= tan(5*pi/180))
        if (h >= 0 && h <=2)
            z = p1 * h + p2 * a5 + p3 * (x(n) + sin(a1) + sin(a2) + sin(a3) + sin(a4) + sin(a5) + sin(sita(n)));  %\\\\\\\\\\///////// 将n换成k
            en = x(k) + sin(a1) + sin(a2) + sin(a3) + sin(a4) + sin(a5) + sin(sita(k));  %\\\\\\\\\\\\///////////  将n换成k
        else
            z = inf;
        end
    else
        z = inf;
    end
    
    global zm;
    zm = z;
end