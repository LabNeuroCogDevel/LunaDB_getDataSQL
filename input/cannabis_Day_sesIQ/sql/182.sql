
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (285,  '2012-10-30','Behavioral',28.8405,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (285,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (285    ,@vid   ,'CannabisInterview','tlmar_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (285    ,@vid   ,'CannabisInterview','tledu_c',13);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (285    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (285    ,@vid   ,'CannabisInterview','tlpinc_c',2400);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (285    ,@vid   ,'CannabisInterview','livewP_c',1);
