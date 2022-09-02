eeglab;
[S, H] = pop_loadbv('C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data','019_BVA.vhdr',[],[]);
prompt = "introduce subject number ";
number = input(prompt);
time=[S.event.latency];
duration=[S.event.duration];
type={S.event.type};
epoch=[S.event.epoch];
eeg=[S.data];

%%
index_conneg_follow_type=find(type=="B1(S7)");
index_conneg_follow_epoch= zeros(size(index_conneg_follow_type));
for i=1:length(index_conneg_follow_type)
index_conneg_follow_epoch(i)=epoch(index_conneg_follow_type(i));
end

ConnegFollow=zeros(size(eeg,1),size(eeg,2),length(index_conneg_follow_epoch));
for i=1:length(index_conneg_follow_epoch)
ConnegFollow(:,:,i)=eeg(:,:,index_conneg_follow_epoch(i));
end
%%
index_conneg_break_type=find(type=="B2(S7)");
index_conneg_break_epoch= zeros(size(index_conneg_break_type));
for i=1:length(index_conneg_break_type)
index_conneg_break_epoch(i)=epoch(index_conneg_break_type(i));
end

ConnegBreak=zeros(size(eeg,1),size(eeg,2),length(index_conneg_break_epoch));
for i=1:length(index_conneg_break_epoch)
ConnegBreak(:,:,i)=eeg(:,:,index_conneg_break_epoch(i));
end



%%
for i=1:length(index_conneg_follow_epoch)
ConnegFollow_1(:,:,i)=ConnegFollow(:,:,i)';
end

for i=1:length(index_conneg_break_epoch)
ConnegBreak_1(:,:,i)=ConnegBreak(:,:,i)';
end


%%
time_table = readtable(['rejected_trials_subject_' int2str(number) '.xlsx']);
follow_rt_indexes= find(time_table.Var5=="follow");
break_rt_indexes= find(time_table.Var5=="break");

if length(follow_rt_indexes)>0
for i=1:length(follow_rt_indexes)
    follow_times(i)=time_table.Var3(follow_rt_indexes(i));
    if time_table.Var3(follow_rt_indexes(i))>1200
        follow_times(i)=1200;
    end
    follow_times(i)=((follow_times(i))*300)/1200;
    follow_times(i)=round(follow_times(i));
end
end

if length(break_rt_indexes)>0
for i=1:length(break_rt_indexes)
    break_times(i)=time_table.Var3(break_rt_indexes(i));
    if time_table.Var3(break_rt_indexes(i))>1200
        break_times(i)=1200;
    end
    break_times(i)=((break_times(i))*300)/1200;
    break_times(i)=round(break_times(i));
end
end

if exist('follow_times','var')
for i=1:length(follow_times)
    
   [follow_pwelch,f] = pwelch(ConnegFollow_1(1:follow_times(i),:,i));
    frequencies = find((f<=12)&(f>=0.5));
    delta_frequencies = find((f<=4)&(f>=0.5));
    theta_frequencies = find((f<=8)&(f>=4));
    alpha_frequencies = find((f<=12)&(f>=8));
    
    follow_psd(:,:,i)=follow_pwelch(frequencies,:);
    follow_psd(:,:,i)= 10*log10(follow_psd(:,:,i));
    
    follow_psd_delta(:,:,i)=follow_pwelch(delta_frequencies,:);
    follow_psd_delta(:,:,i)= 10*log10(follow_psd_delta(:,:,i));
    
    follow_psd_theta(:,:,i)=follow_pwelch(theta_frequencies,:);
    follow_psd_theta(:,:,i)= 10*log10(follow_psd_theta(:,:,i));
    
    follow_psd_alpha(:,:,i)=follow_pwelch(alpha_frequencies,:);
    follow_psd_alpha(:,:,i)= 10*log10(follow_psd_alpha(:,:,i));
end
end


if exist('break_times','var')
for i=1:length(break_times)
    
   [break_pwelch,f] = pwelch(ConnegBreak_1(1:break_times(i),:,i));
    frequencies = find((f<=12)&(f>=0.5));
    delta_frequencies = find((f<=4)&(f>=0.5));
    theta_frequencies = find((f<=8)&(f>=4));
    alpha_frequencies = find((f<=12)&(f>=8));
    
    break_psd(:,:,i)=break_pwelch(frequencies,:);
    break_psd(:,:,i)= 10*log10(break_psd(:,:,i));
    
    break_psd_delta(:,:,i)=break_pwelch(delta_frequencies,:);
    break_psd_delta(:,:,i)= 10*log10(break_psd_delta(:,:,i));
    
    break_psd_theta(:,:,i)=break_pwelch(theta_frequencies,:);
    break_psd_theta(:,:,i)= 10*log10(break_psd_theta(:,:,i));
    
    break_psd_alpha(:,:,i)=break_pwelch(alpha_frequencies,:);
    break_psd_alpha(:,:,i)= 10*log10(break_psd_alpha(:,:,i));
end
end 


mkdir(['subject_' int2str(number) '_psd']);

if exist('follow_times','var')
    
    
mkdir(['subject_' int2str(number) '_psd' '\Follow\Parietal\delta']);
mkdir(['subject_' int2str(number) '_psd' '\Follow\Parietal\theta']);
mkdir(['subject_' int2str(number) '_psd' '\Follow\Parietal\alpha']);


mkdir(['subject_' int2str(number) '_psd' '\Follow\Temporoparietal\delta']);
mkdir(['subject_' int2str(number) '_psd' '\Follow\Temporoparietal\theta']);
mkdir(['subject_' int2str(number) '_psd' '\Follow\Temporoparietal\alpha']);
    
    
    
mkdir(['subject_' int2str(number) '_psd' '\Follow\Frontocentral_1\delta']);
mkdir(['subject_' int2str(number) '_psd' '\Follow\Frontocentral_1\theta']);
mkdir(['subject_' int2str(number) '_psd' '\Follow\Frontocentral_1\alpha']);


mkdir(['subject_' int2str(number) '_psd' '\Follow\Frontal_1\delta']);
mkdir(['subject_' int2str(number) '_psd' '\Follow\Frontal_1\theta']);
mkdir(['subject_' int2str(number) '_psd' '\Follow\Frontal_1\alpha']);


mkdir(['subject_' int2str(number) '_psd' '\Follow\Frontal_2\delta']);
mkdir(['subject_' int2str(number) '_psd' '\Follow\Frontal_2\theta']);
mkdir(['subject_' int2str(number) '_psd' '\Follow\Frontal_2\alpha']);


