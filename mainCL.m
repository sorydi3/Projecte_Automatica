function [controller,G] = mainCL(controller)
% Inicializate system
xguess = ones(9,1);
[x,~,~] = fsolve(@(x) model_hovorkaSS(x, controller.basal*1000/60, controller.pacient),xguess);
x(9) = controller.initial_BG/18;
controller.SG(1)=x(9)*18;
Xkm1 = [x; 0; 0]';
% Meals protocols
controller.num_menjars = length(controller.grams_cho);
controller.index_menjar = 1*(~isempty(controller.grams_cho));

hist_states = [];
u = zeros(1,2);
params.meal_time = 0;
controller.x = x;
for i = 1:controller.sim_time
    if strcmp(controller.tipus,'OL') == 1
        [u,controller,params] = OL(i,u,controller,params);
    elseif strcmp(controller.tipus,'PID') == 1
        [controller,u] = PID(i,u,controller);
        size_cho = size(controller.temps_cho);
        if controller.index_menjar <= size_cho(2)
            if i == controller.temps_cho(controller.index_menjar)*60
                disp(i)
                u(2) = controller.grams_cho(controller.index_menjar);
                controller.index_menjar = controller.index_menjar + 1;
            end
        end
    end
    
    [~,Xhov] = ode45(@(t,x) model_hovorka(t, x, u, controller.pacient), [i i+1], Xkm1); 
    controller.SG(i+1)=Xhov(end,9)*18; %update SG for the PID controller
    Xkm1 = Xhov(end,:)';
    hist_states = [hist_states; Xkm1'];
end

G = hist_states;
end
