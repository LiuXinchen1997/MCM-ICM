%%
clear
clc



%% 导入数据
load recv_data.mat recv1;
load recv_data2.mat recv2;  % 第（2）题探测器接收数据



%% 通过ART重建算法，不断迭代，求解结果
% 首先验证第（1）问中的模板

nameda = 0.25;
error = 50;
small = 0.0001;

%初始化 矩阵
center_x = +9.1278;
center_y = +5.8086;
d = 0.2766;
a = 100 / 256;
weixiao = a;

BI_Col = recv1(:, 61);

image_mat = zeros(256,256);
for i = 1:256;
    dy = 0.5*d + (i-1)*d;
    current_y_pos = center_y + dy;
    light_up = 257 + (i-1);
    
    current_y_neg = center_y - dy;
    light_down = 256 - (i-1);
    
    if current_y_pos >= 50 || current_y_neg <= -50;
        break;
    end;
    
    [i_pos, j_pos] = calcij(1, current_y_pos);
    [i_neg, j_neg] = calcij(1, current_y_neg);
    
    count = 256;
    image_mat(i_pos,:) = ( image_mat(i_pos,:) + BI_Col(light_up) / count ) / 2;
    image_mat(i_neg,:) = ( image_mat(i_neg,:) + BI_Col(light_down) / count ) / 2;
end;

start_e = []; % 判断退出条件
for ii=1:256;
    start_e = [start_e sum(image_mat(ii,:))];
end;

% 开始迭代求解
start = 30;


for i=0: 179;
    disp(i);
    if i == 60;
        continue;
    end;
    
    current_e = [];  % 判断退出条件
    for ii=1:256;
        current_e = [current_e sum(image_mat(ii,:))];
    end;
    
    angle = ((start+i)/180) * pi; % 与y轴的初始角度
    
    %%
    if angle == pi;
        continue;
    end;
    %%
    
    
    tan(pi/2 + angle); % 直线斜率
    center_jieju = -1 * center_x * tan(pi/2 + angle) + center_y; % 截距
    
    % 512条直线
    for j=1:256;
        
        d_d = 0.5 * d + (j-1) * d;
        
        jieju_up = center_jieju + d_d / sin(angle);
        jieju_down = center_jieju - d_d / sin(angle);
        % y = tan(pi/2 + angle) * x + jieju_up;
        % y = tan(pi/2 + angle) * x + jieju_down;
        
        
        
        
        
        bianyuan = 49.999;
        
        
        
        
        % up
        temp_x = (-bianyuan - jieju_up) / tan(pi/2 + angle);
        temp_y = -bianyuan;
        
        if temp_x >= 50;
            temp_x = bianyuan;
            temp_y = tan(pi/2 + angle) * bianyuan + jieju_up;
        end;
        
        if temp_x <= -50;
            temp_x = -bianyuan;
            temp_y = tan(pi/2 + angle) * (-bianyuan) + jieju_up;
        end;
         
        
        is = [];
        js = [];
        while temp_x >= -50 && temp_x <= 50 && temp_y >= -50 && temp_y <= 50;
            
            [temp_i,temp_j] = calcij(temp_x, temp_y);
            temp_size = size(is);
            
            if temp_i >= 1 && temp_i <= 256 && temp_j >= 1 && temp_j <= 256 && temp_size(2) == 0;
                is = [is temp_i];
                js = [js temp_j];
            else
                if temp_i >= 1 && temp_i <= 256 && temp_j >= 1 && temp_j <= 256 && ( (is(1,temp_size(2)) ~= temp_i) || (js(1,temp_size(2)) ~= temp_j) );
                    is = [is temp_i];
                    js = [js temp_j];
                end;
            end;
            
            
            if abs(sin(pi/2-angle)) >= abs(cos(pi/2-angle));
                if sin(pi/2+angle) >= 0;
                    % temp_y = temp_y + a;
                    temp_y = temp_y + weixiao;
                else
                    % temp_y = temp_y - a;
                    temp_y = temp_y - weixiao;
                end;
                
                temp_x = (temp_y - jieju_up) / tan(pi/2+angle);
                
            else
                if tan(pi/2 + angle) >= 0;
                    % temp_x = temp_x + a;
                    temp_x = temp_x + weixiao;
                else
                    % temp_x = temp_x - a;
                    temp_x = temp_x - weixiao;
                end;
                
                temp_y = tan(pi/2+angle) * temp_x + jieju_up;
            end;
            
           
        end;
        
        
