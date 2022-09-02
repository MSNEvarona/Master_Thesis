
channel_groups=["Central","Centroparietal","Centroparietal_left","Centroparietal_right","Frontal_1","Frontal_2","Frontal_left","Frontal_right","Frontocentral_1","Frontocentral_2","Frontocentral_left","Frontocentral_right","Parietal","Temporal","Temporoparietal"];


Central=["Cz","C4","C3"];
Centroparietal=["Cp5","Cp1","Cp2","Cp6"];
Centroparietal_left=["Cp5","Cp1"];
Centroparietal_right=["Cp2","Cp6"];
Frontal_1=["Fp1","Fp2"];
Frontal_2=["F7","F3","Fz","F4","F8"];
Frontal_left=["F3","F7"];
Frontal_right=["F4","F8"];
Frontocentral_1=["Fz","Cz","Fc1","Fc2"];
Frontocentral_2=["Fc5","Fc1","Fc2","Fc6"];
Frontocentral_left=["Fc1","Fc5"];
Frontocentral_right=["Fc2","Fc6"];
Temporal=["T7","T8"];
Parietal=["P3","P4","Pz"];
Temporoparietal=["TP9","TP10"];
Subject="Number";
Trial="Number";


All_subjects_all_trials_table_break= table(Subject,Trial,Central,Centroparietal,Centroparietal_left,Centroparietal_right,Frontal_1,Frontal_2,Frontal_left,Frontal_right,Frontocentral_1,Frontocentral_2,Frontocentral_left,Frontocentral_right,Parietal,Temporal,Temporoparietal);



%%
trials_acumulativos=0;
for i=1:55
    
    
    if exist ("subject_"+int2str(i)+"_psd",'dir')
        for k=1:size(channel_groups,2)
        folder="C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_"+int2str(i)+"_psd\Break\"+channel_groups(k)+"\delta";
        excel_files=dir(folder+'/*.xlsx');
        trials=size(excel_files,1);
        
        for j=1:trials
       T = readtable("C:\Users\cvaj_\OneDrive\Escritorio\Thesis Data\subject_"+int2str(i)+"_psd\Break\"+channel_groups(k)+"\delta\trial_"+int2str(j));
       T= table2array(T);
       average= mean(T);
       columns=size(average,2);
       All_subjects_all_trials_table_break.Subject(j+1+trials_acumulativos)=i;
       All_subjects_all_trials_table_break.Trial(j+1+trials_acumulativos)=j;
       for l=1:columns
       All_subjects_all_trials_table_break.(channel_groups(k))(j+1+trials_acumulativos,l)=average(l);
       end
       
        end
        end
   trials_acumulativos=trials_acumulativos+trials;
    end
end
filename = sprintf('All_subjects_all_trials_table_break.xlsx'); 
writetable(All_subjects_all_trials_table_break,filename);


