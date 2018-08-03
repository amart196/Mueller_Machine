function f = frequency(Lam,M44);

[peaks,locs]=findpeaks(squeeze(M44));
a = numel(peaks)-1;
if a > 0
    v = zeros(1,numel(peaks));
    for x = 1:a
        v(x) = (locs(x+1)-locs(x));
    end
    v(a+1)=v(a);
    f = interp1(Lam(locs),v,Lam,'linear','extrap');
else
    f = 800;
% plot(Lam,f,'green');
% plot(Lam(locs),v,'red');
end