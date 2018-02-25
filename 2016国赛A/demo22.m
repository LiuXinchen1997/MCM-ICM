function gg = demo22()
    g = 9.8;
    global G3;
    %G3 = 1200 * g;
    G3 = 6400 * g;
    options = gaoptimset('PopInitRange', [0;2], 'Generations', 500, 'StallGenLimit', 500);
    [h, f] = ga(@lbw, 1, options);

    v = 36;
    w = 0.8694 * 7 * g;

    ffu = 1.025 * 1000 * g * pi * (25*0.001)*(25*0.001);
    G0 = 1000 * g;
    G = 10 * g - ffu;
    G2 = 100 * g;

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
        ya = 22.05 * sqrt(0.25+a*a/(22.05*22.05-h0*h0)) - h0/2 - a;
        ka = ya/a + 1;
        xa = a * log(abs(ka + sqrt(ka*ka-1))); %\\\\\\\\\\\\\

        yb = ya + h0;
        kb = yb/a + 1;
        xb = a * log(abs(kb + sqrt(kb*kb-1)));  %\\\\\\\\\\\\\\\
        L = (xb - xa) + sin(a1) + sin(a2) + sin(a3) + sin(a4) + sin(a5);
    end
    
    %while((tan(a5) < 0 || tan(a5) > tan(5*pi/180)) || ((exp(xa/a)-exp(-1*xa/a))/2 > tan(16*pi/180) || (exp(xa/a)-exp(-1*xa/a))/2 <0))
    while(((tan(a5) >= 0) && (tan(a5) <= tan(1.48*pi/180))) && (((exp(xa/a)-exp(-1*xa/a))/2 <= tan(16*pi/180)) && ((exp(xa/a)-exp(-1*xa/a))/2 >= 0)))
        [h, f] = ga(@lbw, 1, options);
        G3 = G3 + 1;
        
        ffu = 1.025 * 1000 * g * pi * (25*0.001)*(25*0.001);
        G0 = 1000 * g;
        G = 10 * g - ffu;
        G2 = 100 * g;

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
        
        ya = 22.05 * sqrt(0.25+a*a/(22.05*22.05-h0*h0)) - h0/2 - a;
        ka = ya/a + 1;
        xa = a * log(abs(ka + sqrt(ka*ka-1))); %\\\\\\\\\\\\\
               
        fprintf('%d %d\n',tan(a5), (exp(xa/a)-exp(-1*xa/a))/2);
        fprintf('%d %d\n',G3, h);
    end
    disp('hhh');
    disp(G3)
    
    gg = G3;
end



function z = lbw(h)
    v = 36;
    g = 9.8;
    w = 0.8694 * 7 * g;
    
    ffu = 1.025 * 1000 * g * pi * (25*0.001)*(25*0.001);
    G0 = 1000 * g;
    G = 10 * g - ffu;
    G2 = 100 * g;
    
    f0fu = 1.025 * 1000 * g * pi * h;
    f1fu = 1.025 * 1000 * g * pi * (15 * 15 * 0.01 * 0.01);
    Ffeng = 1.25*v*v*(2-h);
    a = Ffeng / w;
    
    global G3;
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
        z = inf;
    else
        F5 = (s0*sqrt(0.25+a*a/(s0*s0+h0*h0)) - h0/2) * w;
        if(h>=0 && h<=2)
            z = abs(f1fu + f0fu - G0 - 4*G - G2 - G3 - cos(a5)*w*(22.05*sqrt(0.25+a*a/(22.05*22.05+h*h))-h/2-a));
        else
            z = inf;
        end
    end
end