
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (196,  '2013-06-07','Behavioral',27.6194,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (196,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (196    ,@vid   ,'CannabisInterview','tlmar_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (196    ,@vid   ,'CannabisInterview','tledu_c',16);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (196    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (196    ,@vid   ,'CannabisInterview','tlpinc_c',2100);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (196    ,@vid   ,'CannabisInterview','livewP_c',0);
