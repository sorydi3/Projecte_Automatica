function [controller,u] = PID(sim_time,u,controller) 
    %disp(controller)
    Pn=controller.Kp*(controller.SG - controller.target);
    if (controller.Ti*(controller.SG-controller.target)) == 0
        In = controller.In_1;
    else
        In=controller.In_1+controller.Kp/(controller.Ti*(controller.SG-controller.target));
    end
    Dn=controller.Kp*controller.Td*(controller.SG - controller.SG_1/1);
    PIDn =Pn+In+Dn;
    Ipn=controller.k0*controller.ID_1+controller.k1*controller.Ip_1-controller.k2*controller.Ip_2;
    if isnan(Ipn)
        disp(controller)
    end
    IDn =(1+controller.gamma)*PIDn-(controller.gamma*controller.Ip_1);
    controller.Ip_2=controller.In_1;
    controller.Ip_1=Ipn;
    controller.In_1=In;
    controller.ID_1=IDn;
    controller.SG_1=controller.SG;
    u(2)=0;
    u(1)=IDn;
end