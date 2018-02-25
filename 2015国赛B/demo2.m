function [] = demo2()
    global in;
    global out;
    
    in = [
        240000 374469.225 24000
        240000 486809.9925 24000
        0 0 576550
        252968.96 201850.88 25296.896
        50593.792 201850.88 25296.896
    ];

    out = [
        63886.8984 1298159.98 267121.3805 5354.909918
        55901.0361 1185819.213 267121.3805 5354.909918
        129101.7 3862885 616908.5 12366.9975
        72942.4605 2182530.025 348553.3025 6987.353588
        72942.4605 2182530.025 348553.3025 6987.353588
    ];
    
    x = zeros(7,5);
    y = zeros(1,5);
    
    for i=1:5;
        [x(:,i), y(1, i)] = fmincon(@fun1, rand(7,1), [], [], [], [], zeros(7,1), [], @fun );
    end
    
    disp(x);
    disp(y);
    
    % 算出来的权重系数
    xx = x(:,3)';
    yy = y(1,3);
    
    disp(xx);
    h = zeros(1,5);
    
    for i=1:5;
        h(1,i) = ( out(i,1)*xx(1,1) + out(i,2)*xx(1,2)  + out(i,3)*xx(1,3)  +  out(i,4)*xx(1,4)  )   /   ( in(i,1)*xx(1,5) + in(i,2)*xx(1,6)  +  in(i,3) * xx(1,7)   );
    end;
    
    disp('hhhhh:');
    disp(h);
end




function f = fun1(x)
    global out;
    global in;
    f = (out(1,1) * x(1) + out(1,2) * x(2)  + out(1,3) * x(3)  +  out(1,4) *  x(4) )  /  ( in(1,1) * x(5) + in(1,2) * x(6)  + in(1,3) * x(7) );
end

function f = fun2(x)
    global out;
    global in;
    f = (out(2,1) * x(1) + out(2,2) * x(2)  + out(2,3) * x(3)  +  out(2,4) *  x(4) )  /  ( in(2,1) * x(5) + in(2,2) * x(6)  + in(2,3) * x(7) );
end

function f = fun3(x)
    global out;
    global in;
    f = (out(3,1) * x(1) + out(3,2) * x(2)  + out(3,3) * x(3)  +  out(3,4) *  x(4) )  /  ( in(3,1) * x(5) + in(3,2) * x(6)  + in(3,3) * x(7) );
end

function f = fun4(x)
    global out;
    global in;
    f = (out(4,1) * x(1) + out(4,2) * x(2)  + out(4,3) * x(3)  +  out(4,4) *  x(4) )  /  ( in(4,1) * x(5) + in(4,2) * x(6)  + in(4,3) * x(7) );
end

function f = fun5(x)
    global out;
    global in;
    f = (out(5,1) * x(1) + out(5,2) * x(2)  + out(5,3) * x(3)  +  out(5,4) *  x(4) )  /  ( in(5,1) * x(5) + in(5,2) * x(6)  + in(5,3) * x(7) );
end



function [g,h] = fun(x)
    global in;
    global out;
    
    g = [
        (out(1,1) * x(1) + out(1,2) * x(2)  + out(1,3) * x(3)  + out(1,4)  *  x(4) )  /  ( in(1,1) * x(5) + in(1,2) * x(6)  + in(1,3) * x(7) )  -  1
        (out(2,1) * x(1) + out(2,2) * x(2)  + out(2,3) * x(3)  + out(2,4)  *  x(4) )  /  ( in(2,1) * x(5) + in(2,2) * x(6)  + in(2,3) * x(7) )  -  1
        (out(3,1) * x(1) + out(3,2) * x(2)  + out(3,3) * x(3)  + out(3,4)  *  x(4) )  /  ( in(3,1) * x(5) + in(3,2) * x(6)  + in(3,3) * x(7) )  -  1
        (out(4,1) * x(1) + out(4,2) * x(2)  + out(4,3) * x(3)  + out(4,4)  *  x(4) )  /  ( in(4,1) * x(5) + in(4,2) * x(6)  + in(4,3) * x(7) )  -  1
        (out(5,1) * x(1) + out(5,2) * x(2)  + out(5,3) * x(3)  + out(5,4)  *  x(4) )  /  ( in(5,1) * x(5) + in(5,2) * x(6)  + in(5,3) * x(7) )  -  1
        ];
    h = [];
end