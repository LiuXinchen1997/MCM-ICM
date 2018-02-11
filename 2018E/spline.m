x = 1:178;
xx = 1:0.1:178;
yy = interp1(x, a, xx, 'spline');
plot(xx, yy);