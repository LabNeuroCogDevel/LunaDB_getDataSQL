
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (193,  '2012-09-20','Behavioral',27.5127,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (193,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (193    ,@vid   ,'CannabisInterview','tlmar_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (193    ,@vid   ,'CannabisInterview','tledu_c',18);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (193    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (193    ,@vid   ,'CannabisInterview','tlpinc_c',2800);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (193    ,@vid   ,'CannabisInterview','livewP_c',1);
