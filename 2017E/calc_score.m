%% 给定各个指标数值，计算得分
weight = [-0.031975742
0.161897337
0.059201123
0.057884302
0.057884302
0.073173823
0.053315083
0.057616019
0.052075813
0.056897074
0.059353508
0.064163208
0.073565065
0.073565065
0.064275641
0.067108379
];

new_lishui_data = [160
143100
36.5921
0.49322
14.42
52.75
440
25.82
0.004122363
0.000501322
40285
98.33
10244.42748
0.16933231
37.17
107];

new_sonoma_data = [ 9.1
471122
80.12
0.445926528
91.19
88.0142
364.75857
2.994597409
0.0018923
0.2041125261
101256
97.2
12765.318
0.755679261
71.34
90
];

data = [
    220	215	210	204	227	11.5	11.1
103100	133297	51795.02638	91686.6496	110700	254987.4	411122
34.5921	40.1428621	29.5175464	25.660089	51.1287	62.34	78.98
0.41312	0.4612	0.38725	0.452213	0.6352	0.532820426	0.415966218
13.88	14.67	10	11	14	1088.11	90.19
48.8	48.9	43.2	46.76	47.43112	85.6	87.2
398	399	596.1365678	666.9362	475.3635719	134.9837	360.75857
22.05	23.06	19.05	23.53	25.232	3.510610854	2.774597409
0.004072473	0.004357448	0.003578	0.004298	0.0056323	0.003	0.0018
0.000498429	0.000642528	0.00040557	0.000492	0.0005062	0.029365797	0.198125261
34686	34699	16769.34	27154	28137	32404	91256
97.33	97.54	98.3483044	98.442687	97.2131	93.1	96.2
10141.49718	13263.04321	9785.52	10634.88	15146.112	10813.6686	11965.318
0.1673431	0.1759051	0.126234	0.161241	0.1823123	0.378383608	0.705679261
36.06	35.87	33.12	34.14	36.63	34	70.34
107	114	152	167	535	96	86
];

data = [data new_lishui_data new_sonoma_data];

pm_25 = data(1,:);
gdp_avg = data(2,:);
third_ratio = data(3,:);
house_avg = data(4,:);
green_area_avg = data(5,:);
high_stu_ratio = data(6,:);
people_density = data(7,:);
path_avg = data(8,:);
bed_avg = data(9,:);
bus_avg = data(10,:);
salary_avg = data(11,:);
work_ratio = data(12,:);
infrastr_avg = data(13,:);
car_avg = data(14,:);
agriculture_ratio = data(15,:);
scene_num = data(16,:);

% 输入数据归一化处理
[pm_25n, pm_25s] = mapminmax(pm_25);
[gdp_avgn, gdp_avgs] = mapminmax(gdp_avg);
[third_ration, third_ratios] = mapminmax(third_ratio);
[house_avgn, house_avgs] = mapminmax(house_avg);
[green_area_avgn, green_area_avgs] = mapminmax(green_area_avg);
[high_stu_ration, high_stu_ratios] = mapminmax(high_stu_ratio);
[people_densityn, people_densitys] = mapminmax(people_density);
[path_avgn, path_avgs] = mapminmax(path_avg);
[bed_avgn, bed_avgs] = mapminmax(bed_avg);
[bus_avgn, bus_avgs] = mapminmax(bus_avg);
[salary_avgn, salary_avgs] = mapminmax(salary_avg);
[work_ration, work_ratios] = mapminmax(work_ratio);
[infrastr_avgn, infrastr_avgs] = mapminmax(infrastr_avg);
[car_avgn, car_avgs] = mapminmax(car_avg);
[agri_ration, agri_ratios] = mapminmax(agriculture_ratio);
[scene_numn, scene_nums] = mapminmax(scene_num);
input = [
    pm_25n; gdp_avgn; third_ration; house_avgn; green_area_avgn;
    high_stu_ration; people_densityn; path_avgn; bed_avgn; bus_avgn; 
    salary_avgn; work_ration; infrastr_avgn; car_avgn; agri_ration;
    scene_numn
];
input = input + 1;
input = input / 2;


lishui_score = 0;
sonoma_score = 0;
lishui_col = 1;
sonoma_col = 7;
for i=1:length(weight);
    lishui_score = lishui_score + weight(i) * input(i, lishui_col);
    sonoma_score = sonoma_score + weight(i) * input(i, sonoma_col);
end;

new_lishui_col = 8;
new_sonoma_col = 9;
new_lishui_indexes = [];
new_sonoma_indexes = [];
for i=1:length(weight);
    new_lishui_indexes = [new_lishui_indexes; weight(i)*input(i, new_lishui_col)];
    new_sonoma_indexes = [new_sonoma_indexes; weight(i)*input(i, new_sonoma_col)];
end;

new_lishui_score = sum(new_lishui_indexes);
new_sonoma_score = sum(new_sonoma_indexes);