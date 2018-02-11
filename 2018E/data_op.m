%{
% ÏßĞÔ²åÖµ
data_2003 = 39.8;
data_2011 = 43.3;

zeng = (data_2011 - data_2003) / 8;
start = 4;
data = [];
for i=1:16;
    new_data = data_2003 + (i-start)*zeng;
    data = [data new_data];
end;
%}

data = [
    17864		24546					21278					18730					15000			
];
x = [1 3 8 13 18];

xi = 1:21;
res1 = interp1(x, data, xi, 'spline');
res2 = interp1(x, data, xi, 'cubic');
res3 = interp1(x, data, xi, 'linear');