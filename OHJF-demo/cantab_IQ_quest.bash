#!/usr/bin/env bash
dbi="mysql://localadmin:local!123@arnold.wpic.upmc.edu/lncddb3"
# sql "$dbi" "create temporary table mytable (luna varchar(10), visitdate date); load data local infile 'CANTAB_LunaIDsForDemos.csv' into table mytable Fields TERMINATED BY ','; select * from mytable"
perl -F, -slane 'next if $.==1;
  print "$F[0] ", join( "-", map {sprintf "%02s", $_} (split/\//,$F[1])[2,0,1])
 ' CANTAB_LunaIDsForDemos.csv | 
 while read luna vd; do

   query="
     select p.value as lunaid, abs(datediff(visitdate,'$vd')/365.25) as visitdiffyears, vt.taskName,vt.subsection, vt.value
      from peopleEnroll p
      join visits v 
       on  p.peopleID=v.peopleID
      join visitstasks vt 
       on v.visitID=vt.visitID
      where enrollType like 'LunaID' and
            p.value like '$luna' and
            subsection in ('DMSDifficulty','DMSStrategy',
                  'SSPDifficulty' ,'SSPStrategy',
                  'SOCDifficulty','SOCStrategy',
                  'wfull2','wfull4','wvoc','wperf')
"
   sql $dbi "$query" 
done | tee allCANTAB.txt 

Rio -d"\t" ' df %>% group_by(lunaid,taskName,subsection) %>% filter(rank(visitdiffyears)==1) %>% spread' < allCANTAB.txt  > sorted
