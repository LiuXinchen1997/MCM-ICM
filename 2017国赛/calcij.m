function [i, j] = calcij(x, y)
    % assert: x,y均在(-50,50)之间
    s = 100 / 256;  % 每一个小方格的边长
    if x >= 0;
        nx = floor(x / s);
    else
        nx = ceil(x/s);
    end;
    
    j = nx + 129;
    
    if y >= 0;
        ny = floor(y/s);
        i = 129 - ny;
    else
        ny = ceil(y/s);
        i = 129 - ny;
    end;
    
    % i = ny + 129;
    
end