mkdir(['subject_' int2str(number) '_psd' '\Follow\Frontal_right\delta']);
mkdir(['subject_' int2str(number) '_psd' '\Follow\Frontal_right\theta']);
mkdir(['subject_' int2str(number) '_psd' '\Follow\Frontal_right\alpha']);


mkdir(['subject_' int2str(number) '_psd' '\Follow\Frontal_left\delta']);
mkdir(['subject_' int2str(number) '_psd' '\Follow\Frontal_left\theta']);
mkdir(['subject_' int2str(number) '_psd' '\Follow\Frontal_left\alpha']);


mkdir(['subject_' int2str(number) '_psd' '\Follow\Frontocentral_2\delta']);
mkdir(['subject_' int2str(number) '_psd' '\Follow\Frontocentral_2\theta']);
mkdir(['subject_' int2str(number) '_psd' '\Follow\Frontocentral_2\alpha']);


mkdir(['subject_' int2str(number) '_psd' '\Follow\Frontocentral_right\delta']);
mkdir(['subject_' int2str(number) '_psd' '\Follow\Frontocentral_right\theta']);
mkdir(['subject_' int2str(number) '_psd' '\Follow\Frontocentral_right\alpha']);



mkdir(['subject_' int2str(number) '_psd' '\Follow\Frontocentral_left\delta']);
mkdir(['subject_' int2str(number) '_psd' '\Follow\Frontocentral_left\theta']);
mkdir(['subject_' int2str(number) '_psd' '\Follow\Frontocentral_left\alpha']);


mkdir(['subject_' int2str(number) '_psd' '\Follow\Central\delta']);
mkdir(['subject_' int2str(number) '_psd' '\Follow\Central\theta']);
mkdir(['subject_' int2str(number) '_psd' '\Follow\Central\alpha']);



mkdir(['subject_' int2str(number) '_psd' '\Follow\Temporal\delta']);
mkdir(['subject_' int2str(number) '_psd' '\Follow\Temporal\theta']);
mkdir(['subject_' int2str(number) '_psd' '\Follow\Temporal\alpha']);


mkdir(['subject_' int2str(number) '_psd' '\Follow\Centroparietal\delta']);
mkdir(['subject_' int2str(number) '_psd' '\Follow\Centroparietal\theta']);
mkdir(['subject_' int2str(number) '_psd' '\Follow\Centroparietal\alpha']);


mkdir(['subject_' int2str(number) '_psd' '\Follow\Centroparietal_left\delta']);
mkdir(['subject_' int2str(number) '_psd' '\Follow\Centroparietal_left\theta']);
mkdir(['subject_' int2str(number) '_psd' '\Follow\Centroparietal_left\alpha']);


mkdir(['subject_' int2str(number) '_psd' '\Follow\Centroparietal_right\delta']);
mkdir(['subject_' int2str(number) '_psd' '\Follow\Centroparietal_right\theta']);
mkdir(['subject_' int2str(number) '_psd' '\Follow\Centroparietal_right\alpha']);
end


if exist('break_times','var')
    
mkdir(['subject_' int2str(number) '_psd' '\Break\Parietal\delta']);
mkdir(['subject_' int2str(number) '_psd' '\Break\Parietal\theta']);
mkdir(['subject_' int2str(number) '_psd' '\Break\Parietal\alpha']);


mkdir(['subject_' int2str(number) '_psd' '\Break\Temporoparietal\delta']);
mkdir(['subject_' int2str(number) '_psd' '\Break\Temporoparietal\theta']);
mkdir(['subject_' int2str(number) '_psd' '\Break\Temporoparietal\alpha']);    
    
    
    
mkdir(['subject_' int2str(number) '_psd' '\Break\Frontocentral_1\delta']);
mkdir(['subject_' int2str(number) '_psd' '\Break\Frontocentral_1\theta']);
mkdir(['subject_' int2str(number) '_psd' '\Break\Frontocentral_1\alpha']);


mkdir(['subject_' int2str(number) '_psd' '\Break\Frontal_1\delta']);
mkdir(['subject_' int2str(number) '_psd' '\Break\Frontal_1\theta']);
mkdir(['subject_' int2str(number) '_psd' '\Break\Frontal_1\alpha']);


mkdir(['subject_' int2str(number) '_psd' '\Break\Frontal_2\delta']);
mkdir(['subject_' int2str(number) '_psd' '\Break\Frontal_2\theta']);
mkdir(['subject_' int2str(number) '_psd' '\Break\Frontal_2\alpha']);


mkdir(['subject_' int2str(number) '_psd' '\Break\Frontal_right\delta']);
mkdir(['subject_' int2str(number) '_psd' '\Break\Frontal_right\theta']);
mkdir(['subject_' int2str(number) '_psd' '\Break\Frontal_right\alpha']);


mkdir(['subject_' int2str(number) '_psd' '\Break\Frontal_left\delta']);
mkdir(['subject_' int2str(number) '_psd' '\Break\Frontal_left\theta']);
mkdir(['subject_' int2str(number) '_psd' '\Break\Frontal_left\alpha']);


mkdir(['subject_' int2str(number) '_psd' '\Break\Frontocentral_2\delta']);
mkdir(['subject_' int2str(number) '_psd' '\Break\Frontocentral_2\theta']);
mkdir(['subject_' int2str(number) '_psd' '\Break\Frontocentral_2\alpha']);


mkdir(['subject_' int2str(number) '_psd' '\Break\Frontocentral_right\delta']);
mkdir(['subject_' int2str(number) '_psd' '\Break\Frontocentral_right\theta']);
mkdir(['subject_' int2str(number) '_psd' '\Break\Frontocentral_right\alpha']);



mkdir(['subject_' int2str(number) '_psd' '\Break\Frontocentral_left\delta']);
mkdir(['subject_' int2str(number) '_psd' '\Break\Frontocentral_left\theta']);
mkdir(['subject_' int2str(number) '_psd' '\Break\Frontocentral_left\alpha']);


mkdir(['subject_' int2str(number) '_psd' '\Break\Central\delta']);
mkdir(['subject_' int2str(number) '_psd' '\Break\Central\theta']);
mkdir(['subject_' int2str(number) '_psd' '\Break\Central\alpha']);



mkdir(['subject_' int2str(number) '_psd' '\Break\Temporal\delta']);
mkdir(['subject_' int2str(number) '_psd' '\Break\Temporal\theta']);
mkdir(['subject_' int2str(number) '_psd' '\Break\Temporal\alpha']);


