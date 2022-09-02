eeglab;
[S, H] = pop_loadbv('C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data','001_BVA.vhdr',[],[]);
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
time_table = readtable( 'rejected_trials_subject_1.xlsx' );
follow_rt_indexes= find(time_table.Var5=="follow");
break_rt_indexes= find(time_table.Var5=="break");
for i=1:length(follow_rt_indexes)
    follow_times(i)=time_table.Var3(follow_rt_indexes(i));
    if time_table.Var3(follow_rt_indexes(i))>1200
        follow_times(i)=1200;
    end
    follow_times(i)=((follow_times(i))*300)/1200;
    follow_times(i)=round(follow_times(i));
end
    
for i=1:length(break_rt_indexes)
    break_times(i)=time_table.Var3(break_rt_indexes(i));
    if time_table.Var3(break_rt_indexes(i))>1200
        break_times(i)=1200;
    end
    break_times(i)=((break_times(i))*300)/1200;
    break_times(i)=round(break_times(i));
end

%[follow_pwelch,f] = pwelch(ConnegFollow_1(30:follow_times(i),:,i));
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

mkdir(['subject_' int2str(number) '_psd']);

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

%%

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



%%
if exist('ConnegFollow_1','var')
global data1;    
data1 = ConnegFollow_1;
uif1 = uifigure();
global uax1;
uax1 = uiaxes(uif1, 'position' , [20 100 1300 300]);
global names1;
names1=["Fp1","Fz","F3","F7","FT9","FC5","FC1","C3","T7","TP9","CP5","CP1","Pz","P3","P7","O1","Oz","O2","P4","P8","TP10","CP6","CP2","Cz","C4","T8","FT10","FC6","FC2","F4","F8","Fp2","VEOG"];
bra = plot(uax1, data1(:,:,1));
subtitle(uax1, 'Trial 1','FontSize', 20 );
title(uax1,'ConnegFollow Condition','FontSize', 25)
xlabel(uax1,'Time Samples','FontSize', 15)
ylabel(uax1,'Amplitud','FontSize', 15)
hold(uax1, 'off' ) % don't hold!
grid(uax1, 'on' )
legend(bra(:),["Fp1","Fz","F3","F7","FT9","FC5","FC1","C3","T7","TP9","CP5","CP1","Pz","P3","P7","O1","Oz","O2","P4","P8","TP10","CP6","CP2","Cz","C4","T8","FT10","FC6","FC2","F4","F8","Fp2","VEOG"]);
global graph1;
graph1=data1;
global valor1;
valor1=1;
%uis = uislider(uif, 'position' ,[50 50 450 3], ...
n = size(data1,3);
    uis1 = uislider(uif1, 'position' ,[50 50 1300 3], ...
    'value' ,1, ...
    'Limits' , [1,n], ...
    'MajorTicks' , 1:1:n, ...
    'MinorTicks' , []);
uis1.ValueChangedFcn = {@sliderChangedFcn1, uax1, graph1};
cbx11 = uicheckbox(uif1,'Text','Fp1','Position',[50 70 102 15],...
    'value' ,1);
     cbx11.ValueChangedFcn={@cbxChangedFcn11,uax1, graph1};

cbx12 = uicheckbox(uif1,'Text','Fz','Position',[90 70 102 15],...
    'value' ,1);
     cbx12.ValueChangedFcn={@cbxChangedFcn12,uax1, graph1};
     
cbx13 = uicheckbox(uif1,'Text','F3','Position',[125 70 102 15],...
    'value' ,1);
     cbx13.ValueChangedFcn={@cbxChangedFcn13,uax1, graph1};  
     
cbx14 = uicheckbox(uif1,'Text','F7','Position',[160 70 102 15],...
    'value' ,1);
     cbx14.ValueChangedFcn={@cbxChangedFcn14,uax1, graph1};
     
cbx15 = uicheckbox(uif1,'Text','FT9','Position',[195 70 102 15],...
    'value' ,1);
     cbx15.ValueChangedFcn={@cbxChangedFcn15,uax1, graph1};    
     
cbx16 = uicheckbox(uif1,'Text','FC5','Position',[237 70 102 15],...
    'value' ,1);
     cbx16.ValueChangedFcn={@cbxChangedFcn16,uax1, graph1};
     
cbx17 = uicheckbox(uif1,'Text','FC1','Position',[280 70 102 15],...
    'value' ,1);
     cbx17.ValueChangedFcn={@cbxChangedFcn17,uax1, graph1};
     
cbx18 = uicheckbox(uif1,'Text','C3','Position',[322 70 102 15],...
    'value' ,1);
     cbx18.ValueChangedFcn={@cbxChangedFcn18,uax1, graph1};  
     
cbx19 = uicheckbox(uif1,'Text','T7','Position',[357 70 102 15],...
    'value' ,1);
     cbx19.ValueChangedFcn={@cbxChangedFcn19,uax1, graph1};

cbx110 = uicheckbox(uif1,'Text','TP9','Position',[390 70 102 15],...
    'value' ,1);
     cbx110.ValueChangedFcn={@cbxChangedFcn110,uax1, graph1};

cbx111 = uicheckbox(uif1,'Text','CP5','Position',[432 70 102 15],...
    'value' ,1);
     cbx111.ValueChangedFcn={@cbxChangedFcn111,uax1, graph1}; 
     
cbx112 = uicheckbox(uif1,'Text','CP1','Position',[475 70 102 15],...
    'value' ,1);
     cbx112.ValueChangedFcn={@cbxChangedFcn112,uax1, graph1};  
     
cbx113 = uicheckbox(uif1,'Text','Pz','Position',[517 70 102 15],...
    'value' ,1);
     cbx113.ValueChangedFcn={@cbxChangedFcn113,uax1, graph1}; 
     
cbx114 = uicheckbox(uif1,'Text','P3','Position',[550 70 102 15],...
    'value' ,1);
     cbx114.ValueChangedFcn={@cbxChangedFcn114,uax1, graph1}; 
     
cbx115 = uicheckbox(uif1,'Text','P7','Position',[585 70 102 15],...
    'value' ,1);
     cbx115.ValueChangedFcn={@cbxChangedFcn115,uax1, graph1}; 
     
cbx116 = uicheckbox(uif1,'Text','O1','Position',[618 70 102 15],...
    'value' ,1);
     cbx116.ValueChangedFcn={@cbxChangedFcn116,uax1, graph1};
     
cbx117 = uicheckbox(uif1,'Text','Oz','Position',[652 70 102 15],...
    'value' ,1);
     cbx117.ValueChangedFcn={@cbxChangedFcn117,uax1, graph1};  
     
cbx118 = uicheckbox(uif1,'Text','O2','Position',[687 70 102 15],...
    'value' ,1);
     cbx118.ValueChangedFcn={@cbxChangedFcn118,uax1, graph1}; 
     
cbx119 = uicheckbox(uif1,'Text','P4','Position',[722 70 102 15],...
    'value' ,1);
     cbx119.ValueChangedFcn={@cbxChangedFcn119,uax1, graph1};   
     
cbx120 = uicheckbox(uif1,'Text','P8','Position',[755 70 102 15],...
    'value' ,1);
     cbx120.ValueChangedFcn={@cbxChangedFcn120,uax1, graph1};
     
cbx121 = uicheckbox(uif1,'Text','TP10','Position',[790 70 102 15],...
    'value' ,1);
     cbx121.ValueChangedFcn={@cbxChangedFcn121,uax1, graph1}; 
     
cbx122 = uicheckbox(uif1,'Text','CP6','Position',[838 70 102 15],...
    'value' ,1);
     cbx122.ValueChangedFcn={@cbxChangedFcn122,uax1, graph1};  
     
cbx123 = uicheckbox(uif1,'Text','CP2','Position',[880 70 102 15],...
    'value' ,1);
     cbx123.ValueChangedFcn={@cbxChangedFcn123,uax1, graph1}; 
     
cbx124 = uicheckbox(uif1,'Text','Cz','Position',[923 70 102 15],...
    'value' ,1);
     cbx124.ValueChangedFcn={@cbxChangedFcn124,uax1, graph1};
     
cbx125 = uicheckbox(uif1,'Text','C4','Position',[957 70 102 15],...
    'value' ,1);
     cbx125.ValueChangedFcn={@cbxChangedFcn125,uax1, graph1};  
     
cbx126 = uicheckbox(uif1,'Text','T8','Position',[993 70 102 15],...
    'value' ,1);
     cbx126.ValueChangedFcn={@cbxChangedFcn126,uax1, graph1};   
     
cbx127 = uicheckbox(uif1,'Text','FT10','Position',[1027 70 102 15],...
    'value' ,1);
     cbx127.ValueChangedFcn={@cbxChangedFcn127,uax1, graph1};
     
cbx128 = uicheckbox(uif1,'Text','FC6','Position',[1075 70 102 15],...
    'value' ,1);
     cbx128.ValueChangedFcn={@cbxChangedFcn128,uax1, graph1};    
     
cbx129 = uicheckbox(uif1,'Text','FC2','Position',[1120 70 102 15],...
    'value' ,1);
     cbx129.ValueChangedFcn={@cbxChangedFcn129,uax1, graph1};     
     
cbx130 = uicheckbox(uif1,'Text','F4','Position',[1163 70 102 15],...
    'value' ,1);
     cbx130.ValueChangedFcn={@cbxChangedFcn130,uax1, graph1};
     
cbx131 = uicheckbox(uif1,'Text','F8','Position',[1198 70 102 15],...
    'value' ,1);
     cbx131.ValueChangedFcn={@cbxChangedFcn131,uax1, graph1};  
     
cbx132 = uicheckbox(uif1,'Text','Fp2','Position',[1232 70 102 15],...
    'value' ,1);
     cbx132.ValueChangedFcn={@cbxChangedFcn132,uax1, graph1};
     
cbx133 = uicheckbox(uif1,'Text','VEOG','Position',[1275 70 102 15],...
    'value' ,1);
     cbx133.ValueChangedFcn={@cbxChangedFcn133,uax1, graph1};     
end

%%

if exist('ConnegBreak_1','var')
global data2;    
data2 = ConnegBreak_1;
uif2 = uifigure();
global uax2;
uax2 = uiaxes(uif2, 'position' , [20 100 1300 300]);
global names2;
names2=["Fp1","Fz","F3","F7","FT9","FC5","FC1","C3","T7","TP9","CP5","CP1","Pz","P3","P7","O1","Oz","O2","P4","P8","TP10","CP6","CP2","Cz","C4","T8","FT10","FC6","FC2","F4","F8","Fp2","VEOG"];
bra = plot(uax2, data2(:,:,1));
subtitle(uax2, 'Trial 1','FontSize', 20 );
title(uax2,'ConnegBreak Condition','FontSize', 25)
xlabel(uax2,'Time Samples','FontSize', 15)
ylabel(uax2,'Amplitud','FontSize', 15)
hold(uax2, 'off' ) % don't hold!
grid(uax2, 'on' )
legend(bra(:),["Fp1","Fz","F3","F7","FT9","FC5","FC1","C3","T7","TP9","CP5","CP1","Pz","P3","P7","O1","Oz","O2","P4","P8","TP10","CP6","CP2","Cz","C4","T8","FT10","FC6","FC2","F4","F8","Fp2","VEOG"]);
global graph2;
graph2=data2;
global valor2;
valor2=1;
%uis = uislider(uif, 'position' ,[50 50 450 3], ...
n = size(data2,3);
    uis2 = uislider(uif2, 'position' ,[50 50 1300 3], ...
    'value' ,1, ...
    'Limits' , [1,n], ...
    'MajorTicks' , 1:1:n, ...
    'MinorTicks' , []);
uis2.ValueChangedFcn = {@sliderChangedFcn2, uax2, graph2};
cbx21 = uicheckbox(uif2,'Text','Fp1','Position',[50 70 102 15],...
    'value' ,1);
     cbx21.ValueChangedFcn={@cbxChangedFcn21,uax2, graph2};

cbx22 = uicheckbox(uif2,'Text','Fz','Position',[90 70 102 15],...
    'value' ,1);
     cbx22.ValueChangedFcn={@cbxChangedFcn22,uax2, graph2};
     
cbx23 = uicheckbox(uif2,'Text','F3','Position',[125 70 102 15],...
    'value' ,1);
     cbx23.ValueChangedFcn={@cbxChangedFcn23,uax2, graph2};  
     
cbx24 = uicheckbox(uif2,'Text','F7','Position',[160 70 102 15],...
    'value' ,1);
     cbx24.ValueChangedFcn={@cbxChangedFcn24,uax2, graph2};
     
cbx25 = uicheckbox(uif2,'Text','FT9','Position',[195 70 102 15],...
    'value' ,1);
     cbx25.ValueChangedFcn={@cbxChangedFcn25,uax2, graph2};    
     
cbx26 = uicheckbox(uif2,'Text','FC5','Position',[237 70 102 15],...
    'value' ,1);
     cbx26.ValueChangedFcn={@cbxChangedFcn26,uax2, graph2};
     
cbx27 = uicheckbox(uif2,'Text','FC1','Position',[280 70 102 15],...
    'value' ,1);
     cbx27.ValueChangedFcn={@cbxChangedFcn27,uax2, graph2};
     
cbx28 = uicheckbox(uif2,'Text','C3','Position',[322 70 102 15],...
    'value' ,1);
     cbx28.ValueChangedFcn={@cbxChangedFcn28,uax2, graph2};  
     
cbx29 = uicheckbox(uif2,'Text','T7','Position',[357 70 102 15],...
    'value' ,1);
     cbx29.ValueChangedFcn={@cbxChangedFcn29,uax2, graph2};

cbx210 = uicheckbox(uif2,'Text','TP9','Position',[390 70 102 15],...
    'value' ,1);
     cbx210.ValueChangedFcn={@cbxChangedFcn210,uax2, graph2};

cbx211 = uicheckbox(uif2,'Text','CP5','Position',[432 70 102 15],...
    'value' ,1);
     cbx211.ValueChangedFcn={@cbxChangedFcn211,uax2, graph2}; 
     
cbx212 = uicheckbox(uif2,'Text','CP1','Position',[475 70 102 15],...
    'value' ,1);
     cbx212.ValueChangedFcn={@cbxChangedFcn212,uax2, graph2};  
     
cbx213 = uicheckbox(uif2,'Text','Pz','Position',[517 70 102 15],...
    'value' ,1);
     cbx213.ValueChangedFcn={@cbxChangedFcn213,uax2, graph2}; 
     
cbx214 = uicheckbox(uif2,'Text','P3','Position',[550 70 102 15],...
    'value' ,1);
     cbx214.ValueChangedFcn={@cbxChangedFcn214,uax2, graph2}; 
     
cbx215 = uicheckbox(uif2,'Text','P7','Position',[585 70 102 15],...
    'value' ,1);
     cbx215.ValueChangedFcn={@cbxChangedFcn215,uax2, graph2}; 
     
cbx216 = uicheckbox(uif2,'Text','O1','Position',[618 70 102 15],...
    'value' ,1);
     cbx216.ValueChangedFcn={@cbxChangedFcn216,uax2, graph2};
     
cbx217 = uicheckbox(uif2,'Text','Oz','Position',[652 70 102 15],...
    'value' ,1);
     cbx217.ValueChangedFcn={@cbxChangedFcn217,uax2, graph2};  
     
cbx218 = uicheckbox(uif2,'Text','O2','Position',[687 70 102 15],...
    'value' ,1);
     cbx218.ValueChangedFcn={@cbxChangedFcn218,uax2, graph2}; 
     
cbx219 = uicheckbox(uif2,'Text','P4','Position',[722 70 102 15],...
    'value' ,1);
     cbx219.ValueChangedFcn={@cbxChangedFcn219,uax2, graph2};   
     
cbx220 = uicheckbox(uif2,'Text','P8','Position',[755 70 102 15],...
    'value' ,1);
     cbx220.ValueChangedFcn={@cbxChangedFcn220,uax2, graph2};
     
cbx221 = uicheckbox(uif2,'Text','TP10','Position',[790 70 102 15],...
    'value' ,1);
     cbx221.ValueChangedFcn={@cbxChangedFcn221,uax2, graph2}; 
     
cbx222 = uicheckbox(uif2,'Text','CP6','Position',[838 70 102 15],...
    'value' ,1);
     cbx222.ValueChangedFcn={@cbxChangedFcn222,uax2, graph2};  
     
cbx223 = uicheckbox(uif2,'Text','CP2','Position',[880 70 102 15],...
    'value' ,1);
     cbx223.ValueChangedFcn={@cbxChangedFcn223,uax2, graph2}; 
     
cbx224 = uicheckbox(uif2,'Text','Cz','Position',[923 70 102 15],...
    'value' ,1);
     cbx224.ValueChangedFcn={@cbxChangedFcn224,uax2, graph2};
     
cbx225 = uicheckbox(uif2,'Text','C4','Position',[957 70 102 15],...
    'value' ,1);
     cbx225.ValueChangedFcn={@cbxChangedFcn225,uax2, graph2};  
     
cbx226 = uicheckbox(uif2,'Text','T8','Position',[993 70 102 15],...
    'value' ,1);
     cbx226.ValueChangedFcn={@cbxChangedFcn226,uax2, graph2};   
     
cbx227 = uicheckbox(uif2,'Text','FT10','Position',[1027 70 102 15],...
    'value' ,1);
     cbx227.ValueChangedFcn={@cbxChangedFcn227,uax2, graph2};
     
cbx228 = uicheckbox(uif2,'Text','FC6','Position',[1075 70 102 15],...
    'value' ,1);
     cbx228.ValueChangedFcn={@cbxChangedFcn228,uax2, graph2};    
     
cbx229 = uicheckbox(uif2,'Text','FC2','Position',[1120 70 102 15],...
    'value' ,1);
     cbx229.ValueChangedFcn={@cbxChangedFcn229,uax2, graph2};     
     
cbx230 = uicheckbox(uif2,'Text','F4','Position',[1163 70 102 15],...
    'value' ,1);
     cbx230.ValueChangedFcn={@cbxChangedFcn230,uax2, graph2};
     
cbx231 = uicheckbox(uif2,'Text','F8','Position',[1198 70 102 15],...
    'value' ,1);
     cbx231.ValueChangedFcn={@cbxChangedFcn231,uax2, graph2};  
     
cbx232 = uicheckbox(uif2,'Text','Fp2','Position',[1232 70 102 15],...
    'value' ,1);
     cbx232.ValueChangedFcn={@cbxChangedFcn232,uax2, graph2};
     
cbx233 = uicheckbox(uif2,'Text','VEOG','Position',[1275 70 102 15],...
    'value' ,1);
     cbx233.ValueChangedFcn={@cbxChangedFcn233,uax2, graph2};     
end

%%

%%
if exist('ConnegFollow_1','var')
global data3;    
data3 = follow_psd;
uif3 = uifigure();
global uax3;
uax3 = uiaxes(uif3, 'position' , [20 100 1300 300]);
global names3;
names3=["Fp1","Fz","F3","F7","FT9","FC5","FC1","C3","T7","TP9","CP5","CP1","Pz","P3","P7","O1","Oz","O2","P4","P8","TP10","CP6","CP2","Cz","C4","T8","FT10","FC6","FC2","F4","F8","Fp2","VEOG"];
bra = plot(uax3, data3(:,:,1));
subtitle(uax3, 'Trial 1','FontSize', 20 );
title(uax3,'ConnegFollow Condition','FontSize', 25)
xlabel(uax3,'Time Samples','FontSize', 15)
ylabel(uax3,'Amplitud','FontSize', 15)
hold(uax3, 'off' ) % don't hold!
grid(uax3, 'on' )
legend(bra(:),["Fp1","Fz","F3","F7","FT9","FC5","FC1","C3","T7","TP9","CP5","CP1","Pz","P3","P7","O1","Oz","O2","P4","P8","TP10","CP6","CP2","Cz","C4","T8","FT10","FC6","FC2","F4","F8","Fp2","VEOG"]);
global graph3;
graph3=data3;
global valor3;
valor3=1;
%uis = uislider(uif, 'position' ,[50 50 450 3], ...
n = size(data3,3);
    uis3 = uislider(uif3, 'position' ,[50 50 1300 3], ...
    'value' ,1, ...
    'Limits' , [1,n], ...
    'MajorTicks' , 1:1:n, ...
    'MinorTicks' , []);
uis3.ValueChangedFcn = {@sliderChangedFcn3, uax3, graph3};

cbx31 = uicheckbox(uif3,'Text','Fp1','Position',[50 70 102 15],...
    'value' ,1);
     cbx31.ValueChangedFcn={@cbxChangedFcn31,uax3, graph3};

cbx32 = uicheckbox(uif3,'Text','Fz','Position',[90 70 102 15],...
    'value' ,1);
     cbx32.ValueChangedFcn={@cbxChangedFcn32,uax3, graph3};
     
cbx33 = uicheckbox(uif3,'Text','F3','Position',[125 70 102 15],...
    'value' ,1);
     cbx33.ValueChangedFcn={@cbxChangedFcn33,uax3, graph3};  
     
cbx34 = uicheckbox(uif3,'Text','F7','Position',[160 70 102 15],...
    'value' ,1);
     cbx34.ValueChangedFcn={@cbxChangedFcn34,uax3, graph3};
     
cbx35 = uicheckbox(uif3,'Text','FT9','Position',[195 70 102 15],...
    'value' ,1);
     cbx35.ValueChangedFcn={@cbxChangedFcn35,uax3, graph3};    
     
cbx36 = uicheckbox(uif3,'Text','FC5','Position',[237 70 102 15],...
    'value' ,1);
     cbx36.ValueChangedFcn={@cbxChangedFcn36,uax3, graph3};
     
cbx37 = uicheckbox(uif3,'Text','FC1','Position',[280 70 102 15],...
    'value' ,1);
     cbx37.ValueChangedFcn={@cbxChangedFcn37,uax3, graph3};
     
cbx38 = uicheckbox(uif3,'Text','C3','Position',[322 70 102 15],...
    'value' ,1);
     cbx38.ValueChangedFcn={@cbxChangedFcn38,uax3, graph3};  
     
cbx39 = uicheckbox(uif3,'Text','T7','Position',[357 70 102 15],...
    'value' ,1);
     cbx39.ValueChangedFcn={@cbxChangedFcn39,uax3, graph3};

cbx310 = uicheckbox(uif3,'Text','TP9','Position',[390 70 102 15],...
    'value' ,1);
     cbx310.ValueChangedFcn={@cbxChangedFcn310,uax3, graph3};

cbx311 = uicheckbox(uif3,'Text','CP5','Position',[432 70 102 15],...
    'value' ,1);
     cbx311.ValueChangedFcn={@cbxChangedFcn311,uax3, graph3}; 
     
cbx312 = uicheckbox(uif3,'Text','CP1','Position',[475 70 102 15],...
    'value' ,1);
     cbx312.ValueChangedFcn={@cbxChangedFcn312,uax3, graph3};  
     
cbx313 = uicheckbox(uif3,'Text','Pz','Position',[517 70 102 15],...
    'value' ,1);
     cbx313.ValueChangedFcn={@cbxChangedFcn313,uax3, graph3}; 
     
cbx314 = uicheckbox(uif3,'Text','P3','Position',[550 70 102 15],...
    'value' ,1);
     cbx314.ValueChangedFcn={@cbxChangedFcn314,uax3, graph3}; 
     
cbx315 = uicheckbox(uif3,'Text','P7','Position',[585 70 102 15],...
    'value' ,1);
     cbx315.ValueChangedFcn={@cbxChangedFcn315,uax3, graph3}; 
     
cbx316 = uicheckbox(uif3,'Text','O1','Position',[618 70 102 15],...
    'value' ,1);
     cbx316.ValueChangedFcn={@cbxChangedFcn316,uax3, graph3};
     
cbx317 = uicheckbox(uif3,'Text','Oz','Position',[652 70 102 15],...
    'value' ,1);
     cbx317.ValueChangedFcn={@cbxChangedFcn317,uax3, graph3};  
     
cbx318 = uicheckbox(uif3,'Text','O2','Position',[687 70 102 15],...
    'value' ,1);
     cbx318.ValueChangedFcn={@cbxChangedFcn318,uax3, graph3}; 
     
cbx319 = uicheckbox(uif3,'Text','P4','Position',[722 70 102 15],...
    'value' ,1);
     cbx319.ValueChangedFcn={@cbxChangedFcn319,uax3, graph3};   
     
cbx320 = uicheckbox(uif3,'Text','P8','Position',[755 70 102 15],...
    'value' ,1);
     cbx320.ValueChangedFcn={@cbxChangedFcn320,uax3, graph3};
     
cbx321 = uicheckbox(uif3,'Text','TP10','Position',[790 70 102 15],...
    'value' ,1);
     cbx321.ValueChangedFcn={@cbxChangedFcn321,uax3, graph3}; 
     
cbx322 = uicheckbox(uif3,'Text','CP6','Position',[838 70 102 15],...
    'value' ,1);
     cbx322.ValueChangedFcn={@cbxChangedFcn322,uax3, graph3};  
     
cbx323 = uicheckbox(uif3,'Text','CP2','Position',[880 70 102 15],...
    'value' ,1);
     cbx323.ValueChangedFcn={@cbxChangedFcn323,uax3, graph3}; 
     
cbx324 = uicheckbox(uif3,'Text','Cz','Position',[923 70 102 15],...
    'value' ,1);
     cbx324.ValueChangedFcn={@cbxChangedFcn324,uax3, graph3};
     
cbx325 = uicheckbox(uif3,'Text','C4','Position',[957 70 102 15],...
    'value' ,1);
     cbx325.ValueChangedFcn={@cbxChangedFcn325,uax3, graph3};  
     
cbx326 = uicheckbox(uif3,'Text','T8','Position',[993 70 102 15],...
    'value' ,1);
     cbx326.ValueChangedFcn={@cbxChangedFcn326,uax3, graph3};   
     
cbx327 = uicheckbox(uif3,'Text','FT10','Position',[1027 70 102 15],...
    'value' ,1);
     cbx327.ValueChangedFcn={@cbxChangedFcn327,uax3, graph3};
     
cbx328 = uicheckbox(uif3,'Text','FC6','Position',[1075 70 102 15],...
    'value' ,1);
     cbx328.ValueChangedFcn={@cbxChangedFcn328,uax3, graph3};    
     
cbx329 = uicheckbox(uif3,'Text','FC2','Position',[1120 70 102 15],...
    'value' ,1);
     cbx329.ValueChangedFcn={@cbxChangedFcn329,uax3, graph3};     
     
cbx330 = uicheckbox(uif3,'Text','F4','Position',[1163 70 102 15],...
    'value' ,1);
     cbx330.ValueChangedFcn={@cbxChangedFcn330,uax3, graph3};
     
cbx331 = uicheckbox(uif3,'Text','F8','Position',[1198 70 102 15],...
    'value' ,1);
     cbx331.ValueChangedFcn={@cbxChangedFcn331,uax3, graph3};  
     
cbx332 = uicheckbox(uif3,'Text','Fp2','Position',[1232 70 102 15],...
    'value' ,1);
     cbx332.ValueChangedFcn={@cbxChangedFcn332,uax3, graph3};
     
cbx333 = uicheckbox(uif3,'Text','VEOG','Position',[1275 70 102 15],...
    'value' ,1);
     cbx333.ValueChangedFcn={@cbxChangedFcn333,uax3, graph3};     
end

%%

if exist('ConnegBreak_1','var')
global data4;    
data4 = break_psd;
uif4 = uifigure();
global uax4;
uax4 = uiaxes(uif4, 'position' , [20 100 1300 300]);
global names4;
names4=["Fp1","Fz","F3","F7","FT9","FC5","FC1","C3","T7","TP9","CP5","CP1","Pz","P3","P7","O1","Oz","O2","P4","P8","TP10","CP6","CP2","Cz","C4","T8","FT10","FC6","FC2","F4","F8","Fp2","VEOG"];
bra = plot(uax4, data4(:,:,1));
subtitle(uax4, 'Trial 1','FontSize', 20 );
title(uax4,'ConnegBreak Condition','FontSize', 25)
xlabel(uax4,'Time Samples','FontSize', 15)
ylabel(uax4,'Amplitud','FontSize', 15)
hold(uax4, 'off' ) % don't hold!
grid(uax4, 'on' )
legend(bra(:),["Fp1","Fz","F3","F7","FT9","FC5","FC1","C3","T7","TP9","CP5","CP1","Pz","P3","P7","O1","Oz","O2","P4","P8","TP10","CP6","CP2","Cz","C4","T8","FT10","FC6","FC2","F4","F8","Fp2","VEOG"]);
global graph4;
graph4=data4;
global valor4;
valor4=1;
%uis = uislider(uif, 'position' ,[50 50 450 3], ...
n = size(data4,3);
    uis4 = uislider(uif4, 'position' ,[50 50 1300 3], ...
    'value' ,1, ...
    'Limits' , [1,n], ...
    'MajorTicks' , 1:1:n, ...
    'MinorTicks' , []);
uis4.ValueChangedFcn = {@sliderChangedFcn4, uax4, graph4};
cbx41 = uicheckbox(uif4,'Text','Fp1','Position',[50 70 102 15],...
    'value' ,1);
     cbx41.ValueChangedFcn={@cbxChangedFcn41,uax4, graph4};

cbx42 = uicheckbox(uif4,'Text','Fz','Position',[90 70 102 15],...
    'value' ,1);
     cbx42.ValueChangedFcn={@cbxChangedFcn42,uax4, graph4};
     
cbx43 = uicheckbox(uif4,'Text','F3','Position',[125 70 102 15],...
    'value' ,1);
     cbx43.ValueChangedFcn={@cbxChangedFcn43,uax4, graph4};  
     
cbx44 = uicheckbox(uif4,'Text','F7','Position',[160 70 102 15],...
    'value' ,1);
     cbx44.ValueChangedFcn={@cbxChangedFcn44,uax4, graph4};
     
cbx45 = uicheckbox(uif4,'Text','FT9','Position',[195 70 102 15],...
    'value' ,1);
     cbx45.ValueChangedFcn={@cbxChangedFcn45,uax4, graph4};    
     
cbx46 = uicheckbox(uif4,'Text','FC5','Position',[237 70 102 15],...
    'value' ,1);
     cbx46.ValueChangedFcn={@cbxChangedFcn46,uax4, graph4};
     
cbx47 = uicheckbox(uif4,'Text','FC1','Position',[280 70 102 15],...
    'value' ,1);
     cbx47.ValueChangedFcn={@cbxChangedFcn47,uax4, graph4};
     
cbx48 = uicheckbox(uif4,'Text','C3','Position',[322 70 102 15],...
    'value' ,1);
     cbx48.ValueChangedFcn={@cbxChangedFcn48,uax4, graph4};  
     
cbx49 = uicheckbox(uif4,'Text','T7','Position',[357 70 102 15],...
    'value' ,1);
     cbx49.ValueChangedFcn={@cbxChangedFcn49,uax4, graph4};

cbx410 = uicheckbox(uif4,'Text','TP9','Position',[390 70 102 15],...
    'value' ,1);
     cbx410.ValueChangedFcn={@cbxChangedFcn410,uax4, graph4};

cbx411 = uicheckbox(uif4,'Text','CP5','Position',[432 70 102 15],...
    'value' ,1);
     cbx411.ValueChangedFcn={@cbxChangedFcn411,uax4, graph4}; 
     
cbx412 = uicheckbox(uif4,'Text','CP1','Position',[475 70 102 15],...
    'value' ,1);
     cbx412.ValueChangedFcn={@cbxChangedFcn412,uax4, graph4};  
     
cbx413 = uicheckbox(uif4,'Text','Pz','Position',[517 70 102 15],...
    'value' ,1);
     cbx413.ValueChangedFcn={@cbxChangedFcn413,uax4, graph4}; 
     
cbx414 = uicheckbox(uif4,'Text','P3','Position',[550 70 102 15],...
    'value' ,1);
     cbx414.ValueChangedFcn={@cbxChangedFcn414,uax4, graph4}; 
     
cbx415 = uicheckbox(uif4,'Text','P7','Position',[585 70 102 15],...
    'value' ,1);
     cbx415.ValueChangedFcn={@cbxChangedFcn415,uax4, graph4}; 
     
cbx416 = uicheckbox(uif4,'Text','O1','Position',[618 70 102 15],...
    'value' ,1);
     cbx416.ValueChangedFcn={@cbxChangedFcn416,uax4, graph4};
     
cbx417 = uicheckbox(uif4,'Text','Oz','Position',[652 70 102 15],...
    'value' ,1);
     cbx417.ValueChangedFcn={@cbxChangedFcn417,uax4, graph4};  
     
cbx418 = uicheckbox(uif4,'Text','O2','Position',[687 70 102 15],...
    'value' ,1);
     cbx418.ValueChangedFcn={@cbxChangedFcn418,uax4, graph4}; 
     
cbx419 = uicheckbox(uif4,'Text','P4','Position',[722 70 102 15],...
    'value' ,1);
     cbx419.ValueChangedFcn={@cbxChangedFcn419,uax4, graph4};   
     
cbx420 = uicheckbox(uif4,'Text','P8','Position',[755 70 102 15],...
    'value' ,1);
     cbx420.ValueChangedFcn={@cbxChangedFcn420,uax4, graph4};
     
cbx421 = uicheckbox(uif4,'Text','TP10','Position',[790 70 102 15],...
    'value' ,1);
     cbx421.ValueChangedFcn={@cbxChangedFcn421,uax4, graph4}; 
     
cbx422 = uicheckbox(uif4,'Text','CP6','Position',[838 70 102 15],...
    'value' ,1);
     cbx422.ValueChangedFcn={@cbxChangedFcn422,uax4, graph4};  
     
cbx423 = uicheckbox(uif4,'Text','CP2','Position',[880 70 102 15],...
    'value' ,1);
     cbx423.ValueChangedFcn={@cbxChangedFcn423,uax4, graph4}; 
     
cbx424 = uicheckbox(uif4,'Text','Cz','Position',[923 70 102 15],...
    'value' ,1);
     cbx424.ValueChangedFcn={@cbxChangedFcn424,uax4, graph4};
     
cbx425 = uicheckbox(uif4,'Text','C4','Position',[957 70 102 15],...
    'value' ,1);
     cbx425.ValueChangedFcn={@cbxChangedFcn425,uax4, graph4};  
     
cbx426 = uicheckbox(uif4,'Text','T8','Position',[993 70 102 15],...
    'value' ,1);
     cbx426.ValueChangedFcn={@cbxChangedFcn426,uax4, graph4};   
     
cbx427 = uicheckbox(uif4,'Text','FT10','Position',[1027 70 102 15],...
    'value' ,1);
     cbx427.ValueChangedFcn={@cbxChangedFcn427,uax4, graph4};
     
cbx428 = uicheckbox(uif4,'Text','FC6','Position',[1075 70 102 15],...
    'value' ,1);
     cbx428.ValueChangedFcn={@cbxChangedFcn428,uax4, graph4};    
     
cbx429 = uicheckbox(uif4,'Text','FC2','Position',[1120 70 102 15],...
    'value' ,1);
     cbx429.ValueChangedFcn={@cbxChangedFcn429,uax4, graph4};     
     
cbx430 = uicheckbox(uif4,'Text','F4','Position',[1163 70 102 15],...
    'value' ,1);
     cbx430.ValueChangedFcn={@cbxChangedFcn430,uax4, graph4};
     
cbx431 = uicheckbox(uif4,'Text','F8','Position',[1198 70 102 15],...
    'value' ,1);
     cbx431.ValueChangedFcn={@cbxChangedFcn431,uax4, graph4};  
     
cbx432 = uicheckbox(uif4,'Text','Fp2','Position',[1232 70 102 15],...
    'value' ,1);
     cbx432.ValueChangedFcn={@cbxChangedFcn432,uax4, graph4};
     
cbx433 = uicheckbox(uif4,'Text','VEOG','Position',[1275 70 102 15],...
    'value' ,1);
     cbx433.ValueChangedFcn={@cbxChangedFcn433,uax4, graph4};     
end

%%

