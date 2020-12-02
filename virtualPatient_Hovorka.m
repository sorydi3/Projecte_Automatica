function SORTIDA = virtualPatient_Hovorka(ENTRADA1, ENTRADA2)
    % ENTRADA1 = pes del pacient
    % ENTRADA2 = factor de guany idèntic per a la sensibilitat a l'insulina
    BW = ENTRADA1; % Pes del pacient
    n = ENTRADA2; % Guany
    k12 = 0.066; % Constant de transferència de glucosa del compartiment accessible al no accessible
    ka1 = 0.006; % Constants de desactivació dels efectes de l’insulina 
    ka2 = 0.06; % ...
    
    
    ka3 = 0.03; % ...
    ke = 0.138; % Eliminació d'insulina en plasma
    VI = 0.12*BW; % Volum de distribució d'insulina
    Vg = 0.16*BW; % Volum de distribució del compartiment accesible
    SfIT = 51.2*10^(-4); % Sensibilitats de l’insulina a diferents efectes com el transport, l’eliminació i la producció endògena de glucosa
    SfID = 8.2*10^(-4); % ...
    SfIE = 520*10^(-4); % ...
    EGP0 = 0.0161*BW; % Producció endògena
    F01 = 0.0097*BW; % ___
    tmaxI = 55; % Temps de màxima absorció d'insulina
    kb1 = SfIT*ka1*n; % ____
    kb2 = SfID*ka2*n; % ____
    kb3 = SfIE*ka3*n; % ____
    tau = 16; % Difusió de glucosa en plasma a espai subcutani
    Ag = 0.9; % ___
    tmaxG = 50; % Temps de màxima absorció de carbohidrats
    SORTIDA = [k12 ka1 ka2 ka3 ke VI Vg SfIT SfID SfIE EGP0 F01 tmaxI BW kb1 kb2 kb3 tau Ag tmaxG];
end