mkdir(['subject_' int2str(number) '_psd' '\Break\Centroparietal\delta']);
mkdir(['subject_' int2str(number) '_psd' '\Break\Centroparietal\theta']);
mkdir(['subject_' int2str(number) '_psd' '\Break\Centroparietal\alpha']);


mkdir(['subject_' int2str(number) '_psd' '\Break\Centroparietal_left\delta']);
mkdir(['subject_' int2str(number) '_psd' '\Break\Centroparietal_left\theta']);
mkdir(['subject_' int2str(number) '_psd' '\Break\Centroparietal_left\alpha']);


mkdir(['subject_' int2str(number) '_psd' '\Break\Centroparietal_right\delta']);
mkdir(['subject_' int2str(number) '_psd' '\Break\Centroparietal_right\theta']);
mkdir(['subject_' int2str(number) '_psd' '\Break\Centroparietal_right\alpha']);
end

%%


if exist('follow_times','var')
    
    
    
 if size(follow_psd_delta,1)>0
path_1=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Parietal\delta']); 
for i=1:size(follow_psd_delta,3)
Parietal_delta(:,1)=follow_psd_delta(:,14,i);
Parietal_delta(:,2)=follow_psd_delta(:,19,i);
Parietal_delta(:,3)=follow_psd_delta(:,13,i);

filename = sprintf('trial_%d.xlsx',i); 
writematrix(Parietal_delta,fullfile(path_1,filename));

end
end

if size(follow_psd_theta,1)>0
path_2=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Parietal\theta']);

for i=1:size(follow_psd_theta,3)
Parietal_theta(:,1)=follow_psd_theta(:,14,i);
Parietal_theta(:,2)=follow_psd_theta(:,19,i);
Parietal_theta(:,3)=follow_psd_theta(:,13,i);

filename = sprintf('trial_%d.xlsx',i); 
writematrix(Parietal_theta,fullfile(path_2,filename));
end
end


if size(follow_psd_alpha,1)>0
path_3=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Parietal\alpha']);

for i=1:size(follow_psd_alpha,3)
Parietal_alpha(:,1)=follow_psd_alpha(:,14,i);
Parietal_alpha(:,2)=follow_psd_alpha(:,19,i);
Parietal_alpha(:,3)=follow_psd_alpha(:,13,i);

filename = sprintf('trial_%d.xlsx',i); 
writematrix(Parietal_alpha,fullfile(path_3,filename));
end
end   
    
 




    
 if size(follow_psd_delta,1)>0
path_1=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Temporoparietal\delta']); 
for i=1:size(follow_psd_delta,3)
Temporoparietal_delta(:,1)=follow_psd_delta(:,10,i);
Temporoparietal_delta(:,2)=follow_psd_delta(:,21,i);


filename = sprintf('trial_%d.xlsx',i); 
writematrix(Temporoparietal_delta,fullfile(path_1,filename));

end
end

if size(follow_psd_theta,1)>0
path_2=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Temporoparietal\theta']);

for i=1:size(follow_psd_theta,3)
Temporoparietal_theta(:,1)=follow_psd_theta(:,10,i);
Temporoparietal_theta(:,2)=follow_psd_theta(:,21,i);


filename = sprintf('trial_%d.xlsx',i); 
writematrix(Temporoparietal_theta,fullfile(path_2,filename));
end
end


if size(follow_psd_alpha,1)>0
path_3=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Temporoparietal\alpha']);

for i=1:size(follow_psd_alpha,3)
Temporoparietal_alpha(:,1)=follow_psd_alpha(:,10,i);
Temporoparietal_alpha(:,2)=follow_psd_alpha(:,21,i);


filename = sprintf('trial_%d.xlsx',i); 
writematrix(Temporoparietal_alpha,fullfile(path_3,filename));
end
end      
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

if size(follow_psd_delta,1)>0
path_1=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Frontocentral_1\delta']); 
for i=1:size(follow_psd_delta,3)
Frontocentral_1_delta(:,1)=follow_psd_delta(:,2,i);
Frontocentral_1_delta(:,2)=follow_psd_delta(:,24,i);
Frontocentral_1_delta(:,3)=follow_psd_delta(:,7,i);
Frontocentral_1_delta(:,4)=follow_psd_delta(:,29,i);


filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontocentral_1_delta,fullfile(path_1,filename));

end
end

if size(follow_psd_theta,1)>0
path_2=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Frontocentral_1\theta']);

for i=1:size(follow_psd_theta,3)
Frontocentral_1_theta(:,1)=follow_psd_theta(:,2,i);
Frontocentral_1_theta(:,2)=follow_psd_theta(:,24,i);
Frontocentral_1_theta(:,3)=follow_psd_theta(:,7,i);
Frontocentral_1_theta(:,4)=follow_psd_theta(:,29,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontocentral_1_theta,fullfile(path_2,filename));
end
end


if size(follow_psd_alpha,1)>0
path_3=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Frontocentral_1\alpha']);

for i=1:size(follow_psd_alpha,3)
Frontocentral_1_alpha(:,1)=follow_psd_alpha(:,2,i);
Frontocentral_1_alpha(:,2)=follow_psd_alpha(:,24,i);
Frontocentral_1_alpha(:,3)=follow_psd_alpha(:,7,i);
Frontocentral_1_alpha(:,4)=follow_psd_alpha(:,29,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontocentral_1_alpha,fullfile(path_3,filename));
end
end






if size(follow_psd_delta,1)>0
path_1=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Frontal_1\delta']); 
for i=1:size(follow_psd_delta,3)
Frontal_1_delta(:,1)=follow_psd_delta(:,1,i);
Frontal_1_delta(:,2)=follow_psd_delta(:,32,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontal_1_delta,fullfile(path_1,filename));

end
end

if size(follow_psd_theta,1)>0
path_2=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Frontal_1\theta']);

for i=1:size(follow_psd_theta,3)
Frontal_1_theta(:,1)=follow_psd_theta(:,1,i);
Frontal_1_theta(:,2)=follow_psd_theta(:,32,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontal_1_theta,fullfile(path_2,filename));
end
end


if size(follow_psd_alpha,1)>0
path_3=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Frontal_1\alpha']);

for i=1:size(follow_psd_alpha,3)
Frontal_1_alpha(:,1)=follow_psd_alpha(:,1,i);
Frontal_1_alpha(:,2)=follow_psd_alpha(:,32,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontal_1_alpha,fullfile(path_3,filename));
end
end






