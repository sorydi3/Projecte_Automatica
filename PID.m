function [c,u] = PID(n,u,c) 
    if n == 1
        In_1 = 0;
        SGn_1 = c.SG(n);
        IDn_1 = 0;
        Ipn_1 = c.x(3)/1000*c.pacient(6);
        Ipn_2 = c.x(3)/1000*c.pacient(6);
    elseif n == 2
        In_1 = c.I(n-1);
        SGn_1 = c.SG(n-1);
        IDn_1 = c.ID(n-1);
        Ipn_1 = c.Ip(n-1);
        Ipn_2 = c.x(3)/1000*c.pacient(6);
    else
        In_1 = c.I(n-1);
        SGn_1 = c.SG(n-1);
        IDn_1 = c.ID(n-1);
        Ipn_1 = c.Ip(n-1);
        Ipn_2 = c.Ip(n-2);
    end

    c.P(n)=c.Kp*(c.SG(n) - c.target);
    c.I(n)=In_1+c.Kp/c.Ti*(c.SG(n)-c.target);
    c.D(n)=c.Kp*c.Td*((c.SG(n) - SGn_1)/1);
    c.PID(n) = c.P(n)+c.I(n)+c.D(n);
    c.Ip(n)=c.k0*IDn_1+c.k1*Ipn_1-c.k2*Ipn_2;
    c.ID(n) =(1+c.gamma)*c.PID(n)-(c.gamma*Ipn_1);

    u(2)=0;
    u(1)=c.ID(n)*1000/60;
end