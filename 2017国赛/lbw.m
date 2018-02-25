function y=lbw(x)
    % x(1) == angle
    % x(2) == d
    % tan(angle) = k
    
    k = tan(x(1)*pi/180 + pi/2);
    a = 40;
    b = 15;
    
    global tuoyuanid;
    len_id = size(tuoyuanid);  % len_id(2)
    
    global tuoyuan;
    beijianshu = sum(tuoyuan);
    
    global miu;
    
    l_sum = 0;
    max_value = max(tuoyuan);
    [m, n] = find(tuoyuan == max_value);
    l_sum = l_sum + 2 * sqrt( a*a*b*b*(1+k*k)*(a*a*k*k - b*b*0*0 + b*b)  / ((a*a*k*k+b*b)*(a*a*k*k+b*b)) );
    
    for i=n(1)+1:len_id(2);
        l = 2 * sqrt( a*a*b*b*(1+k*k)*(a*a*k*k - b*b* (i-n(1))*x(2) * (i-n(1))*x(2)/(cos(atan(k)) * cos(atan(k))) + b*b) / ((a*a*k*k + b*b)*(a*a*k*k+b*b)) );
        
        l_sum = l_sum + l;
    end;
    
    for i=1:n(1)-1;
        l = 2 * sqrt( a*a*b*b*(1+k*k)*(a*a*k*k - b*b*  i*x(2)  *  i*x(2) /(cos(atan(k)) * cos(atan(k))) +  b*b) / ( (a*a*k*k + b*b)*(a*a*k*k+b*b) ) );

        l_sum = l_sum + l;
    end;
    
%     fprintf('beijianshu:  %f \n', beijianshu);
%     fprintf('l_sum:  %f \n', l_sum*miu);
    
    
%     if x(1)*x(2)*len_id(2) > 80;
%         y = inf;
    if x(2) < 0.26 || x(2) > 0.28 || x(1) < 30 || x(1) > 240;
        y = inf;
    else
        y = abs(beijianshu - miu*l_sum);
    end;
    
%     fprintf('y  : %f\n', y);
end