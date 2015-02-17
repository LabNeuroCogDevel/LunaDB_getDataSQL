
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (114,  '2012-09-24','Behavioral',27.5236,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (114,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (114    ,@vid   ,'CannabisInterview','tlmar_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (114    ,@vid   ,'CannabisInterview','tledu_c',13);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (114    ,@vid   ,'CannabisInterview','tlwrk_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (114    ,@vid   ,'CannabisInterview','tlpinc_c',364);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (114    ,@vid   ,'CannabisInterview','livewP_c',0);
