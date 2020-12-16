function IDn = PID(k0,k1,k2,target,SG,Kp,Ti,Td,t,gamma)
IDn=zeros(t);
Ip_1=0.5;
Ip_2=0.5;
In_1=0;
ID_1=0;
for n =1:t
    Pn=Kp*(SG(n)-target);
    In=In_1+Kp/(Ti*(SG(n)-target));
    Dn=Kp*Td*(SG(n)-SG(n-1)/(n-(n-1)));
    PIDn=Pn+In+Dn;
    Ipn=k0*ID_1+k1*Ip_1-k2*Ip_2;
    IDn(n)=(1+gamma)*PIDn-(gamma*Ip_1);
    Ip_2=In_1;
    Ip_1=Ipn;
    In_1=In;
    ID_1=IDn(n);
end
