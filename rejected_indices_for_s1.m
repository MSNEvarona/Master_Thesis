[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename','049_ArRej.set','filepath','C:\\Users\\cvaj_\\OneDrive\\Escritorio\\Thesis Data\\');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
eeglab redraw;
%%

after=[EEG.event];
before=[EEG.urevent];
type1={before.type};
type2={after.binlabel};
type3={after.bvmknum};
%%
index_all_conditions=find(type1=="S  1");
indices=dfNegTrial1(:,2);
starting_training_trials=[0 0 0 0 0];
index_all_conditions_2=cat(2,starting_training_trials,index_all_conditions);

for i=1:length(indices)
bknum(i)=index_all_conditions_2(indices(i));
end

bknum=string(bknum);
%% hasta aqui todo bien



index_conneg_follow_type=find(type2=="B1(S1)");
index_conneg_break_type=find(type2=="B2(S1)");

if index_conneg_follow_type>0
for i=1:length(index_conneg_follow_type)
bknum_after(i)=type3(index_conneg_follow_type(i));
end
bknum_after=cell2mat(bknum_after);
bknum_after=string(bknum_after);


for i=1:length(bknum_after)
    for j=1:length(bknum)
        
        if bknum(j)==bknum_after(i)
            
           bknum(j)="follow";
           
        end
    end
end

end
%%
if index_conneg_break_type>0
for i=1:length(index_conneg_break_type)
bknum_after2(i)=type3(index_conneg_break_type(i));
end
bknum_after2=cell2mat(bknum_after2);
bknum_after2=string(bknum_after2);

for i=1:length(bknum_after2)
    for j=1:length(bknum)
        
        if bknum(j)==bknum_after2(i)
            
           bknum(j)="break";
           
        end
    end
end

end


%%
bknum=bknum';
parameters=table(dfNegTrial1);
parameters.condition=bknum;
writetable(parameters,'rejected_trials_subject_49.xlsx','Sheet',1,'WriteVariableNames',false);

