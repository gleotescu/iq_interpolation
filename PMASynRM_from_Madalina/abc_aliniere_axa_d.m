% In=57.4 [A] => Imax= 180 [A]
% Iq = ct = 180 [A]

id=0:10:180;
iq=0:10:180;
ia=[];ib=[];ic=[];
for d=1:1:19  
    iad=[];ibd=[];icd=[];
    for q=1:1:19   % Iq variaza, iar Id ramane constant!!!
        is=sqrt(iq(q)^2+id(d)^2);
        k=atan(iq(q)/id(d));
        a=id(d);
        c=-is*cos(pi/3-k);
        b=-(a+c)
        iad=[iad a];ibd=[ibd b];icd=[icd c];
    end
    ia=[ia; iad];ib=[ib; ibd];ic=[ic; icd];
end



% Id_Iq0=[];
% Id_Iq0=[Id_Iq0 ia(:,1) ib(:,1) ic(:,1)];
% 
% Id_Iq10=[];
% Id_Iq10=[Id_Iq10 ia(:,2) ib(:,2) ic(:,2)];
% 
% Id_Iq20=[];
% Id_Iq20=[Id_Iq20 ia(:,3) ib(:,3) ic(:,3)];
% 
% Id_Iq30=[];
% Id_Iq30=[Id_Iq30 ia(:,4) ib(:,4) ic(:,4)];
% 
% Id_Iq40=[];
% Id_Iq40=[Id_Iq40 ia(:,5) ib(:,5) ic(:,5)];
% 
% Id_Iq50=[];
% Id_Iq50=[Id_Iq50 ia(:,6) ib(:,6) ic(:,6)];
% 
% Id_Iq60=[];
% Id_Iq60=[Id_Iq60 ia(:,7) ib(:,7) ic(:,7)];
% 
% Id_Iq70=[];
% Id_Iq70=[Id_Iq70 ia(:,8) ib(:,8) ic(:,8)];
% 
% Id_Iq80=[];
% Id_Iq80=[Id_Iq80 ia(:,9) ib(:,9) ic(:,9)];
% 
% Id_Iq90=[];
% Id_Iq90=[Id_Iq90 ia(:,10) ib(:,10) ic(:,10)];
% 
% Id_Iq100=[];
% Id_Iq100=[Id_Iq100 ia(:,11) ib(:,11) ic(:,11)];
% 
% Id_Iq110=[];
% Id_Iq110=[Id_Iq110 ia(:,12) ib(:,12) ic(:,12)];
% 
% Id_Iq120=[];
% Id_Iq120=[Id_Iq120 ia(:,13) ib(:,13) ic(:,13)];
% 
% Id_Iq130=[];
% Id_Iq130=[Id_Iq130 ia(:,14) ib(:,14) ic(:,14)];
% 
% Id_Iq140=[];
% Id_Iq140=[Id_Iq140 ia(:,15) ib(:,15) ic(:,15)];
% 
% Id_Iq150=[];
% Id_Iq150=[Id_Iq150 ia(:,16) ib(:,16) ic(:,16)];
% 
% Id_Iq160=[];
% Id_Iq160=[Id_Iq160 ia(:,17) ib(:,17) ic(:,17)];
% 
% Id_Iq170=[];
% Id_Iq170=[Id_Iq170 ia(:,18) ib(:,18) ic(:,18)];
% 
% Id_Iq180=[];
% Id_Iq180=[Id_Iq180 ia(:,19) ib(:,19) ic(:,19)];

