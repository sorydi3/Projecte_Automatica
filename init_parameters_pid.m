function controller = init_parameters_pid(controller)
    controller.k1=1.966308;
    controller.k2=0.966584;
    controller.k0=1-controller.k1+controller.k2;
    controller.target=90;
    controller.gamma=0.5;
    controller.Kp=0.74; %%set proporcianally to daily insuline requirment
    controller.Ti=450;
    controller.Td=90*60; %change it to minutes
    controller.SG=zeros(controller.sim_time,1);
    controller.Ip=zeros(controller.sim_time,1);
    controller.I=zeros(controller.sim_time,1);
    controller.P=zeros(controller.sim_time,1);
    controller.D=zeros(controller.sim_time,1);
    controller.PID=zeros(controller.sim_time,1);
    controller.ID=zeros(controller.sim_time,1);
end