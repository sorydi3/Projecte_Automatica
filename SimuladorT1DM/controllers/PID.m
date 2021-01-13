function [c,u] = PID(n,u,c) 
    size_cho = size(c.temps_cho);
    if c.index_menjar <= size_cho(2)
        if n == c.temps_cho(c.index_menjar)*60
            if n == 1
                In_1 = 0;
                SGn_1 = 0;
                IDn_1 = 0;
                Ipn_1 = c.inital_BG;
                Ipn_2 = c.inital_BG;
            elseif n == 2
                In_1 = c.I(n-1);
                SGn_1 = c.SG(n-1);
                IDn_1 = c.ID(n-1);
                Ipn_1 = c.Ip(n-1);
                Ipn_2 = c.inital_BG;
            else
                In_1 = c.I(n-1);
                SGn_1 = c.SG(n-1);
                IDn_1 = c.ID(n-1);
                Ipn_1 = c.Ip(n-1);
                Ipn_2 = c.Ip(n-2);
            end

            c.P(n)=c.Kp*(c.SG(n) - c.target);
            if (c.Ti*(c.SG(n)-c.target)) == 0
                c.I(n) = In_1;
            else
                c.I(n)=In_1+c.Kp/(c.Ti*(c.SG(n)-c.target));
            end
            c.D(n)=c.Kp*c.Td*(c.SG(n) - SGn_1/n);
            c.PID(n) = c.P(n)+c.I(n)+c.D(n);
            c.Ip(n)=c.k0*IDn_1+c.k1*Ipn_1-c.k2*Ipn_2;
            c.ID(n) =(1+c.gamma)*c.PID(n)-(c.gamma*Ipn_1);

            u(1)=c.grams_cho(c.index_menjar);
            u(2)=-c.ID(n);

            c.index_menjar = c.index_menjar + 1;

        end
    else
        u(1)=0;
        u(2)=-c.ID(n);
    end
    %disp(n)
end