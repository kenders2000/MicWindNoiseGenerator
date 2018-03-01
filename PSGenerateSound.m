function [FilteredNoise]=PSGenerateSound(Nfft,Fs,V)
%% Generates 
%      Nfft=4096*10;


    F_ = Fs * [1:Nfft/2-1]' / Nfft;      % Array of linear-spaced positive frequencies (omits 0Hz & Nyquist for now)
c0=343;
k=2*pi*F_/V;
% pol=polyfit(log10(Wspeed),log10(CV2),1);
pol=  [1.9310   -4.6008];
CV2=10^polyval(pol,log10(V));
  CV2=10e-6*c0^2;
p=2/3;
Kolm=CV2*...
    gamma(p+1)/(2*pi)...
    *sin(0.5*pi*p);
F_const=Kolm;
pv=[    0.2228...
   -5.6890...
   53.0741...
   44.7725...
  364.1323]/10000;
v2m=sqrt(polyval(pv,V));
%  v1m=0.1+V/13;
   v2m=sqrt(0.59);

     F_const=0.052;
rho=1.21;
gp=1.14*rho^2*(V^2+11/3*v2m^2)*F_const*k.^(-5/3)...
 -5.89*F_const^2*k.^(-7/3);
gp=gp/V*2*pi;

%%%%%%%

%  Kolm=CV2*...
%      gamma(p+1)/(2*pi)...
%      *sin(0.5*pi*p)*k.^(-5/3);
% % % % % % % %  gp=0.5*rho*(V+(Kolm.^(0.5))).^2;
% % % % % % %   gp=rho*V^2 +rho^2*V^2*Kolm;%+0.5*rho*Kolm;
%        gp=Kolm*rho^2*V^2*2*pi/V;%+0.5*rho*Kolm;
%     gp=Kolm;
% 

% gp=gp*343/(2*pi)
    AsdDoubleSided=([0; gp; 0; flipud(gp)]/2)*F_(1);
    P=sqrt(AsdDoubleSided);
    F = Fs * [0:Nfft-1]' / Nfft;      % Array of linear-spaced positive frequencies (omits 0Hz & Nyquist for now)
% filterdes=fir2(5000, (0:(Nfft/2))/(Nfft/2), P(1:(Nfft/2+1))');
% FilteredVel1=filter(filterdes,1,randn(1,Nfft));
    ph = [2*pi*rand(Nfft/2-1,1)];   % Randomised phase
    ph = [0; ph; 0; -flipud(ph)];    % Copy to negative frequencies
    P = P .* exp(j*ph);
    FilteredVel = real(ifft(Nfft*P));%/20e-6;     % IFFT to get filtered noise in Pascals.  Matlab's IFFT expects an amplitude spectrum multiplied by Nfft
      FilteredNoise=FilteredVel; ;    
    
% 
%           FilteredNoise=(rho*V^2 +rho^2*V^2*FilteredVel+0.5*rho*FilteredVel.^2)/(20e-6);;

          
          %            FilteredNoise=FilteredNoise-mean(FilteredNoise);
%        [p2 f]=pwelch(FilteredNoise,[],[],[],Fs);
%             loglog(f*2*pi/V,(p2))        
%            hold on
%                       loglog(k,gp,'k')
%           xlim([0.1 1000])
%            ylim([1e-7 10])
%         hold off
        
        
        FilteredNoise=FilteredNoise/20e-6;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%          [p2 f]=pwelch(FilteredNoise,[],[],[],Fs);
%           semilogx(f,10*log10(p2))        
%            hold on
%           semilogx(k/(2*pi)*V,20*log10(sqrt(gp)/20e-6),'k')
%           xlim([0.1 10000])
%            ylim([0 120])
%         hold off
              
        
%     FilteredNoise=FilteredNoise/mean(sqrt(FilteredNoise.^2));
% FilteredNoise=FilteredNoise*mean((L_));
%     %     plot(FilteredNoise)
% % 
%     [p f]=pwelch(FilteredNoise,[],[],[],Fs);
% % %   
%       loglog(2*pi*F_/343,(gp),'r');  
%       hold on
%      loglog(2*pi*f/343,(p),'k');
%       hold off
%       
%                 xlim([0.1 1000])
%          ylim([10e-7 10])
