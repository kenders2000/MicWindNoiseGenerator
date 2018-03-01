function [FilteredNoise L_3rd]=ThirdOctGenSound(F3rdcentre,BW,Nfft,Fs,D,V)
%% Generates
%     D=0.1;V=10;
%  Nfft=4096*10
    fc_shield=V/(3*D);
    L_3rd=40*log10(V)-6.67*log10(F3rdcentre*D/V)...
    -10*log10(1+(F3rdcentre/fc_shield).^2)+42;
    Strouhal=F3rdcentre*D/V;
    %        L_3rd=-6.67*log(Strouhal)...
    %         -10*log(1+(3*Strouhal).^2)+62.4; 

     L_=10.^(L_3rd/10);
       L_=(L_./BW');
%     L_=abs(L_);



    F_ = Fs * [1:Nfft/2-1]' / Nfft;      % Array of linear-spaced positive frequencies (omits 0Hz & Nyquist for now)
    
    Asd=interp1( log10([10e-50 ;(F3rdcentre)]),log10([1; (L_)]),log10([10e-50; (F_)]),'linear');%Asd(If)=0;
    Asd=Asd(2:end);%./F_;
    Asd=10.^Asd;
    
    AsdDoubleSided=[0; Asd; 0; flipud(Asd)]*F_(1)/2;AsdDoubleSided=sqrt(AsdDoubleSided);
    F = Fs * [0:Nfft-1]' / Nfft;      % Array of linear-spaced positive frequencies (omits 0Hz & Nyquist for now)
%     semilogx(Strouhal,L_3rd);xlim([0.1 10]);ylim([30 90])
%     hold on
%     semilogx(F_*D/V,20*log10(Asd),'r');xlim([0.1 10]);ylim([30 90])
    % plot(F,ph)

    P=AsdDoubleSided;
    ph = [2*pi*rand(Nfft/2-1,1)];   % Randomised phase
    ph = [0; ph; 0; -flipud(ph)];    % Copy to negative frequencies
    P = P .* exp(j*ph);
    FilteredNoise = real(ifft(P*Nfft));     % IFFT to get filtered noise in Pascals.  Matlab's IFFT expects an amplitude spectrum multiplied by Nfft
% FilteredNoise=FilteredNoise*(10^(-15/20));

    % FilteredNoise=FilteredNoise/sqrt(mean(FilteredNoise.^2));
%  FilteredNoise=FilteredNoise*sqrt(mean(L_.^2));
% [Pjon fjon] = ThirdOctA2NBlin(F3rdcentre,L_3rd,Fs,Nfft)  ;  
%     close all
%     [p3rd,f3rd] = filtbank(FilteredNoise,Fs,[],'extended'); 
%     semilogx(f3rd,p3rd)
%     hold on
%     semilogx(F,20*log10(Pjon))
%     semilogx(F3rdcentre,L_3rd,'r');%xlim([0.1 10]);ylim([30 90])
    %     Lp3A_check = ThirdOctSum(F,abs(P));
%     FilteredNoise=FilteredNoise/mean(sqrt(FilteredNoise.^2));
%     FilteredNoise=FilteredNoise*mean((L_));
%     


%     [p f]=pwelch(FilteredNoise,[],[],[],Fs);
%      semilogx(F_,20*log10(Asd),'r');  
%      hold on
%      semilogx(f,10*log10(p),'k');
% %     hold off
% ylim([0 120])
