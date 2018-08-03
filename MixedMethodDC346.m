function [epsilon,a1,a3]=MixedMethodDC346(Lam,h,Ydata,DC346e1,DC346e3,DC346a1,MM3);

for x = 1:length(Lam)
    [epsilon(1,x),acc,decV] = svmpredict(.2,Ydata(x,:),DC346e1, ['libsvm_options']);
    [epsilon(2,x),acc,decV] = svmpredict(.2,Ydata(x,:),DC346e3, ['libsvm_options']);
    [a1(x),acc,decV] = svmpredict(.2,Ydata(x,:),DC346a1, ['libsvm_options']);
end
a1=a1/10000;
% DC346a3 = a3DC346(Lam,epsilon,a1,d);


Env = CalcM23Envelope(Lam,MM3(2,3,:),h);
% plot(Lam,squeeze(Sim1),'red',Lam,envelope,'blue');
a3 = GuessAlpha3(Lam,Env,epsilon(1,:),epsilon(2,:),a1(:),h);

% for x = 1:length(Lam)
%     [a3(x),acc,decV] = svmpredict(.2,Ydata(x,1:2),DC346a3, ['libsvm_options']);
% end
% a3=a3/10000;
end