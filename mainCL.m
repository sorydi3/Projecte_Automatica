function mainCL(controller)
% Iniciem el sistema a estat estacionari
xguess = ones(9,1);
[x,fval,exitflag] = fsolve(@(x) model_hovorkaSS(x, controller.basal*1000/60, controller.pacient),xguess);
x(9) = controller.initial_BG;
Xkm1 = [x; 0; 0]'; % + estats de l'absorcio de carbohidrats

% Protocol de menjars
controller.num_menjars = length(controller.grams_cho);
controller.index_menjar = 1*(~isempty(controller.grams_cho));

hist_states = [];
u = zeros(1,2);
for i = 1:controller.sim_time
    
    if strcmp(controller.tipus,'OL') == 1
        u = OL(i,u,controller);
    elseif strcmp(controller.tipus,'PID') == 1
        u = PID(i,u,controller);
    end
    
    [~,Xhov] = ode45(@(t,x) model_hovorka(t, x, u, controller.pacient), [i i+1], Xkm1);
    Xkm1 = Xhov(end,:)';
    hist_states = [hist_states; Xkm1'];
end

% Mostrem resultats per pantalla
plot((1:controller.sim_time)./60,hist_states(:,9)*18); hold on;
xlim([0 24]);
limitsY = get(gca,'ylim');
X = [0 0 controller.sim_time/60 controller.sim_time/60];
Y = [70 140 140 70]; fill(X,Y,'g','FaceAlpha',0.15,'EdgeAlpha',0.1);
xlabel('Time (h)'); ylabel('G (mg/dl)');