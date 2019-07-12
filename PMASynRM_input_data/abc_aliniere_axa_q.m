iq=0:10:180;
id=0:10:180;
ia=[];ib=[];ic=[];
for d=1:1:19
    iad=[];ibd=[];icd=[];
    for q=1:1:19
        is=sqrt(iq(q)^2+id(d)^2);
        k=atan(iq(q)/id(d));
        a=iq(q);
        b=-is*cos(k-pi/6);
        c=-(a+b);
        iad=[iad; a];ibd=[ibd; b];icd=[icd; c];%se adauga rand
    end
    ia=[ia iad];ib=[ib ibd];ic=[ic icd];%se adauga coloana
end


 