function [sim_real sim_fake_s sim_fake_us]=Generate_wind_noise_function(Fs,Velr,winN,win0verT,overlap,Length_sample,D)
    
%  files_wind=dir('wind_nr_32bit_audition');
% files_wind=dir('wind_noise_simulator2');
files_wind=dir('higher_res_wind_data_art_scale\*.wav')

ii=1;
n=0;
clear  ave_speed sig  gain sig
for i2=(3):length(files_wind)
    n=n+1;
    str2=files_wind(i2).name;
    A = textscan(str2,'%s %s %n %s %s %s %n %n %s ');
    A{3}
    ave_speed(n)=A{7};%tr2num({1});
    sig(n)=A{8};%str2num({1}(1:));
    if length(A{9}{1})<=4
    else
        gain(n) =str2num(A{9}{1}(1:3));
    end
    file_list_sim(n).str2=str2;
end
%%%%%%%%%%%%%%%%%%%%%%%%
    winN_overall=round(Length_sample*Fs);
    N1=1;
    sim_fake_s=zeros(winN_overall,1);
    sim_fake_us=zeros(winN_overall,1);
    sim_real=zeros(winN_overall,1);
    clear F3rdcentre BW F3rdlim
 F3rdlim=zeros(80,1);
    F3rdcentre=F3rdlim;
    F3rdcentre(1)=12.5/(2^8);
    clear BW power_13rd  f1 f2
    for ii=1:80
        
        f1(ii)=F3rdcentre(ii)/(2^(1/6));
        f2(ii)=f1(ii)*(2^(1/3));
        BW(ii)=(2^(1/6)-1/(2^(1/6)))*F3rdcentre(ii);%F3rdlim(ii)-F3rdlim(ii-1);
        F3rdcentre(ii+1)=F3rdcentre(ii)*2^(1/3);
        
    end
    F3rdcentre=F3rdcentre(1:length(BW));
    %%
%     N1s=1:round(winN*(1-overlap)):Length_sample*Fs;
    for i=1:(length(Velr)-1/win0verT-1)
       clc
       sprintf("Percentage complete %g",100*i/(length(Velr)-1/win0verT-1))
       drawnow
        %%%%%%%%%%%%%%%%%%%%%%%%% 4 - 0.1  15 0.5
%         D=0.1;
        V=Velr(i);
%                V=6.9
%            winN=4410*10;
        %     semilogx(Strouhal,(L_));xlim([0.1 10]);ylim([30 90])
        [FilteredNoiseS L_3rd]=ThirdOctGenSound(F3rdcentre,BW,winN,Fs,D,V);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [FilteredNoiseUS]=PSGenerateSound(winN,Fs,V);
        
       Strouhal=F3rdcentre*D/V;
        
        [null I]=min(abs(ave_speed-Velr(i)));
        
             [null I]=min(abs(ave_speed-V));
        
        if (Velr(i)>min(ave_speed))
            
               file=sprintf('higher_res_wind_data_art_scale/%s',file_list_sim(I).str2);
             
             SIZ=audioinfo(file);SIZ=SIZ.TotalSamples;
            winS=50*Fs;
            FromSpeech=ceil((SIZ(1)-winS)*rand(1));
            
            RealNoiseUS=audioread(file,[FromSpeech FromSpeech+winN-1] );
        else
            RealNoiseUS=zeros(winN,2);
        end
        
%         RealNoiseUS=RealNoiseUS(:,1)*((10^abs(gain(I)/20))*10^((94)/20))/0.08638;

    RealNoiseUS=(10^abs(gain(I)/20))*10^((94+20)/20)*RealNoiseUS(:,1)/0.08638;
%         RealNoiseUS=RealNoiseUS(:,1)*(10^abs(gain(I)/20));%*10^((94)/20))/0.08638;
        [p1 f]=pwelch(FilteredNoiseS,hanning(Fs*.1),[],[],Fs);
        [p2 f]=pwelch(FilteredNoiseUS,hanning(Fs*.1),[],[],Fs);
        [p3 f]=pwelch(RealNoiseUS,hanning(Fs*.1),[],[],Fs);
        
%             AwdB = Aw_dB(f);
            
%         plot(FilteredNoiseUS)
%          semilogx(f*2*pi/343,10*log10((p1)),'LineWidth',2) 
%          hold on
%          semilogx(f*2*pi/343,10*log10(p2)+20,'r','LineWidth',2) 
%          semilogx(f*2*pi/343,10*log10(p3),'k','LineWidth',2) 
%          
%          semilogx(f*2*pi/343,10*log10(  ((f*2*pi/343).^(-5/3)) ),'g','LineWidth',2) 
%          semilogx(F3rdcentre*2*pi/343,10*log10((F3rdcentre*2*pi/343).^(-5/3))+80,'r','LineWidth',2) 
%       ylim([0 80])
%       xlim([0.1 1000])      
%          hold off

         
         
%          ylim([1e-7 10]);  xlim([0.1 1000])
        %             semilogx(f,10*log10(p))
        %          hold on
        %          semilogx(f,10*log10(p2),'r')
        %          legend('Wind shield','un shielded')
        %         xlim([0.1 1000])
        %          ylim([30 120])
        %          drawnow
        %         hold off
        %         RealNoiseUS=temp;
        
       %%
        N2=(N1+winN-1);
        
        temp=RealNoiseUS(:,1).*tukeywin(length(RealNoiseUS));
        sim_real(N1:N2)=sim_real(N1:N2)+temp;
        
        temp=FilteredNoiseUS.*tukeywin(length(FilteredNoiseUS));
        sim_fake_us(N1:N2)=sim_fake_us(N1:N2)+temp;
        
        temp=FilteredNoiseS.*tukeywin(length(FilteredNoiseS));
        sim_fake_s(N1:N2)=sim_fake_s(N1:N2)+temp;
        
        N1=N1+round(winN*(1-overlap));
        
    end
    
    

    %      sim_n=sim_n;%/((winN/(win0verT*Fs))/2);
    %     sim_c=sim_c;%/((winN/(win0verT*Fs))/2);
    %  [p f]=pwelch(sim_n,[],[],[],Fs);
    %   [p1 f]=pwelch(Y_sel_norm,[],[],[],Fs);
    %  semilogx(f,10*log10(p))
    %  hold on
    %   semilogx(f,10*log10(p1),'k')
    %  hold on
    %     semilogx(F3rdcentre,L_3rd,'r');xlim([0.1 10000]);ylim([30 90])
    %     hold off
    %
    %      xlim([0.1 10]);ylim([30 90])
    %
    sim_real=sim_real((1:Length_sample*Fs-1*Fs));%*10^((94)/20)/0.08638;
    sim_fake_us=sim_fake_us((1:Length_sample*Fs-1*Fs));
    sim_fake_s=sim_fake_s((1:Length_sample*Fs-1*Fs));