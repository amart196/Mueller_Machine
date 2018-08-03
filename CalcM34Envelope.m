function [Upper,Lower] = CalcM34Envelope(Lam,M34)

% clear all
% close all
% Lam=linspace(400,800,150);
% M34 = 0*Lam.*cos(Lam/60);
Upper = zeros(length(Lam),1);
[peaks,locs]=findpeaks(squeeze(M34));
b= numel(peaks);
if b > 1
    a=Lam(locs);
    Upper=interp1(a,peaks,Lam,'linear','extrap');
elseif b == 1
    Upper(:) = peaks;
else
    Upper(:) = max(squeeze(M34));
end

Lower = zeros(length(Lam),1);
M34inv=M34*(-1);
[mins,locs]=findpeaks(squeeze(M34inv));
c= numel(mins);
if c > 1
    a=Lam(locs);
    Lower=interp1(a,-1*mins,Lam,'linear','extrap');
elseif c == 1
    Lower(:) = -1*mins;
else
    Lower(:) = -1*max(squeeze(M34inv));
end

    

% if numel(locs)>1;
%     options = optimoptions('lsqcurvefit','FunctionTolerance',1e-6,'OptimalityTolerance',1e-10,'StepTolerance',1e-6,'MaxFunctionEvaluations', 20000,'MaxIterations',5000);
%     p0=[0 50 .09];
%     LB=[0 0 0];
%     UB=[200 100000 1];
%     p=p0;
%     Lams=Lam(locs);
%     [p_out]=lsqcurvefit(@(p,Lams)EnvFit(p,Lams),p0,Lams',peaks,LB,UB,options);
%     lam2 = Lam.^2;
%     Env = 0*Lam.^3*(p_out(1))./(lam2 - p_out(2)^2).^2+.09;
% else
%     Env = 0*Lam;
% end
end