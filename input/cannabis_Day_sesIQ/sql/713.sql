
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (155,  '2012-11-09','Behavioral',28.1287,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (155,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (155    ,@vid   ,'CannabisInterview','tlmar_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (155    ,@vid   ,'CannabisInterview','tledu_c',14);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (155    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (155    ,@vid   ,'CannabisInterview','tlpinc_c',1700);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (155    ,@vid   ,'CannabisInterview','livewP_c',0);
