%% ��ʼ��Ԥ��ģ��
load wencha_cha;
load rainfall_cha;
load population;

% �˿�Ԥ��ģ�ͳ�ʼ����
his_years = 1995:2015;
pop_can = polyfit(his_years', population, 1);

% ��ˮ��Ԥ��ģ�ͳ�ʼ����
rainfall_cha_weights = ones(1, length(rainfall_cha));

% �²�Ԥ��ģ�ͳ�ʼ����
wencha_cha_weights = ones(1, length(wencha_cha));

a = predict(wencha_cha_weights, rainfall_cha_weights, pop_can, 2016);