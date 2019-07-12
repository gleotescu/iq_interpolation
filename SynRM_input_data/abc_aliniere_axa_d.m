id=0:20:220;
iq=0:20:220;
ia=[];ib=[];ic=[];
for d=1:1:12
    iad=[];ibd=[];icd=[];
    for q=1:1:12
        is=sqrt(iq(q)^2+id(d)^2);
        k=atan(iq(q)/id(d));
        a=id(d);
        c=-is*cos(pi/3-k);
        b=-(a+c)
        iad=[iad a];ibd=[ibd b];icd=[icd c];
    end
    ia=[ia; iad];ib=[ib; ibd];ic=[ic; icd];
end