if size(follow_psd_delta,1)>0
path_1=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Frontal_2\delta']); 
for i=1:size(follow_psd_delta,3)
Frontal_2_delta(:,1)=follow_psd_delta(:,4,i);
Frontal_2_delta(:,2)=follow_psd_delta(:,3,i);
Frontal_2_delta(:,3)=follow_psd_delta(:,2,i);
Frontal_2_delta(:,4)=follow_psd_delta(:,30,i);
Frontal_2_delta(:,5)=follow_psd_delta(:,31,i);

filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontal_2_delta,fullfile(path_1,filename));

end
end

if size(follow_psd_theta,1)>0
path_2=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Frontal_2\theta']);

for i=1:size(follow_psd_theta,3)
Frontal_2_theta(:,1)=follow_psd_theta(:,4,i);
Frontal_2_theta(:,2)=follow_psd_theta(:,3,i);
Frontal_2_theta(:,3)=follow_psd_theta(:,2,i);
Frontal_2_theta(:,4)=follow_psd_theta(:,30,i);
Frontal_2_theta(:,5)=follow_psd_theta(:,31,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontal_2_theta,fullfile(path_2,filename));
end
end


if size(follow_psd_alpha,1)>0
path_3=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Frontal_2\alpha']);

for i=1:size(follow_psd_alpha,3)
Frontal_2_alpha(:,1)=follow_psd_alpha(:,4,i);
Frontal_2_alpha(:,2)=follow_psd_alpha(:,3,i);
Frontal_2_alpha(:,3)=follow_psd_alpha(:,2,i);
Frontal_2_alpha(:,4)=follow_psd_alpha(:,30,i);
Frontal_2_alpha(:,5)=follow_psd_alpha(:,31,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontal_2_alpha,fullfile(path_3,filename));
end
end







if size(follow_psd_delta,1)>0
path_1=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Frontal_right\delta']); 
for i=1:size(follow_psd_delta,3)
Frontal_right_delta(:,1)=follow_psd_delta(:,30,i);
Frontal_right_delta(:,2)=follow_psd_delta(:,31,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontal_right_delta,fullfile(path_1,filename));

end
end

if size(follow_psd_theta,1)>0
path_2=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Frontal_right\theta']);

for i=1:size(follow_psd_theta,3)
Frontal_right_theta(:,1)=follow_psd_theta(:,30,i);
Frontal_right_theta(:,2)=follow_psd_theta(:,31,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontal_right_theta,fullfile(path_2,filename));
end
end


if size(follow_psd_alpha,1)>0
path_3=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Frontal_right\alpha']);

for i=1:size(follow_psd_alpha,3)
Frontal_right_alpha(:,1)=follow_psd_alpha(:,30,i);
Frontal_right_alpha(:,2)=follow_psd_alpha(:,31,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontal_right_alpha,fullfile(path_3,filename));
end
end






if size(follow_psd_delta,1)>0
path_1=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Frontal_left\delta']); 
for i=1:size(follow_psd_delta,3)
Frontal_left_delta(:,1)=follow_psd_delta(:,3,i);
Frontal_left_delta(:,2)=follow_psd_delta(:,4,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontal_left_delta,fullfile(path_1,filename));

end
end

if size(follow_psd_theta,1)>0
path_2=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Frontal_left\theta']);

for i=1:size(follow_psd_theta,3)
Frontal_left_theta(:,1)=follow_psd_theta(:,3,i);
Frontal_left_theta(:,2)=follow_psd_theta(:,4,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontal_left_theta,fullfile(path_2,filename));
end
end


if size(follow_psd_alpha,1)>0
path_3=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Frontal_left\alpha']);

for i=1:size(follow_psd_alpha,3)
Frontal_left_alpha(:,1)=follow_psd_alpha(:,3,i);
Frontal_left_alpha(:,2)=follow_psd_alpha(:,4,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontal_left_alpha,fullfile(path_3,filename));
end
end




if size(follow_psd_delta,1)>0
path_1=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Frontocentral_2\delta']); 
for i=1:size(follow_psd_delta,3)
Frontocentral_2_delta(:,1)=follow_psd_delta(:,6,i);
Frontocentral_2_delta(:,2)=follow_psd_delta(:,7,i);
Frontocentral_2_delta(:,3)=follow_psd_delta(:,29,i);
Frontocentral_2_delta(:,4)=follow_psd_delta(:,28,i);

filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontocentral_2_delta,fullfile(path_1,filename));

end
end

if size(follow_psd_theta,1)>0
path_2=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Frontocentral_2\theta']);

for i=1:size(follow_psd_theta,3)
Frontocentral_2_theta(:,1)=follow_psd_theta(:,6,i);
Frontocentral_2_theta(:,2)=follow_psd_theta(:,7,i);
Frontocentral_2_theta(:,3)=follow_psd_theta(:,29,i);
Frontocentral_2_theta(:,4)=follow_psd_theta(:,28,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontocentral_2_theta,fullfile(path_2,filename));
end
end


if size(follow_psd_alpha,1)>0
path_3=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Frontocentral_2\alpha']);

for i=1:size(follow_psd_alpha,3)
Frontocentral_2_alpha(:,1)=follow_psd_alpha(:,6,i);
Frontocentral_2_alpha(:,2)=follow_psd_alpha(:,7,i);
Frontocentral_2_alpha(:,3)=follow_psd_alpha(:,29,i);
Frontocentral_2_alpha(:,4)=follow_psd_alpha(:,28,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontocentral_2_alpha,fullfile(path_3,filename));
end
end





if size(follow_psd_delta,1)>0
path_1=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Frontocentral_right\delta']); 
for i=1:size(follow_psd_delta,3)
Frontocentral_right_delta(:,1)=follow_psd_delta(:,29,i);
Frontocentral_right_delta(:,2)=follow_psd_delta(:,28,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontocentral_right_delta,fullfile(path_1,filename));

end
end

if size(follow_psd_theta,1)>0
path_2=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Frontocentral_right\theta']);

for i=1:size(follow_psd_theta,3)
Frontocentral_right_theta(:,1)=follow_psd_theta(:,29,i);
Frontocentral_right_theta(:,2)=follow_psd_theta(:,28,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontocentral_right_theta,fullfile(path_2,filename));
end
end


if size(follow_psd_alpha,1)>0
path_3=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Frontocentral_right\alpha']);

for i=1:size(follow_psd_alpha,3)
Frontocentral_right_alpha(:,1)=follow_psd_alpha(:,29,i);
Frontocentral_right_alpha(:,2)=follow_psd_alpha(:,28,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontocentral_right_alpha,fullfile(path_3,filename));
end
end





