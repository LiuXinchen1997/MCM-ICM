function y = nihe_fun(can, x)
    % can(1) == k
    % can(2) == d
    global miu;
    
    a = 40;
    b = 15;
    
    global tuoyuan;
    max_value = max(tuoyuan);
    [m, maxn] = find(tuoyuan == max_value);
    % x - maxn;
    l = 2 * sqrt( a*a*b*b*(1+can(1)*can(1))  * (a*a*can(1)*can(1) - b*b*  can(2)*can(1)*can(2)*can(1).*(x-maxn).^2  +  b*b) / ( (a*a*can(1)*can(1) + b*b)*(a*a*can(1)*can(1)+b*b) ) );
    y = miu .* l;
end

