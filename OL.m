function u = OL(i,u,open_loop)
% Terapia basal + bolus
if ~isempty(open_loop.num_menjars) && open_loop.index_menjar <= length(open_loop.grams_cho)
    if i == open_loop.temps_cho(open_loop.index_menjar)*60
        u(2) = open_loop.grams_cho(open_loop.index_menjar);
        open_loop.bolus = (u(2)/open_loop.CR)*1000; % mU
        u(1) = open_loop.basal*1000/60 + open_loop.bolus; % mU/min
        open_loop.index_menjar = open_loop.index_menjar + 1;
    else
        u(2) = 0;
        u(1) = open_loop.basal*1000/60; % U/h -> mU/min
    end
else
    u(2) = 0;
    u(1) = open_loop.basal*1000/60; % mU/min
end
end