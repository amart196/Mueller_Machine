function Env = CalcM23Envelope(Lam,Sim1,d)
[peaks,locs]=findpeaks(squeeze(Sim1));
options = optimoptions('lsqcurvefit','FunctionTolerance',1e-6,'OptimalityTolerance',1e-10,'StepTolerance',1e-6,'MaxFunctionEvaluations', 20000,'MaxIterations',5000);
p0=[1 155];
LB=[0 0];
UB=[1000 300];
p=p0;
Lams=Lam(locs);
[p_out]=lsqcurvefit(@(p,Lams)alpha(p,Lams),p0,Lams,peaks',LB,UB,options);
lam2 = Lam.^2;
Env = Lam.^3*(p_out(1))./(lam2 - p_out(2)^2).^2;
% plot(Lam,squeeze(Sim1),'red',Lam,envelope,'blue');