if size(follow_psd_delta,1)>0
path_1=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Frontocentral_left\delta']); 
for i=1:size(follow_psd_delta,3)
Frontocentral_left_delta(:,1)=follow_psd_delta(:,7,i);
Frontocentral_left_delta(:,2)=follow_psd_delta(:,6,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontocentral_left_delta,fullfile(path_1,filename));

end
end

if size(follow_psd_theta,1)>0
path_2=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Frontocentral_left\theta']);

for i=1:size(follow_psd_theta,3)
Frontocentral_left_theta(:,1)=follow_psd_theta(:,7,i);
Frontocentral_left_theta(:,2)=follow_psd_theta(:,6,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontocentral_left_theta,fullfile(path_2,filename));
end
end


if size(follow_psd_alpha,1)>0
path_3=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Frontocentral_left\alpha']);

for i=1:size(follow_psd_alpha,3)
Frontocentral_left_alpha(:,1)=follow_psd_alpha(:,7,i);
Frontocentral_left_alpha(:,2)=follow_psd_alpha(:,6,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontocentral_left_alpha,fullfile(path_3,filename));
end
end






if size(follow_psd_delta,1)>0
path_1=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Central\delta']); 
for i=1:size(follow_psd_delta,3)
Central_delta(:,1)=follow_psd_delta(:,24,i);
Central_delta(:,2)=follow_psd_delta(:,25,i);
Central_delta(:,3)=follow_psd_delta(:,8,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Central_delta,fullfile(path_1,filename));

end
end

if size(follow_psd_theta,1)>0
path_2=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Central\theta']);

for i=1:size(follow_psd_theta,3)
Central_theta(:,1)=follow_psd_theta(:,24,i);
Central_theta(:,2)=follow_psd_theta(:,25,i);
Central_theta(:,3)=follow_psd_theta(:,8,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Central_theta,fullfile(path_2,filename));
end
end


if size(follow_psd_alpha,1)>0
path_3=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Central\alpha']);

for i=1:size(follow_psd_alpha,3)
Central_alpha(:,1)=follow_psd_alpha(:,24,i);
Central_alpha(:,2)=follow_psd_alpha(:,25,i);
Central_alpha(:,3)=follow_psd_alpha(:,8,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Central_alpha,fullfile(path_3,filename));
end
end







if size(follow_psd_delta,1)>0
path_1=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Temporal\delta']); 
for i=1:size(follow_psd_delta,3)
Temporal_delta(:,1)=follow_psd_delta(:,9,i);
Temporal_delta(:,2)=follow_psd_delta(:,26,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Temporal_delta,fullfile(path_1,filename));

end
end

if size(follow_psd_theta,1)>0
path_2=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Temporal\theta']);

for i=1:size(follow_psd_theta,3)
Temporal_theta(:,1)=follow_psd_theta(:,9,i);
Temporal_theta(:,2)=follow_psd_theta(:,26,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Temporal_theta,fullfile(path_2,filename));
end
end


if size(follow_psd_alpha,1)>0
path_3=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Temporal\alpha']);

for i=1:size(follow_psd_alpha,3)
Temporal_alpha(:,1)=follow_psd_alpha(:,9,i);
Temporal_alpha(:,2)=follow_psd_alpha(:,26,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Temporal_alpha,fullfile(path_3,filename));
end
end






if size(follow_psd_delta,1)>0
path_1=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Centroparietal\delta']); 
for i=1:size(follow_psd_delta,3)
Centroparietal_delta(:,1)=follow_psd_delta(:,11,i);
Centroparietal_delta(:,2)=follow_psd_delta(:,12,i);
Centroparietal_delta(:,3)=follow_psd_delta(:,23,i);
Centroparietal_delta(:,4)=follow_psd_delta(:,22,i);

filename = sprintf('trial_%d.xlsx',i); 
writematrix(Centroparietal_delta,fullfile(path_1,filename));

end
end

if size(follow_psd_theta,1)>0
path_2=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Centroparietal\theta']);

for i=1:size(follow_psd_theta,3)
Centroparietal_theta(:,1)=follow_psd_theta(:,11,i);
Centroparietal_theta(:,2)=follow_psd_theta(:,12,i);
Centroparietal_theta(:,3)=follow_psd_theta(:,23,i);
Centroparietal_theta(:,4)=follow_psd_theta(:,22,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Centroparietal_theta,fullfile(path_2,filename));
end
end


if size(follow_psd_alpha,1)>0
path_3=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Centroparietal\alpha']);

for i=1:size(follow_psd_alpha,3)
Centroparietal_alpha(:,1)=follow_psd_alpha(:,11,i);
Centroparietal_alpha(:,2)=follow_psd_alpha(:,12,i);
Centroparietal_alpha(:,3)=follow_psd_alpha(:,23,i);
Centroparietal_alpha(:,4)=follow_psd_alpha(:,22,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Centroparietal_alpha,fullfile(path_3,filename));
end
end







if size(follow_psd_delta,1)>0
path_1=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Centroparietal_left\delta']); 
for i=1:size(follow_psd_delta,3)
Centroparietal_left_delta(:,1)=follow_psd_delta(:,11,i);
Centroparietal_left_delta(:,2)=follow_psd_delta(:,12,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Centroparietal_left_delta,fullfile(path_1,filename));

end
end

if size(follow_psd_theta,1)>0
path_2=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Centroparietal_left\theta']);

for i=1:size(follow_psd_theta,3)
Centroparietal_left_theta(:,1)=follow_psd_theta(:,11,i);
Centroparietal_left_theta(:,2)=follow_psd_theta(:,12,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Centroparietal_left_theta,fullfile(path_2,filename));
end
end


if size(follow_psd_alpha,1)>0
path_3=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Centroparietal_left\alpha']);

for i=1:size(follow_psd_alpha,3)
Centroparietal_left_alpha(:,1)=follow_psd_alpha(:,11,i);
Centroparietal_left_alpha(:,2)=follow_psd_alpha(:,12,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Centroparietal_left_alpha,fullfile(path_3,filename));
end
end





if size(follow_psd_delta,1)>0
path_1=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Centroparietal_right\delta']); 
for i=1:size(follow_psd_delta,3)
Centroparietal_right_delta(:,1)=follow_psd_delta(:,23,i);
Centroparietal_right_delta(:,2)=follow_psd_delta(:,22,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Centroparietal_right_delta,fullfile(path_1,filename));

end
end

if size(follow_psd_theta,1)>0
path_2=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Centroparietal_right\theta']);

