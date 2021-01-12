function G = mainCL(controller)
% Iniciem el sistema a estat estacionari
xguess = ones(9,1);
%controller = init_parameters_pid(controller);
[x,~,~] = fsolve(@(x) model_hovorkaSS(x, controller.basal*1000/60, controller.pacient),xguess);
controller.Kp = 0.8;
x(9) = controller.initial_BG;
controller.SG(1)=x(9);
Xkm1 = [x; 0; 0]'; % + estats de l'absorcio de carbohidrats

% Protocol de menjars
controller.num_menjars = length(controller.grams_cho);
controller.index_menjar = 1*(~isempty(controller.grams_cho));

hist_states = [];
u = zeros(1,2);
params.meal_time = 0;
%controler.target=1000;
for i = 1:controller.sim_time
    if strcmp(controller.tipus,'OL') == 1
        [u,controller,params] = OL(i,u,controller,params);
    elseif strcmp(controller.tipus,'PID') == 1
        [controller,u] = PID(i,u,controller);
        %u = u*60/1000;
    end
    
    [~,Xhov] = ode45(@(t,x) model_hovorka(t, x, u, controller.pacient), [i i+1], Xkm1); 
    controller.SG(i)=x(9); %%update SG for the PID controller
    Xkm1 = Xhov(end,:)';
    hist_states = [hist_states; Xkm1'];
    disp(hist_states);
end

% Mostrem resultats per pantalla
G = hist_states(:,9)*18;
plot((1:controller.sim_time)./60,hist_states(:,9)*18); hold on;
xlim([0 24]);
limitsY = get(gca,'ylim');
X = [0 0 controller.sim_time/60 controller.sim_time/60];
Y = [70 140 140 70]; fill(X,Y,'g','FaceAlpha',0.15,'EdgeAlpha',0.1);
xlabel('Time (h)'); ylabel('G (mg/dl)');
