function z = fu(h)
    v = 12;
    g = 9.8;
    w = 0.8694 * 7 * g;
    
    G0 = 1000 * g;
    G = 10 * g;
    G2 = 100 * g;
    G3 = 1200 * g;
    
    f0fu = 1.025 * 1000 * g * pi * h;
    f1fu = 1.025 * 1000 * g * pi * (15 * 15 * 0.01 * 0.01);
    Ffeng = 1.025*v*v*(2-h);
    a = Ffeng / w;
    
    b1 = atan(Ffeng/(f1fu+f0fu-G0-4*G-G2-G3));
    a1 = atan(Ffeng/(f0fu-G0));
    a2 = atan(Ffeng/(f0fu-G0-2*G));
    a3 = atan(Ffeng/(f0fu-G0-2*G));
    a4 = atan(Ffeng/(f0fu-G0-3*G));
    
    h0 = 18 - h - cos(a1) - cos(a2) - cos(a3) - cos(a4) - cos(b1);
    
    s0 = 22.05;
    sm = sqrt(h0*h0+2*a*h0);
    if (s0>=sm)
    
    F5 = (s0*sqrt(0.25+a*a/(s0*s0)) )*w;
    
    if(h>=0 && h<=2)
        z = F5*sin(b1) - Ffeng;
    else
        z = inf;
    end