for i=1:size(follow_psd_theta,3)
Centroparietal_right_theta(:,1)=follow_psd_theta(:,23,i);
Centroparietal_right_theta(:,2)=follow_psd_theta(:,22,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Centroparietal_right_theta,fullfile(path_2,filename));
end
end


if size(follow_psd_alpha,1)>0
path_3=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Follow\Centroparietal_right\alpha']);

for i=1:size(follow_psd_alpha,3)
Centroparietal_right_alpha(:,1)=follow_psd_alpha(:,23,i);
Centroparietal_right_alpha(:,2)=follow_psd_alpha(:,22,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Centroparietal_right_alpha,fullfile(path_3,filename));
end
end

end
%%

if exist('break_times','var')
    
    
    
    
 if size(break_psd_delta,1)>0
path_1=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Parietal\delta']); 
for i=1:size(break_psd_delta,3)
Parietal_delta(:,1)=break_psd_delta(:,14,i);
Parietal_delta(:,2)=break_psd_delta(:,19,i);
Parietal_delta(:,3)=break_psd_delta(:,13,i);

filename = sprintf('trial_%d.xlsx',i); 
writematrix(Parietal_delta,fullfile(path_1,filename));

end
end

if size(break_psd_theta,1)>0
path_2=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Parietal\theta']);

for i=1:size(break_psd_theta,3)
Parietal_theta(:,1)=break_psd_theta(:,14,i);
Parietal_theta(:,2)=break_psd_theta(:,19,i);
Parietal_theta(:,3)=break_psd_theta(:,13,i);

filename = sprintf('trial_%d.xlsx',i); 
writematrix(Parietal_theta,fullfile(path_2,filename));
end
end


if size(break_psd_alpha,1)>0
path_3=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Parietal\alpha']);

for i=1:size(break_psd_alpha,3)
Parietal_alpha(:,1)=break_psd_alpha(:,14,i);
Parietal_alpha(:,2)=break_psd_alpha(:,19,i);
Parietal_alpha(:,3)=break_psd_alpha(:,13,i);

filename = sprintf('trial_%d.xlsx',i); 
writematrix(Parietal_alpha,fullfile(path_3,filename));
end
end   
    
 




    
 if size(break_psd_delta,1)>0
path_1=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Temporoparietal\delta']); 
for i=1:size(break_psd_delta,3)
Temporoparietal_delta(:,1)=break_psd_delta(:,10,i);
Temporoparietal_delta(:,2)=break_psd_delta(:,21,i);


filename = sprintf('trial_%d.xlsx',i); 
writematrix(Temporoparietal_delta,fullfile(path_1,filename));

end
end

if size(break_psd_theta,1)>0
path_2=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Temporoparietal\theta']);

for i=1:size(break_psd_theta,3)
Temporoparietal_theta(:,1)=break_psd_theta(:,10,i);
Temporoparietal_theta(:,2)=break_psd_theta(:,21,i);


filename = sprintf('trial_%d.xlsx',i); 
writematrix(Temporoparietal_theta,fullfile(path_2,filename));
end
end


if size(break_psd_alpha,1)>0
path_3=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Temporoparietal\alpha']);

for i=1:size(follow_psd_alpha,3)
Temporoparietal_alpha(:,1)=break_psd_alpha(:,10,i);
Temporoparietal_alpha(:,2)=break_psd_alpha(:,21,i);


filename = sprintf('trial_%d.xlsx',i); 
writematrix(Temporoparietal_alpha,fullfile(path_3,filename));
end
end      
    
    

if size(break_psd_delta,1)>0
path_1=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Frontocentral_1\delta']); 
for i=1:size(break_psd_delta,3)
Frontocentral_1_delta(:,1)=break_psd_delta(:,2,i);
Frontocentral_1_delta(:,2)=break_psd_delta(:,24,i);
Frontocentral_1_delta(:,3)=break_psd_delta(:,7,i);
Frontocentral_1_delta(:,4)=break_psd_delta(:,29,i);


filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontocentral_1_delta,fullfile(path_1,filename));

end
end

if size(break_psd_theta,1)>0
path_2=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Frontocentral_1\theta']);

for i=1:size(break_psd_theta,3)
Frontocentral_1_theta(:,1)=break_psd_theta(:,2,i);
Frontocentral_1_theta(:,2)=break_psd_theta(:,24,i);
Frontocentral_1_theta(:,3)=break_psd_theta(:,7,i);
Frontocentral_1_theta(:,4)=break_psd_theta(:,29,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontocentral_1_theta,fullfile(path_2,filename));
end
end


if size(break_psd_alpha,1)>0
path_3=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Frontocentral_1\alpha']);

for i=1:size(break_psd_alpha,3)
Frontocentral_1_alpha(:,1)=break_psd_alpha(:,2,i);
Frontocentral_1_alpha(:,2)=break_psd_alpha(:,24,i);
Frontocentral_1_alpha(:,3)=break_psd_alpha(:,7,i);
Frontocentral_1_alpha(:,4)=break_psd_alpha(:,29,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontocentral_1_alpha,fullfile(path_3,filename));
end
end






if size(break_psd_delta,1)>0
path_1=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Frontal_1\delta']); 
for i=1:size(break_psd_delta,3)
Frontal_1_delta(:,1)=break_psd_delta(:,1,i);
Frontal_1_delta(:,2)=break_psd_delta(:,32,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontal_1_delta,fullfile(path_1,filename));

end
end

if size(break_psd_theta,1)>0
path_2=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Frontal_1\theta']);

for i=1:size(break_psd_theta,3)
Frontal_1_theta(:,1)=break_psd_theta(:,1,i);
Frontal_1_theta(:,2)=break_psd_theta(:,32,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontal_1_theta,fullfile(path_2,filename));
end
end


if size(break_psd_alpha,1)>0
path_3=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Frontal_1\alpha']);

for i=1:size(break_psd_alpha,3)
Frontal_1_alpha(:,1)=break_psd_alpha(:,1,i);
Frontal_1_alpha(:,2)=break_psd_alpha(:,32,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontal_1_alpha,fullfile(path_3,filename));
end
end






if size(break_psd_delta,1)>0
path_1=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Frontal_2\delta']); 
for i=1:size(break_psd_delta,3)
Frontal_2_delta(:,1)=break_psd_delta(:,4,i);
Frontal_2_delta(:,2)=break_psd_delta(:,3,i);
Frontal_2_delta(:,3)=break_psd_delta(:,2,i);
Frontal_2_delta(:,4)=break_psd_delta(:,30,i);
Frontal_2_delta(:,5)=break_psd_delta(:,31,i);

filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontal_2_delta,fullfile(path_1,filename));

end
end

if size(break_psd_theta,1)>0
path_2=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Frontal_2\theta']);

for i=1:size(break_psd_theta,3)
Frontal_2_theta(:,1)=break_psd_theta(:,4,i);
Frontal_2_theta(:,2)=break_psd_theta(:,3,i);
Frontal_2_theta(:,3)=break_psd_theta(:,2,i);
Frontal_2_theta(:,4)=break_psd_theta(:,30,i);
Frontal_2_theta(:,5)=break_psd_theta(:,31,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontal_2_theta,fullfile(path_2,filename));
end
end


if size(break_psd_alpha,1)>0
path_3=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Frontal_2\alpha']);

for i=1:size(break_psd_alpha,3)
Frontal_2_alpha(:,1)=break_psd_alpha(:,4,i);
Frontal_2_alpha(:,2)=break_psd_alpha(:,3,i);
Frontal_2_alpha(:,3)=break_psd_alpha(:,2,i);
Frontal_2_alpha(:,4)=break_psd_alpha(:,30,i);
Frontal_2_alpha(:,5)=break_psd_alpha(:,31,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontal_2_alpha,fullfile(path_3,filename));
end
end







if size(break_psd_delta,1)>0
path_1=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Frontal_right\delta']); 
for i=1:size(break_psd_delta,3)
Frontal_right_delta(:,1)=break_psd_delta(:,30,i);
Frontal_right_delta(:,2)=break_psd_delta(:,31,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontal_right_delta,fullfile(path_1,filename));

end
end

if size(break_psd_theta,1)>0
path_2=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Frontal_right\theta']);

for i=1:size(break_psd_theta,3)
Frontal_right_theta(:,1)=break_psd_theta(:,30,i);
Frontal_right_theta(:,2)=break_psd_theta(:,31,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontal_right_theta,fullfile(path_2,filename));
end
end


if size(break_psd_alpha,1)>0
path_3=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Frontal_right\alpha']);

for i=1:size(break_psd_alpha,3)
Frontal_right_alpha(:,1)=break_psd_alpha(:,30,i);
Frontal_right_alpha(:,2)=break_psd_alpha(:,31,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontal_right_alpha,fullfile(path_3,filename));
end
end






if size(break_psd_delta,1)>0
path_1=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Frontal_left\delta']); 
for i=1:size(break_psd_delta,3)
Frontal_left_delta(:,1)=break_psd_delta(:,3,i);
Frontal_left_delta(:,2)=break_psd_delta(:,4,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontal_left_delta,fullfile(path_1,filename));

end
end

if size(break_psd_theta,1)>0
path_2=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Frontal_left\theta']);

for i=1:size(break_psd_theta,3)
Frontal_left_theta(:,1)=break_psd_theta(:,3,i);
Frontal_left_theta(:,2)=break_psd_theta(:,4,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontal_left_theta,fullfile(path_2,filename));
end
end


if size(break_psd_alpha,1)>0
path_3=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Frontal_left\alpha']);

for i=1:size(break_psd_alpha,3)
Frontal_left_alpha(:,1)=break_psd_alpha(:,3,i);
Frontal_left_alpha(:,2)=break_psd_alpha(:,4,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontal_left_alpha,fullfile(path_3,filename));
end
end




if size(break_psd_delta,1)>0
path_1=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Frontocentral_2\delta']); 
for i=1:size(break_psd_delta,3)
Frontocentral_2_delta(:,1)=break_psd_delta(:,6,i);
Frontocentral_2_delta(:,2)=break_psd_delta(:,7,i);
Frontocentral_2_delta(:,3)=break_psd_delta(:,29,i);
Frontocentral_2_delta(:,4)=break_psd_delta(:,28,i);

filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontocentral_2_delta,fullfile(path_1,filename));

end
end

if size(break_psd_theta,1)>0
path_2=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Frontocentral_2\theta']);

for i=1:size(break_psd_theta,3)
Frontocentral_2_theta(:,1)=break_psd_theta(:,6,i);
Frontocentral_2_theta(:,2)=break_psd_theta(:,7,i);
Frontocentral_2_theta(:,3)=break_psd_theta(:,29,i);
Frontocentral_2_theta(:,4)=break_psd_theta(:,28,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontocentral_2_theta,fullfile(path_2,filename));
end
end


if size(break_psd_alpha,1)>0
path_3=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Frontocentral_2\alpha']);

for i=1:size(break_psd_alpha,3)
Frontocentral_2_alpha(:,1)=break_psd_alpha(:,6,i);
Frontocentral_2_alpha(:,2)=break_psd_alpha(:,7,i);
Frontocentral_2_alpha(:,3)=break_psd_alpha(:,29,i);
Frontocentral_2_alpha(:,4)=break_psd_alpha(:,28,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontocentral_2_alpha,fullfile(path_3,filename));
end
end





if size(break_psd_delta,1)>0
path_1=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Frontocentral_right\delta']); 
for i=1:size(break_psd_delta,3)
Frontocentral_right_delta(:,1)=break_psd_delta(:,29,i);
Frontocentral_right_delta(:,2)=break_psd_delta(:,28,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontocentral_right_delta,fullfile(path_1,filename));

end
end

if size(break_psd_theta,1)>0
path_2=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Frontocentral_right\theta']);

for i=1:size(break_psd_theta,3)
Frontocentral_right_theta(:,1)=break_psd_theta(:,29,i);
Frontocentral_right_theta(:,2)=break_psd_theta(:,28,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontocentral_right_theta,fullfile(path_2,filename));
end
end


if size(break_psd_alpha,1)>0
path_3=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Frontocentral_right\alpha']);

for i=1:size(break_psd_alpha,3)
Frontocentral_right_alpha(:,1)=break_psd_alpha(:,29,i);
Frontocentral_right_alpha(:,2)=break_psd_alpha(:,28,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontocentral_right_alpha,fullfile(path_3,filename));
end
end





if size(break_psd_delta,1)>0
path_1=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Frontocentral_left\delta']); 
for i=1:size(break_psd_delta,3)
Frontocentral_left_delta(:,1)=break_psd_delta(:,7,i);
Frontocentral_left_delta(:,2)=break_psd_delta(:,6,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontocentral_left_delta,fullfile(path_1,filename));

end
end

if size(break_psd_theta,1)>0
path_2=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Frontocentral_left\theta']);

