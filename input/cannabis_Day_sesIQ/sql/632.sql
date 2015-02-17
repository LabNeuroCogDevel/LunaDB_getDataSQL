
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (997,  '2013-09-11','Behavioral',28.9254,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (997,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (997    ,@vid   ,'CannabisInterview','tlmar_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (997    ,@vid   ,'CannabisInterview','tledu_c',12);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (997    ,@vid   ,'CannabisInterview','tlwrk_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (997    ,@vid   ,'CannabisInterview','tlpinc_c',800);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (997    ,@vid   ,'CannabisInterview','livewP_c',0);
