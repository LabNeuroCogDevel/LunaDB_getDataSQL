
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (157,  '2012-11-13','Behavioral',28.3778,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (157,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (157    ,@vid   ,'CannabisInterview','tlmar_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (157    ,@vid   ,'CannabisInterview','tledu_c',14);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (157    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (157    ,@vid   ,'CannabisInterview','tlpinc_c',700);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (157    ,@vid   ,'CannabisInterview','livewP_c',1);
