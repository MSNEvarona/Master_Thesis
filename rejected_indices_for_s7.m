[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename','019_ArRej.set','filepath','C:\\Users\\cvaj_\\OneDrive\\Escritorio\\Thesis Data\\');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
eeglab redraw;
%%

after=[EEG.event];
before=[EEG.urevent];
%%
code=[ALLEEG.EVENTLIST.eventinfo.code];
wrong_code=find(code==999999);

for i=1:length(wrong_code)
    
    eventlist(i)=ALLEEG.EVENTLIST.eventinfo(wrong_code(i));
end
code_label={eventlist.codelabel};
bvmknum=[eventlist.bvmknum];
code_s7=find(code_label=="S7");
for i=1:length(code_s7)
    
     wrong_bknum(i)= bvmknum(code_s7(i));
end

for i=1:length(wrong_bknum)
    
    [before(wrong_bknum(i)).type]='wrong';
end

%%
type1={before.type};
type2={after.binlabel};
type3={after.bvmknum};
%%
index_all_conditions=find(type1=="S  7");
indices=dfNegTrial1(:,2);
indices=indices-5;


for i=1:length(indices)
bknum(i)=index_all_conditions(indices(i));
end
bknum=string(bknum);

%% 



index_conneg_follow_type=find(type2=="B1(S7)");
index_conneg_break_type=find(type2=="B2(S7)");

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
writetable(parameters,'rejected_trials_subject_19.xlsx','Sheet',1,'WriteVariableNames',false);

