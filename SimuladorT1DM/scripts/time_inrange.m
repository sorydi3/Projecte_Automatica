function [hyper, normo, hypo] = time_inrange(data, LOWER, UPPER)
L = find(data<LOWER);
U = find(data>UPPER);

hyper = 100*numel(data(U))/numel(data);
hypo = 100*numel(data(L))/numel(data);
normo = 100 - (hyper + hypo);
end