set(0,'DefaultLegendAutoUpdate','off');
bw = 60:10:100; % pes a utilitzar
insulina = 0.2:0.01:1; % infusions d'insulina a utilitzar


% Matrius de resultats
out = [];
results = zeros(2,length(insulina),length(bw));

% Bucles per simular totes les combinacions de pes i infusions
p = 1;
for pes = bw
    for u = insulina
        pacient = virtualPatient_Hovorka(pes,1); % Pacient amb sensitivitat 1
        u = u.*(1000/60); % convertim unitats a mU/min
        
        xguess = ones(9,1); % punt de partida pel solver
        [x] = fsolve(@(x) model_hovorkaSS(x, u, pacient), xguess);% UTILITZEU FSOLVE PER A RESOLDRE L’ESTAT ESTACIONARI
        
        out = [out [u*60/1000;18*x(9)]];
    end
    results(:,:,p) = out;
    out = [];
    p = p + 1;
end

% Figures amb els resultats
figure();
for i = 1:(p-1)
    leg = [num2str(bw(i)), ' kg'];

plot(results(1,:,i),results(2,:,i),'linewidth',2,'DisplayName',leg);
hold on;
end
legend show;
limitsY = get(gca,'ylim');
X = [0.2 0.2 1 1];
Y = [70 140 140 70];
fill(X,Y,'g','FaceAlpha',0.15,'EdgeAlpha',0.1);
xlabel('Insulina (U/h)');ylabel('IG (mg/dl)');
xlim([0.2 1]);