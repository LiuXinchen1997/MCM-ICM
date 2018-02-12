%% 初始化预测模型
load wencha_cha;
load rainfall_cha;
load population;

% 人口预测模型初始参数
his_years = 1995:2015;
pop_can = polyfit(his_years', population, 1);

% 降水量预测模型初始参数
rainfall_cha_weights = ones(1, length(rainfall_cha));

% 温差预测模型初始参数
wencha_cha_weights = ones(1, length(wencha_cha));

a = predict(wencha_cha_weights, rainfall_cha_weights, pop_can, 2016);