
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (133,  '2012-11-14','Behavioral',27.7755,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (133,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (133    ,@vid   ,'CannabisInterview','tlmar_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (133    ,@vid   ,'CannabisInterview','tledu_c',16);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (133    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (133    ,@vid   ,'CannabisInterview','tlpinc_c',1800);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (133    ,@vid   ,'CannabisInterview','livewP_c',1);
