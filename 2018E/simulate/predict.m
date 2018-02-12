function factors = predict(wencha_cha_weights, rainfall_cha_weights, pop_can, year)
    % 预测人口
    population = polyval(pop_can, year);
    
    % 预测降水量变化
    probs = rainfall_cha_weights ./ sum(rainfall_cha_weights);
    for i=2:length(probs);
        probs(i) = probs(i-1) + probs(i);
    end;
    
    rand_val = rand();
    % rainfall_pred_id = 0;
    for i=1:length(probs);
        if 1==i;
            if rand_val < probs(1);
                rainfall_pred_id = 1;
                break;
            end;
        elseif rand_val >= probs(i-1) && rand_val < probs(i);
                rainfall_pred_id = i;
                break;
        elseif rand_val == 1;
            rainfall_pred_id = length(preds);
            break;
        end;
    end;
    
    % 预测温差变化
    probs = wencha_cha_weights ./ sum(wencha_cha_weights);
    for i=2:length(probs);
        probs(i) = probs(i-1) + probs(i);
    end;
    rand_val = rand();
    wencha_pred_id = 0;
    for i=1:length(probs);
        if 1==i;
            if rand_val < probs(1);
                wencha_pred_id = 1;
                break;
            end;
        elseif rand_val >= probs(i-1) && rand_val < probs(i);
            wencha_pred_id = i;
            break;
        elseif rand_val == 1;
            wencha_pred_id = length(preds);
            break;
        end;
    end;
    
    factors = [wencha_pred_id rainfall_pred_id population];
end
