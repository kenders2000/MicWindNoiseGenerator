%generate Wind Noise Examples

clear all
close all
Fs=44100;
T=10;%  % length of wind noise to generate, note 2 sec is added on to this value

load velocities.mat; %examples of wind velocity histories


targetV=2;% Target wind velocity to generate
done=0;
while done==0  % brute force, searches for T s chunk with ave vel of targetV
    
    winN=0.1*Fs;% Window used for wind velocity time data
    win0verT=0.025;% overlap, start of window moved on by this for each subsequent window used for wind velocity time data
    overlap=1-((win0verT*Fs)/winN); % overlap in samples
    
    Vel=Vel_cell{ceil(rand()*length(Vel_cell))}; %select random long-time record
    VFs=10;% sampling freq for wind vel
    % Select a chunk of wind vels
    R=round(rand(1)*(length(Vel)-1000));
    Vel=Vel((1:1000)+R);
    
    t=0:1/VFs:((length(Vel)-1)/VFs);%actual resolution of  veloicty data
    tr=0:win0verT:((length(Vel)-1)/VFs);%smoothed resolution of  veloicty data
    Length_sample=T+2;

    Velr=interp1(t,Vel,tr,'linear'); %interpolate wind velocites
    N=floor(Length_sample/(tr(2)));% new sample length
    R=round(rand(1)*(length(Velr)-N-(Length_sample-1)));% random Starting point from available recording
    Velr=Velr((1:N)+R);% select chunk of interpolated vels
    % if we are within  0.5 m/s accept the chunk
    if abs(targetV-mean(Velr))<0.5
        done=1;
    end
end
    
%Generate the wind noise
[sim_real sim_fake_s sim_fake_us]=Generate_wind_noise_function(Fs,Velr,winN,win0verT,overlap,Length_sample,0.1);    
%soundsc(sim_real,Fs)
sim_real; % real microphone wind noise without shield
sim_fake_s; % simulated wind noise with wind shield
sim_fake_us; % simulated wind noise without shield
