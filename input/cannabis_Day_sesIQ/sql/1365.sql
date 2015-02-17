
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (288,  '2012-10-08','Behavioral',26.9569,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (288,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (288    ,@vid   ,'CannabisInterview','tlmar_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (288    ,@vid   ,'CannabisInterview','tledu_c',16);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (288    ,@vid   ,'CannabisInterview','tlwrk_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (288    ,@vid   ,'CannabisInterview','tlpinc_c',2000);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (288    ,@vid   ,'CannabisInterview','livewP_c',1);
