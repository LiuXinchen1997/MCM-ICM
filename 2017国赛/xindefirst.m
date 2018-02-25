d = 0.2766;
load recv_data.mat recv1;

r = 4;
a = 40;
b = 15;

angles = [];
ds = [];

for i=3:13;
%     if i~=3;
%         break;
%     end;
    
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
    
    max_value = max(tuoyuan);
    [m, n] = find(tuoyuan == max_value);
    
    % (current_situ(n,1) / miu)k^2;
    syms k;
    
    % k = solve('(current_situ(n,1) / miu)^2/(a*a*b*b) = (1+k*k)*(a*a*k*k-b*b*m*m+b*b) / (( a*a*k*k + b*b )^2)');

    k = solve( '0.25*(max_value / miu)^2/360000 = (1+k*k)*(1600*k*k-225*0*0+255) / (( 1600*k*k + 225 )^2)', 'k');
    subs(k(1));
    ans = subs(k(1,1));
end;


for i=109:180;
    recv1(:, i);
end;