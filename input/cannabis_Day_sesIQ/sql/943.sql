
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (254,  '2012-10-10','Behavioral',27.6496,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (254,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (254    ,@vid   ,'CannabisInterview','tlmar_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (254    ,@vid   ,'CannabisInterview','tledu_c',14);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (254    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (254    ,@vid   ,'CannabisInterview','tlpinc_c',2000);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (254    ,@vid   ,'CannabisInterview','livewP_c',0);
