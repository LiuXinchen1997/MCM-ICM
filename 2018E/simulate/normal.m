function y = normal(x)
    y = (x - mean(x)) ./ var(x) + 2.5;
end

