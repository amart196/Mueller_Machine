function Env = CalcM34Envelope(Lam,M34)

[peaks,locs]=findpeaks(squeeze(M34));

if numel(locs)>1;
    options = optimoptions('lsqcurvefit','FunctionTolerance',1e-6,'OptimalityTolerance',1e-10,'StepTolerance',1e-6,'MaxFunctionEvaluations', 20000,'MaxIterations',5000);
    p0=[0 0];
    LB=[0 0];
    UB=[5000 300];
    p=p0;
    Lams=Lam(locs);
    [p_out]=lsqcurvefit(@(p,Lams)alpha(p,Lams),p0,Lams',peaks,LB,UB,options);
    lam2 = Lam.^2;
    Env = Lam.^3*(p_out(1))./(lam2 - p_out(2)^2).^2;
else
    Env = Lam;
end
end