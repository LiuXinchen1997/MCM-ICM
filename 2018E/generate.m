rands = [];

for i=1:1000;
    a = ceil(rand() * 25);
    rands = [rands 2075+a];
    
    a = ceil(rand() * 25);
    b = rand();
    if (b >= 0.75 && b < 0.9) || (b >= 0.1 && b < 0.25);
        if rand() >= 0.5;
            rands = [rands 2100 + a];
        else
            rands = [rands 2075 - a];
        end;
    end;
    
    a = ceil(rand() * 25);
    if rand() >= 0.9 || rand() <= 0.1;
        if rand() >= 0.5;
            rands = [rands ceil(2100 + 4 * rand() * a)];
        else
            rands = [rands ceil(2075 - 4 * rand() * a)];
        end;
    end;
end;

rands = rands';