%         fprintf('%d %d %d %d %d \n', is(1), is(2),is(3),is(4),is(5));
%         fprintf('%d %d %d %d %d \n', js(1), js(2),js(3),js(4),js(5));
        
        count = size(is); % 个数是 count(2)
        if count(2) ~= 0;
            for k=1:count(2);
                % disp(is(k));
                % disp(js(k));
                
                summary = 0;
                cc = size(is);
                
                for kk=1:cc(2);
                    summary = summary + image_mat(is(1,kk), js(1,kk));
                end;
                
                % image_mat(is(k), js(k)) = image_mat(is(k), js(k)) +  nameda * ( summary - recv1(257+j-1, i+1) * cos(angle-pi/2)/ a ) / count(2);
                % image_mat(is(k), js(k)) = image_mat(is(k), js(k)) +  nameda * ( summary - recv1(257+j-1, i+1) ) / count(2);
                if summary ~= 0;
                    image_mat(is(k), js(k)) = image_mat(is(k), js(k)) * 0.025 * recv1(257+j-1, i+1) / summary;
                end;
                
                    
                % 一些数据修正
                if image_mat(is(k), js(k)) < 0;
                    image_mat(is(k), js(k)) = 0;
                end;
                
                if image_mat(is(k), js(k)) < small;
                    image_mat(is(k), js(k)) = 0;
                end;
                
                
            end;
        end;
        
        
        
        
        
        
        
        
        
        
        
         % down
        temp_x = (-bianyuan - jieju_down) / tan(pi/2 + angle);
        temp_y = -bianyuan;
        
        if temp_x >= 50;
            temp_x = bianyuan;
            temp_y = tan(pi/2 + angle) * bianyuan + jieju_down;
        end;
        
        if temp_x <= -50;
            temp_x = -bianyuan;
            temp_y = tan(pi/2 + angle) * (-bianyuan) + jieju_down;
        end;
        
        
        
        
        is = [];
        js = [];
        while temp_x >= -50 && temp_x <= 50 && temp_y >= -50 && temp_y <= 50;
            [temp_i,temp_j] = calcij(temp_x, temp_y);
            temp_size = size(is);
            if temp_size(2) == 0;
                is = [is temp_i];
                js = [js temp_j];
            else
                if temp_i >= 1 && temp_i <= 256 && temp_j >= 1 && temp_j <= 256 && ( (is(1,temp_size(2)) ~= temp_i) || js(1,temp_size(2)) ~= temp_j );
                    is = [is temp_i];
                    js = [js temp_j];
                end;
            end;
            
            if abs(sin(pi/2-angle)) >= abs(cos(pi/2-angle));
                if sin(pi/2+angle) >= 0;
                    % temp_y = temp_y + a;
                    temp_y = temp_y + weixiao;
                else
                    % temp_y = temp_y - a;
                    temp_y = temp_y - weixiao;
                end;
                
                temp_x = (temp_y - jieju_down) / tan(pi/2+angle);
                
            else
                if tan(pi/2 + angle) >= 0;
                    % temp_x = temp_x + a;
                    temp_x = temp_x + weixiao;
                else
                    % temp_x = temp_x - a;
                    temp_x = temp_x - weixiao;
                end;
                
                temp_y = tan(pi/2+angle) * temp_x + jieju_down;
                
            end;
        end;
        
        
        count = size(is); % 个数是 count(2)
        if count(2) ~= 0;
            for k=1:count(2);
                % disp(is(k));
                % disp(js(k));
                
                summary = 0;
                cc = size(is);
                
                for kk=1:cc(2);
                    summary = summary + image_mat(is(1,kk), js(1,kk));
                end;
                
               % image_mat(is(k), js(k)) = image_mat(is(k), js(k)) +  nameda * ( summary - recv1(255-j+1, i+1) * cos(angle-pi/2)/ a ) / count(2);
               % image_mat(is(k), js(k)) = image_mat(is(k), js(k)) +  nameda * ( summary - recv1(255-j+1, i+1) ) / count(2);
               if summary ~= 0;
                    image_mat(is(k), js(k)) = image_mat(is(k), js(k))  * 0.025 *   recv1(256-j+1, i+1) / summary;
               end;
                
               

               % 以下是修正数据
                if image_mat(is(k), js(k)) < 0;
                    image_mat(is(k), js(k)) = 0;
                end;
                          
                if image_mat(is(k), js(k)) < small;
                    image_mat(is(k), js(k)) = 0;
                end;
                
                
            end;
        end;     
    end;
    
    
    if sqrt(sum((current_e - start_e).^2)) < error && i ~= 0;
        break;
    end;
    
    
%     if (current_e - start_e) < error;
%         break;
%     end;
    
end;



for i = 1:256;
    for j = 1:256;
        if image_mat(i,j) < 0;
            image_mat(i,j) = 0;
        else
            if abs(image_mat(i,j)) < 0.0001;
                image_mat(i,j) = 0;
            end;
        end;
    end;
end;



