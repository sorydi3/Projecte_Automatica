function controller = init_parameters_pid()
    controller.k1=1.966308;
    controller.k2=0.966584;
    controller.k0=1-controller.k1+controller.k2;
    controller.target=90;
    controller.gamma=0.5;
    controller.Kp=0; %%set proporcianally to daily insuline requirment
    controller.Ti=150;
    controller.Td=90*60; %change it to minutes
    controller.SG_1=0;
    controller.Ip_1=0;
    controller.Ip_2=0;
    controller.In_1=0;
    controller.ID_1=0;
    controller.IDn=0;
    controller.SG=0;
end