 function F = model_hovorkaSS(x, u, params)
% Assignem noms adients a les variables que formen un pacient
k12 = params(1);
ka1 = params(2);
ka2 = params(3);
ka3 = params(4);
ke = params(5);

VI = params(6);
Vg = params(7);
SfIT = params(8);
SfID = params(9);
SfIE = params(10);
EGP0 = params(11);
F01 = params(12);
tmaxI = params(13);
BW = params(14);
kb1 = params(15);
kb2 = params(16);
kb3 = params(17);
tau = params(18);
Ag = params(19);
tmaxG = params(20);

% Taxa d’absorció de carbohidrats constant i zero
Ug = 0;

% Assigneu variables amb els noms corresponents a tots els elements del vector x
S1 = x(1);
S2 = x(2);
I = x(3);
x1 = x(4);
x2 = x(5);
x3 = x(6);
Q1 = x(7);
Q2 = x(8);
IG = x(9);
G1=x(10);
G2=x(11)

if (IG >= 4.5)
    F01c = F01;
else
    F01c = F01*IG/4.5;
end

if (IG >= 9)
    FR = 0.003*(IG - 9)*Vg;
else
    FR = 0;
end

% Implementeu les diferents equacions del model d’Hovorka
F(1) = u(1) - S1/tmaxI; % ·S1(t) = u(t)-S1(t)/tmaxI
F(2) = (S1 - S2)/tmaxI; % ·S2(t) = (S1(t) - S2(t))/tmaxI
F(3) = S2/(tmaxI*VI) - ke*I; % ·I(t) = S2(t)/(tmaxI*VI) - ke*I(t)
F(4) = -ka1*x1 + kb1*I; % ·x1(t) = -ka1*x1(t) + kb1*I(t)
F(5) = -ka2*x2 + kb2*I; % ·x2(t) = -ka2*x2(t) + kb2*I(t)
F(6) = -ka3*x3 + kb3*I; % ·x3(t) = -ka3*x3(t) + kb3*I(t)
F(7) = -x1*Q1 + k12*Q2 - F01c - FR + Ug + EGP0*(1-x3); % ·Q1(t) = -x1(t)*Q1(t) + k12*Q2(t) - F01c(t) - FR(t) + Ug(t) + EGP0*(1-x3(t))
F(8) = x1*Q1 - k12*Q2 - x2*Q2;% ·Q2(t) = x1(t)*Q1(t) - k12*Q2(t) - x2(t)*Q2(t)
F(9) = (1/tau)*( Q1/Vg - IG ); % ·IG(t) = (1/tau)*( Q1(t)/Vg - IG(t) )
F(10) = (-G1/tmaxG)+u(2);
F(11) = (G1-G2)/tmaxG;
F = F';
end