function frags = calc_frag_fun(factors, ks)
    % 总脆弱性、气候脆弱性、经济脆弱性、社会脆弱性、政治脆弱性、协调脆弱性
    
    climate_p_i = [1 2 3];
    climate_e_i = [4 5];
    climate_p = sum(factors(climate_p_i)) / length(climate_p_i);
    climate_e = sum(factors(climate_e_i)) / length(climate_e_i);
    climate_frag = (climate_p / climate_e) * ks(1);
    
    economy_p_i = [6 7 8];
    economy_e_i = [9 10];
    economy_p = sum(factors(economy_p_i)) / length(economy_p_i);
    economy_e = sum(factors(economy_e_i)) / length(economy_e_i);
    economy_frag = (economy_p / economy_e) * ks(2);
    
    society_p_i = [11 12 13 14];
    society_e_i = [15 16];
    society_p = sum(factors(society_p_i)) / length(society_p_i);
    society_e = sum(factors(society_e_i)) / length(society_e_i);
    society_frag = (society_p / society_e) * ks(3);
    
    politic_p_i = [17 18];
    politic_e_i = [19 20];
    politic_p = sum(factors(politic_p_i)) / length(politic_p_i);
    politic_e = sum(factors(politic_e_i)) / length(politic_e_i);
    politic_frag = (politic_p / politic_e) * ks(4);
    
    other_p_i = [21 22 23];
    other_e_i = [24 25];
    other_p = sum(factors(other_p_i)) / length(other_p_i);
    other_e = sum(factors(other_e_i)) / length(other_e_i);
    other_frag = (other_p / other_e) * ks(5);
    
    sum_frag = climate_frag + economy_frag + society_frag + politic_frag + other_frag;
    frags = [sum_frag climate_frag economy_frag society_frag politic_frag other_frag];
end
