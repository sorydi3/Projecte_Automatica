%% Execucio de la simulacio.
sim_time = 60*24; % Temps de simulacios

% Cridem la funcio virtualPatient_Hovorka per a obtenir un vector de
% parametres que defineixen un pacient virtual.
FactorSensitivitat = 1;
PesPacient = 75;
pacient = virtualPatient_Hovorka(PesPacient, FactorSensitivitat);

% Infusio basal
basal = 0.42; % U/h  0.42:0.56
CR = 30; % Factor de carbohidrats

% Iniciem el sistema a estat estacionari
xguess = ones(9,1);
[x,fval,exitflag] = fsolve(@(x) model_hovorkaSS(x, basal*1000/60, pacient),xguess);
Xkm1 = [x; 0; 0]'; % + estats de l'absorcio de carbohidrats

% Protocol de menjars
grams_cho = [30 40 25];
temps_cho = [7 13 20];
num_menjars = length(grams_cho);
index_menjar = 1*(~isempty(grams_cho));

hist_states = [];
u = zeros(1,2);
for i = 1:sim_time
    % Terapia basal + bolus
    if ~isempty(num_menjars) && index_menjar <= length(grams_cho)
        if i == temps_cho(index_menjar)*60
            u(2) = grams_cho(index_menjar);
            bolus = (u(2)/CR)*1000; % mU
            u(1) = basal*1000/60 + bolus; % mU/min
            index_menjar = index_menjar + 1;
        else
            u(2) = 0;
            u(1) = basal*1000/60; % U/h -> mU/min
        end
    else
        u(2) = 0;
        u(1) = basal*1000/60; % mU/min
    end

    [~,Xhov] = ode45(@(t,x) model_hovorka(t, x, u, pacient), [i i+1], Xkm1);
    Xkm1 = Xhov(end,:)';
    hist_states = [hist_states; Xkm1'];
end

% Mostrem resultats per pantalla
plot((1:sim_time)./60,hist_states(:,9)*18); hold on;
xlim([0 24]);
limitsY = get(gca,'ylim');
X = [0 0 sim_time/60 sim_time/60];
Y = [70 140 140 70]; fill(X,Y,'g','FaceAlpha',0.15,'EdgeAlpha',0.1);
xlabel('Time (h)'); ylabel('G (mg/dl)');