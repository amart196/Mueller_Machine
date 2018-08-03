%Testing Fourier Transform
function c = FourierTransform(Lam,MM4,width);
w = width/2;
for x = 1:length(Lam)
    if (x > w) && (x < (length(Lam)-w))
        LamNew = Lam(x-w:x+w);
        Fs = (LamNew(length(LamNew))-LamNew(1))/length(LamNew);
        t = (0:length(LamNew)-1)/Fs;
        Y = fft(MM4((x-w):(x+w)));
        L=length(LamNew);
        P2=abs(Y/L);
        P1=P2(1:L/2+1);
        P1(2:end-1)=2*P1(2:end-1);
        P1=squeeze(P1);
        f = squeeze(Fs*(0:(L/2))/L);
        c(x) = mean(P1);
    elseif (x < w)
        LamNew = Lam(1:width);
        Fs = (LamNew(length(LamNew))-LamNew(1))/length(LamNew);
        t = (0:length(LamNew)-1)/Fs;
        Y = fft(MM4(1:51));
        L=length(LamNew);
        P2=abs(Y/L);
        P1=P2(1:L/2+1);
        P1(2:end-1)=2*P1(2:end-1);
        P1=squeeze(P1);
        f = squeeze(Fs*(0:(L/2))/L);
        c(x) = mean(P1);
    else
        LamNew = Lam(length(Lam)-w:length(Lam));
        Fs = (LamNew(length(LamNew))-LamNew(1))/length(LamNew);
        t = (0:length(LamNew)-1)/Fs;
        Y = fft(MM4(1:length(LamNew)));
        L=length(LamNew);
        P2=abs(Y/L);
        P1=P2(1:L/2+1);
        P1(2:end-1)=2*P1(2:end-1);
        P1=squeeze(P1);
        f = squeeze(Fs*(0:(L/2))/L);
        c(x) = mean(P1);
    end
end