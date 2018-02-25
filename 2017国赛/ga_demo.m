load recv_data.mat recv1;
    
r = 4;
a = 40;
b = 15;

angles = [];
ds = [];

for i=1:13;
    current_situ = recv1(:, i);
    j = 1;
    while current_situ(j,1) == 0;
        j = j + 1;
    end;

    global tuoyuan;
    tuoyuan = [];

    global tuoyuanid;
    tuoyuanid = [];
    while current_situ(j,1) ~= 0;
        tuoyuan = [tuoyuan current_situ(j,1)];
        tuoyuanid = [tuoyuanid j];
        j = j + 1;
    end;

    while current_situ(j,1) == 0;
        j = j + 1;
    end;

    yuan = [];
    while current_situ(j,1) ~= 0;
        yuan = [yuan current_situ(j,1)];
        j = j + 1;
    end;

    max_yuan = max(yuan);

    global miu;
    miu = max_yuan / (2*r);

    tic;
    options = gaoptimset('PopInitRange', [ -1.8, -1.7; 0.2, 0.3], 'Generations', 500, 'StallGenLimit', 500);
    [h, f] = ga(@lbw, 2, options);
    disp(h);
    toc;
    
    angles = [angles h(1)];
    ds = [ds h(2)];
end;


for i=109:180;
    recv1(:, i);
        
end;




