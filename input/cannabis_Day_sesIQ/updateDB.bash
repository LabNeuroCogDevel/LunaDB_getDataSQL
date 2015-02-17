#!/usr/bin/env bash
set -e
RES=""

function sql {
 mysql -h arnold.wpic.upmc.edu -ulocaladmin -p'local!123' lncddb3 -NBe "$@"
}
# does the sql statement return results?
function sqlexist {
 RES=$(mysql -h arnold.wpic.upmc.edu -ulocaladmin -p'local!123' lncddb3 -NBe "$@")
 [ -n "$RES" ] 
}

# insert adult and kid mhpid's into db
(/usr/lib/node_modules/j/bin/j.njs Luna_MHP_ID_adults.xlsx &&
 /usr/lib/node_modules/j/bin/j.njs Luna_MHP_ID_kids.xlsx) |
 sed 1d |tr , "\t" | 
 while read  Luna_ID  MHP_ID   MHP_Date  MR_Date MR_Time   Notes; do
 #Luna_ID   MHP_ID   Y1_Interview   Y1_Scan  Y4_Interview   Y4_Scan for kids
   [ -z "$Luna_ID" ] && continue
   #what we have
   MHP_Date=$(echo $MHP_Date|awk -F'/' '{print "20" $3 "/" $1 "/" $2}')
   #echo "L: $Luna_ID; M: $MHP_ID; D: ${MHP_Date}"

   # find peopleID
   pid=$(sql "select peopleid from peopleEnroll where enrollType like 'LunaID' and value = $Luna_ID"|sed 1q)
   [ -z "$pid" ] && echo "no lunaid $Luna_ID in db!" && continue
   mhpid=$(sql "select value from peopleEnroll where enrollType like 'MHPID' and (peopleID = $pid or value like '$MHP_ID')")
   [ -n "$mhpid" ] && echo "MHP_ID for $Luna_ID (pid:$pid) already in DB ($MHP_ID as $mhpid)!" && continue

   echo "$Luna_ID is $pid, adding MHPID $MHP_ID"
   sql "insert into peopleEnroll (peopleID,enrollType,enrollDate, value) values ($pid,'MHPID','$MHP_Date','$MHP_ID')"  && echo "$pid $Luna_ID $MHP_ID" >> mhp_luna_added.txt
done

## create task: CannabisInterview attached to Cannabis Grant
## create tasksubsection:  tlmar_c tledu_c tlwrk_c tlpinc_c livewP_c

if ! sqlexist "select * from tasks where taskName like 'CannabisInterview'"; then
   # study, task, and link
   sql "insert into studies (studyName,grantName,PI,comments) values ('CannabisDayLab','Cannabis','ND','Portion of the Cannabis study done by the Cho (gone) and Day Lab')"
   sql "insert into tasks (taskName,taskDesc,mode) values ('CannabisInterview','IQ and SES from Day lab interview, Year 1','Questionnaire')"
   sql "insert into studiesTasks (taskName,StudyName) values ('CannabisInterview','CannabisDayLab')"

   # task sections
   sql "insert into tasksSections (taskName,subsection,description,qNum,required,qType) values 
          ('CannabisInterview','tlmar_c','marital status(1=married, 0=not married)',1,1,'bool');
        
        insert into tasksSections (taskName,subsection,description,qNum,required,qType) values 
          ('CannabisInterview','tledu_c','highest level of education in years',2,1,'numeric');

        insert into tasksSections (taskName,subsection,description,qNum,required,qType) values 
          ('CannabisInterview','tlwrk_c','work/school status(1=working/going school, 0=none)',3,1,'bool');

        insert into tasksSections (taskName,subsection,description,qNum,required,qType) values 
          ('CannabisInterview','tlpinc_c','monthly personal income in dollar',4,1,'numeric');

        insert into tasksSections (taskName,subsection,description,qNum,required,qType) values 
          ('CannabisInterview','livewP_c','live with partner(1=yes, 0=no)',5,1,'numeric');"
fi

# where to store thes sql for creating visits
[ -d sql ] && rm -r sql
mkdir sql
[ -r missing_mhpid.txt ] && rm missing_mhpid.txt

perl -nle 'chomp while chomp; s/\.000+//g;  print' < j0215.dat|
 while read id mar edu wrk pinc livewp; do
   piddage=($(sql "
    select p.peopleid,enrollDate,datediff(enrollDate,DOB)/365.25 as age 
      from peopleEnroll as pe join people as p 
      on p.peopleid=pe.peopleid  
      where enrollType like 'MHPID' and value = $id"|sed 1q) )

   pid=${piddage[0]}
   d=${piddage[1]}
   age=${piddage[2]}


   [ -z "$pid" ] && echo "no mhpid $id in db!" | tee missing_mhpid.txt && continue

   # skip if we've done this before
   sqlexist "select visitid from visits where peopleid = $pid and age = $age and location like 'Day lab'" && 
     echo "already recorded day lab ($RES) $pid: $id $d $age" && 
     continue

   # visit is for a CannabisDayLab study
   echo "creating sql/$id.sql for $pid ($id): $mar,$edu,$wrk,$pinc,$livewp | $d: $age"
   cat > sql/$id.sql <<HEREDOC

   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    ($pid,  '$d','Behavioral',$age,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        ($pid,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   ($pid    ,@vid   ,'CannabisInterview','tlmar_c',$mar);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   ($pid    ,@vid   ,'CannabisInterview','tledu_c',$edu);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   ($pid    ,@vid   ,'CannabisInterview','tlwrk_c',$wrk);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   ($pid    ,@vid   ,'CannabisInterview','tlpinc_c',$pinc);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    ($pid    ,@vid   ,'CannabisInterview','livewP_c',$livewp);
HEREDOC
done 

mysql -h arnold.wpic.upmc.edu -ulocaladmin -p'local!123' lncddb3 < <(cat sql/*)

# undo above like:
# select visitid from visits where location like 'Day lab';
# delete from visitsStudies where visitid in (4790,4791,4792,4793);
# delete from visitsTasks  where visitid in (4790,4791,4792,4793);
# delete from visits where visitid in (4790,4791,4792,4793);
