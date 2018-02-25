function z = fu(h)
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
        F5 = (h0 + a) * w;
    else
        F5 = (s0*sqrt(0.25+a*a/(s0*s0+h0*h0)) - h0/2) * w;
    end
    
    if(h>=0 && h<=2)
        z = F5*sin(b1) - Ffeng;
    else
        z = inf;
    end