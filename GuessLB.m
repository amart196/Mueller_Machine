function LBave = GuessLB(Lam,M44,th,eps1);

[peaks,locs]=findpeaks(squeeze(M44));
if numel(locs) > 1
    Data = -Lam(locs(1))+Lam(locs(2));
else
    Data = 500;
end

x=2;
p(2,:)=linspace(2.3,3.5,x);
m=0;
for e = 1:x
    m=m+1;
    for f = 1:length(Lam)
        MM(:,:)=PW2e11(Lam(f),0,0,eps1,p(2,e),th);
        Value(m,f)=MM(4,4);
    end
    [peaks,locs]=findpeaks(squeeze(Value(m,:)));
    Train(m)=-p(2,e)+eps1;
    if numel(locs) > 1
        Value2(m)=Lam(locs(2))-Lam(locs(1));
    else Value2(m)=500;
    end
end

LBa=svmtrain(Train',Value2', '-s 3 -c 10 -t 1 -g 1 -r 1 -d 3');
[LBave,acc,decV] = svmpredict(.2,Data,LBa, ['libsvm_options']);

end
