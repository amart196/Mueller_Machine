function [epsilon,alpha]=LearnDC346(Lam,d,Ydata,DC346e1,DC346de2,DC346a1,DC346a3);

for x = 1:length(Lam)
    [epsilon(1,x),acc,decV] = svmpredict(.2,Ydata(x,:),DC346e1, ['libsvm_options']);
    [epsilon(2,x),acc,decV] = svmpredict(.2,Ydata(x,:),DC346de2, ['libsvm_options']);
    [alpha(1,x),acc,decV] = svmpredict(.2,Ydata(x,:),DC346a1, ['libsvm_options']);
    [alpha(2,x),acc,decV] = svmpredict(.2,Ydata(x,:),DC346a3, ['libsvm_options']);

end
alpha=alpha/10000;
end