for i=1:size(break_psd_theta,3)
Frontocentral_left_theta(:,1)=break_psd_theta(:,7,i);
Frontocentral_left_theta(:,2)=break_psd_theta(:,6,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontocentral_left_theta,fullfile(path_2,filename));
end
end


if size(break_psd_alpha,1)>0
path_3=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Frontocentral_left\alpha']);

for i=1:size(break_psd_alpha,3)
Frontocentral_left_alpha(:,1)=break_psd_alpha(:,7,i);
Frontocentral_left_alpha(:,2)=break_psd_alpha(:,6,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Frontocentral_left_alpha,fullfile(path_3,filename));
end
end






if size(break_psd_delta,1)>0
path_1=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Central\delta']); 
for i=1:size(break_psd_delta,3)
Central_delta(:,1)=break_psd_delta(:,24,i);
Central_delta(:,2)=break_psd_delta(:,25,i);
Central_delta(:,3)=break_psd_delta(:,8,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Central_delta,fullfile(path_1,filename));

end
end

if size(break_psd_theta,1)>0
path_2=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Central\theta']);

for i=1:size(break_psd_theta,3)
Central_theta(:,1)=break_psd_theta(:,24,i);
Central_theta(:,2)=break_psd_theta(:,25,i);
Central_theta(:,3)=break_psd_theta(:,8,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Central_theta,fullfile(path_2,filename));
end
end


if size(break_psd_alpha,1)>0
path_3=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Central\alpha']);

for i=1:size(break_psd_alpha,3)
Central_alpha(:,1)=break_psd_alpha(:,24,i);
Central_alpha(:,2)=break_psd_alpha(:,25,i);
Central_alpha(:,3)=break_psd_alpha(:,8,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Central_alpha,fullfile(path_3,filename));
end
end







if size(break_psd_delta,1)>0
path_1=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Temporal\delta']); 
for i=1:size(break_psd_delta,3)
Temporal_delta(:,1)=break_psd_delta(:,9,i);
Temporal_delta(:,2)=break_psd_delta(:,26,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Temporal_delta,fullfile(path_1,filename));

end
end

if size(break_psd_theta,1)>0
path_2=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Temporal\theta']);

for i=1:size(break_psd_theta,3)
Temporal_theta(:,1)=break_psd_theta(:,9,i);
Temporal_theta(:,2)=break_psd_theta(:,26,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Temporal_theta,fullfile(path_2,filename));
end
end


if size(break_psd_alpha,1)>0
path_3=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Temporal\alpha']);

for i=1:size(break_psd_alpha,3)
Temporal_alpha(:,1)=break_psd_alpha(:,9,i);
Temporal_alpha(:,2)=break_psd_alpha(:,26,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Temporal_alpha,fullfile(path_3,filename));
end
end






if size(break_psd_delta,1)>0
path_1=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Centroparietal\delta']); 
for i=1:size(break_psd_delta,3)
Centroparietal_delta(:,1)=break_psd_delta(:,11,i);
Centroparietal_delta(:,2)=break_psd_delta(:,12,i);
Centroparietal_delta(:,3)=break_psd_delta(:,23,i);
Centroparietal_delta(:,4)=break_psd_delta(:,22,i);

filename = sprintf('trial_%d.xlsx',i); 
writematrix(Centroparietal_delta,fullfile(path_1,filename));

end
end

if size(break_psd_theta,1)>0
path_2=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Centroparietal\theta']);

for i=1:size(break_psd_theta,3)
Centroparietal_theta(:,1)=break_psd_theta(:,11,i);
Centroparietal_theta(:,2)=break_psd_theta(:,12,i);
Centroparietal_theta(:,3)=break_psd_theta(:,23,i);
Centroparietal_theta(:,4)=break_psd_theta(:,22,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Centroparietal_theta,fullfile(path_2,filename));
end
end


if size(break_psd_alpha,1)>0
path_3=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Centroparietal\alpha']);

for i=1:size(break_psd_alpha,3)
Centroparietal_alpha(:,1)=break_psd_alpha(:,11,i);
Centroparietal_alpha(:,2)=break_psd_alpha(:,12,i);
Centroparietal_alpha(:,3)=break_psd_alpha(:,23,i);
Centroparietal_alpha(:,4)=break_psd_alpha(:,22,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Centroparietal_alpha,fullfile(path_3,filename));
end
end







if size(break_psd_delta,1)>0
path_1=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Centroparietal_left\delta']); 
for i=1:size(break_psd_delta,3)
Centroparietal_left_delta(:,1)=break_psd_delta(:,11,i);
Centroparietal_left_delta(:,2)=break_psd_delta(:,12,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Centroparietal_left_delta,fullfile(path_1,filename));

end
end

if size(break_psd_theta,1)>0
path_2=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Centroparietal_left\theta']);

for i=1:size(break_psd_theta,3)
Centroparietal_left_theta(:,1)=break_psd_theta(:,11,i);
Centroparietal_left_theta(:,2)=break_psd_theta(:,12,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Centroparietal_left_theta,fullfile(path_2,filename));
end
end


if size(break_psd_alpha,1)>0
path_3=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Centroparietal_left\alpha']);

for i=1:size(break_psd_alpha,3)
Centroparietal_left_alpha(:,1)=break_psd_alpha(:,11,i);
Centroparietal_left_alpha(:,2)=break_psd_alpha(:,12,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Centroparietal_left_alpha,fullfile(path_3,filename));
end
end





if size(break_psd_delta,1)>0
path_1=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Centroparietal_right\delta']); 
for i=1:size(break_psd_delta,3)
Centroparietal_right_delta(:,1)=break_psd_delta(:,23,i);
Centroparietal_right_delta(:,2)=break_psd_delta(:,22,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Centroparietal_right_delta,fullfile(path_1,filename));

end
end

if size(break_psd_theta,1)>0
path_2=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Centroparietal_right\theta']);

for i=1:size(break_psd_theta,3)
Centroparietal_right_theta(:,1)=break_psd_theta(:,23,i);
Centroparietal_right_theta(:,2)=break_psd_theta(:,22,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Centroparietal_right_theta,fullfile(path_2,filename));
end
end


if size(break_psd_alpha,1)>0
path_3=(['C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_' int2str(number) '_psd\Break\Centroparietal_right\alpha']);

for i=1:size(break_psd_alpha,3)
Centroparietal_right_alpha(:,1)=break_psd_alpha(:,23,i);
Centroparietal_right_alpha(:,2)=break_psd_alpha(:,22,i);
filename = sprintf('trial_%d.xlsx',i); 
writematrix(Centroparietal_right_alpha,fullfile(path_3,filename));
end
end

end