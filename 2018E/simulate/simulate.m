%% 定义一些常量
tip_v = 2.0;

%% 建立预测模型
% 构建能够预测温度、降水量和人口的模型
% 初始化预测模型
load wencha_cha; % 博茨瓦纳1996-2015年的温差变化数据
load rainfall_cha; % 博茨瓦纳1996-2015年的雨量变化数据
load population; % 博茨瓦纳1995-2015年的人口数据

for i=1:length(wencha_cha);
    if wencha_cha(i) < 0;
        wencha_cha(i) = -1 * wencha_cha(i);
    end;
    
    if rainfall_cha(i) > 0;
        rainfall_cha(i) = -1 * rainfall_cha(i);
    end;
end;
disp(wencha_cha);
disp(rainfall_cha);

% 人口预测模型初始参数
his_years = 1995:2015;
pop_can = polyfit(his_years', population, 1);

% 降水量预测模型初始参数
rainfall_cha_weights = ones(1, length(rainfall_cha));

% 温差预测模型初始参数
wencha_cha_weights = ones(1, length(wencha_cha));


%% 初始数据准备
% 用于标准化
load bwa_data;
jiangshuiliang = bwa_data(:, 1)';
wencha = bwa_data(:, 2)';
ziranzaihai = bwa_data(:, 3)';
senlinmianji = bwa_data(:, 4)';
ludihaiyangmianji = bwa_data(:, 5)';
nongyezhanbi = bwa_data(:, 6)';
tonghuopengzhang = bwa_data(:, 7)';
jingjizhishu = bwa_data(:, 8)';
renjunGDP = bwa_data(:, 9)';
waishangtouru = bwa_data(:, 10)';
jinixishu = bwa_data(:, 11)';
renkouyali = bwa_data(:, 12)';
nanminrenshu = bwa_data(:, 13)';
qingnianzhanbi = bwa_data(:, 14)';
yiliaozhichuzhanbi = bwa_data(:, 15)';
ruxuelv = bwa_data(:, 16)';

caizhengchizi = bwa_data(:, 17)';
caizhengchizi = caizhengchizi(find(caizhengchizi>0));

guojiahefaxing = bwa_data(:, 18)';

jingyuanzhuzhanbi = bwa_data(:, 19)';
jingyuanzhuzhanbi = jingyuanzhuzhanbi(find(jingyuanzhuzhanbi>0));

mianqianguojiashu = bwa_data(:, 20)';
gaishanshuiyuanzhanbi = bwa_data(:, 21)';

liangshishengchanzhishu = bwa_data(:, 22)';
liangshishengchanzhishu = liangshishengchanzhishu(find(liangshishengchanzhishu>0));

jingyimin = bwa_data(:, 23)';
paixijingying = bwa_data(:, 24)';
renquan = bwa_data(:, 25)';

% 用于仿真的初始数据
jiangshuiliang_cha_2 = [114.6941 -1.18589];
gdp_2 = [4847752843];
gdp_bianhua_2 = [];

jiangshuiliang_2 = [];
wencha_2 = [];
population_2 = [1637635 1604060];
ziranzaihai_2 = [];
nanminrenshu_2 = [];

%% 开始仿真
year = 1997;
while true;
    preds = predict(wencha_cha_weights, rainfall_cha_weights, pop_can, year);
    pred_wencha_cha = wencha_cha(preds(1));
    pred_rainfall_cha = rainfall_cha(preds(2));
    pred_population = preds(3);
    % pred_population = population(length(population)) * (1+(rand() * 0.3 - 0.1));
    
    % 人口
    population_2 = [population_2 pred_population];
    
    wencha_cha = [wencha_cha; pred_wencha_cha];
    rainfall_cha = [rainfall_cha; pred_rainfall_cha];
    jiangshuiliang_cha_2 = [jiangshuiliang_cha_2 pred_rainfall_cha];
    
    % 计算新的温差
    new_wencha = wencha(length(wencha)) + sum(wencha_cha);
    wencha = [wencha new_wencha];
    wencha_2 = [wencha_2 new_wencha];
    normal_wencha = (wencha - mean(wencha)) ./ var(wencha) + 2.5; % 标准化
    
    % 计算新的降水量
    new_jiangshuiliang = jiangshuiliang(length(jiangshuiliang)) - sum(rainfall_cha);
    jiangshuiliang = [jiangshuiliang new_jiangshuiliang];
    jiangshuiliang_2 = [jiangshuiliang_2 new_jiangshuiliang];
    normal_jiangshuiliang = (jiangshuiliang - mean(jiangshuiliang)) ./ var(jiangshuiliang) + 2.5;
    
    % 计算GDP
    new_gdp_bianhua = 681242642.5 + 5302658.762 * jiangshuiliang_cha_2(length(jiangshuiliang_cha_2)) - 1542016109*wencha_2(length(wencha_2)) + 9115932.557 * jiangshuiliang_cha_2(length(jiangshuiliang_cha_2)-1);
    gdp_bianhua_2 = [gdp_bianhua_2 new_gdp_bianhua];
    new_gdp = gdp_2(length(gdp_2)) + gdp_bianhua_2;
    gdp_2 = [gdp_2 new_gdp];
    
    % 自然灾害
    % new_ziranzaihai = ceil(rand() * (max(ziranzaihai)-min(ziranzaihai)) + min(ziranzaihai));
    new_ziranzaihai = ziranzaihai(length(ziranzaihai)) + 1;
    ziranzaihai = [ziranzaihai new_ziranzaihai];
    normal_ziranzaihai = normal(ziranzaihai);
    
    % 难民人数RD11	
    new_nanminrenshu = 6.970 - 123.086 * log(population_2(length(population_2)) / population_2(length(population_2)-1)) + 0.004 * jiangshuiliang(length(jiangshuiliang));
    nanminrenshu = [nanminrenshu new_nanminrenshu];
    nanminrenshu_2 = [nanminrenshu_2 new_nanminrenshu];
    normal_nanminrenshu = normal(nanminrenshu);
    
    % 净移民
    new_jingyimin = 2430.780 * nanminrenshu(length(nanminrenshu)) + 3429.033;
    jingyimin = [jingyimin new_jingyimin];
    normal_jingyimin = normal(jingyimin);
    
    % 经济指数4
    new_jingjizhishu = 2.984 + 136.498 * log( population_2(length(population_2)) / population_2(length(population_2)-1) ) + 0.201 * wencha(length(wencha));
    jingjizhishu = [jingjizhishu new_jingjizhishu];
    normal_jingjizhishu = normal(jingjizhishu);
    
    % 森林面积占地面积百分比
    new_senlinmianji = 0.920 * nanminrenshu_2(length(nanminrenshu_2)) + 15.133;
    senlinmianji = [senlinmianji new_senlinmianji];
    normal_senlinmianji = normal(senlinmianji);
    
    % @10派系精英FE2
    new_paixijingying = 0.838 + 0.313 * senlinmianji(length(senlinmianji));
    paixijingying = [paixijingying new_paixijingying];
    normal_paixijingying = normal(paixijingying);
    
    % 基尼系数
    new_jinixishu = 14.219 + 2.220 * senlinmianji(length(senlinmianji));
    jinixishu = [jinixishu new_jinixishu];
    normal_jinixishu = normal(jinixishu);
    
    % 人口压力DP10	
    new_renkouyali = -0.061 + 0.153 * jinixishu(length(jinixishu));
    renkouyali = [renkouyali new_renkouyali];
    normal_renkouyali = normal(renkouyali);
    
    % 国家合法性SL7
    new_guojiahefaxing = -212.811 * log( population_2(length(population_2)) / population_2(length(population_2)-1) ) - 0.453 * wencha(length(wencha));
    guojiahefaxing = [guojiahefaxing new_guojiahefaxing];
    normal_guojiahefaxing = normal(guojiahefaxing);
    
    % 陆地及海洋保护区面积占比	
    new_ludihaiyangmianji = -0.00143*(year - 1994) + 29.1214286;
    ludihaiyangmianji = [ludihaiyangmianji new_ludihaiyangmianji];
    normal_ludihaiyangmianji = normal(ludihaiyangmianji);
    
    % 农业增加值占GDP百分比	
    new_nongyechanzhi = gdp_2(length(gdp_2)) * 0.21 + 62288434.277;
    nongyezhanbi = [nongyezhanbi new_nongyechanzhi*100/gdp_2(length(gdp_2))];
    normal_nongyezhanbi = normal(nongyezhanbi);
    
    % 通货膨胀	
    new_tonghuopengzhang = 32.017 - jingjizhishu(length(jingjizhishu)) * 4.690 + new_nongyechanzhi * 3.104 * 10^(-8) - gdp_2(length(gdp_2)) * 5.758 * 10^(-10);
    tonghuopengzhang = [tonghuopengzhang new_tonghuopengzhang];
    normal_tonghuopengzhang = normal(tonghuopengzhang);
    
    % 人均GDP	
    new_renjunGDP = gdp_2(length(gdp_2)) / population_2(length(population_2));
    renjunGDP = [renjunGDP new_renjunGDP];
    normal_renjunGDP = normal(renjunGDP);
    
    % 外商直接投资净流入		
    new_waishangtouru = -167149783 + 0.55 * gdp_2(length(gdp_2));
    waishangtouru = [waishangtouru new_waishangtouru];
    normal_waishangtouru = normal(waishangtouru);
    
    % @1564岁的人口占比	
    new_qingnianrenshu = population_2(length(population_2)) * 0.863 - 464737.578;
    qingnianzhanbi = [qingnianzhanbi new_qingnianrenshu*100 / population_2(length(population_2))];
    normal_qingnianzhanbi = normal(qingnianzhanbi);
    
    % 公共医疗卫生支出占比	
    new_yiliaozhichu = gdp_2(length(gdp_2)) * 0.62 - 80936395.3;
    yiliaozhichuzhanbi = [yiliaozhichuzhanbi new_yiliaozhichu * 100/gdp_2(length(gdp_2))];
    normal_yiliaozhichuzhanbi = normal(yiliaozhichuzhanbi);
    
    % 入学率	
    new_ruxuelv = 148.7 / (1+ (148.7/102.7-1)* exp(-0.1*(year-1994)));
    ruxuelv = [ruxuelv new_ruxuelv];
    normal_ruxuelv = normal(ruxuelv); 
    
    
    % 收到的净官方发展援助占比	
    new_jingyuanzhuzhanbi = 603.821 - 5.566 * ruxuelv(length(ruxuelv));
    jingyuanzhuzhanbi = [jingyuanzhuzhanbi new_jingyuanzhuzhanbi];
    normal_jingyuanzhuzhanbi = normal(jingyuanzhuzhanbi);
    
    % 财政赤字	
    new_caizhengchizi = 75.088 + 2.562 * 10^(-9) * gdp_2(length(gdp_2)) - 6.23 * jingyuanzhuzhanbi(length(jingyuanzhuzhanbi)) - 16.55 * jingjizhishu(length(jingjizhishu));
    caizhengchizi = [caizhengchizi new_caizhengchizi];
    normal_caizhengchizi = normal(caizhengchizi);
    
    % 免签国家数量	
    if mod(year, 5) == 0 && mianqianguojiashu(length(mianqianguojiashu)) > 0;
        new_mianqianguojiashu = mianqianguojiashu(length(mianqianguojiashu)) - 1;
    else
        new_mianqianguojiashu = mianqianguojiashu(length(mianqianguojiashu));
    end;
    mianqianguojiashu = [mianqianguojiashu new_mianqianguojiashu];
    normal_mianqianguojiashu = normal(mianqianguojiashu);
    
    % 改善水源在城市的人口占比	
    new_gaishanshuiyuanzhanbi = gdp_2(length(gdp_2))*3*10^(-10) + 87.187;
    if new_gaishanshuiyuanzhanbi > 100;
        new_gaishanshuiyuanzhanbi = 100;
    end;
    gaishanshuiyuanzhanbi = [gaishanshuiyuanzhanbi new_gaishanshuiyuanzhanbi];
    normal_gaishanshuiyuanzhanbi = normal(gaishanshuiyuanzhanbi);
    
    % 粮食生产指数		
    new_liangshishengchanzhishu = 97.765 + 1.937 * 10^(-7)*new_nongyechanzhi + 0.32 * jiangshuiliang(length(jiangshuiliang));
    liangshishengchanzhishu = [liangshishengchanzhishu new_liangshishengchanzhishu];
    normal_liangshishengchanzhishu = normal(liangshishengchanzhishu);
    
    % @10人权HR9
    new_renquan = 3.443 + 0.587 * jingjizhishu(length(jingjizhishu)) - 3.734 * 10^(-9) * new_nongyechanzhi - 0.163 * wencha(length(wencha));
    renquan = [renquan new_renquan];
    normal_renquan = normal(renquan);
    
    
    % 存储各个已经标准化之后的数值的向量
    factors = [
        normal_jiangshuiliang(length(normal_jiangshuiliang))
        normal_wencha(length(normal_wencha))
        normal_ziranzaihai(length(normal_ziranzaihai))
        normal_senlinmianji(length(normal_senlinmianji))
        normal_ludihaiyangmianji(length(normal_ludihaiyangmianji))
        normal_nongyezhanbi(length(normal_nongyezhanbi))
        normal_tonghuopengzhang(length(normal_tonghuopengzhang))
        normal_jingjizhishu(length(normal_jingjizhishu))
        normal_renjunGDP(length(normal_renjunGDP))
        normal_waishangtouru(length(normal_waishangtouru))
        normal_jinixishu(length(normal_jinixishu))
        normal_renkouyali(length(normal_renkouyali))
        normal_nanminrenshu(length(normal_nanminrenshu))
        normal_qingnianzhanbi(length(normal_qingnianzhanbi))
        normal_yiliaozhichuzhanbi(length(normal_yiliaozhichuzhanbi))
        normal_ruxuelv(length(normal_ruxuelv))
        normal_caizhengchizi(length(normal_caizhengchizi))
        normal_guojiahefaxing(length(normal_guojiahefaxing))
        normal_jingyuanzhuzhanbi(length(normal_jingyuanzhuzhanbi))
        normal_mianqianguojiashu(length(normal_mianqianguojiashu))
        normal_gaishanshuiyuanzhanbi(length(normal_gaishanshuiyuanzhanbi))
        normal_liangshishengchanzhishu(length(normal_liangshishengchanzhishu))
        normal_jingyimin(length(normal_jingyimin))
        normal_paixijingying(length(normal_paixijingying))
        normal_renquan(length(normal_renquan))
    ]';
    
    ks = [0.1 0.3 0.2 0.3 0.1];
    ks = ks .* 1.972;
    bwa_frags = calc_frag_fun(factors, ks);
    disp(bwa_frags);
   
    if bwa_frags(1) >= tip_v && year >= 2015;
        disp('达到临界点！');
        break;
    end;
    
    % 恶化处理
    if mod(year, 3) == 0;
        pop_can(1) = pop_can(1) - 0.00005;
    end;
    wencha_cha_weights(10) = wencha_cha_weights(10) + 5;
    rainfall_cha_weights(12) = rainfall_cha_weights(12) + 5;
    
    year = year + 1;
end;

disp(year);