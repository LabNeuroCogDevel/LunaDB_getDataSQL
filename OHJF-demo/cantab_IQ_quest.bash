#!/usr/bin/env bash
dbi="mysql://localadmin:local!123@arnold.wpic.upmc.edu/lncddb3"

perl -F, -slane 'next if $.==1;
  print "$F[0] ", join( "-", map {sprintf "%02s", $_} (split/\//,$F[1])[2,0,1])
 ' CANTAB_LunaIDsForDemos.csv > luna_date.txt 

sql "$dbi" \
"
create temporary table cantabvisit (luna varchar(10), visitdate date);
load data local infile 'luna_date.txt' into table cantabvisit Fields TERMINATED BY ' ';
select 
   p.value as lunaid,
   abs(datediff(v.visitdate,cv.visitdate)/365.25) as visitdiffyears,
   vt.taskName,
   vt.subsection, 
   replace(replace(vt.value, '\n',';'),'\"','') as value
      from cantabvisit as cv
      join peopleEnroll p
       on p.value=cv.luna
      join visits v 
       on  p.peopleID=v.peopleID
      join visitstasks vt 
       on v.visitID=vt.visitID
      where 
        enrollType like 'LunaID' and
        subsection in ('DMSDifficulty','DMSStrategy',
                  'SSPDifficulty' ,'SSPStrategy',
                  'SOCDifficulty','SOCStrategy',
                  'wfull2','wfull4','wvoc','wperf')
" > allQuest_WASI_forCANTAB.txt 

Rio -d"\t" -r -e 'df %>% group_by(lunaid,taskName,subsection) %>%  filter(rank(visitdiffyears,ties.method="first")==1) %>% unite(ts,taskName,subsection) %>% select(-visitdiffyears) %>% spread(ts,value)' < allQuest_WASI_forCANTAB.txt > closestsToCANTAB.csv
