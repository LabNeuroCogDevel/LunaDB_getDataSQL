
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (317,  '2013-05-06','Behavioral',29.3443,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (317,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (317    ,@vid   ,'CannabisInterview','tlmar_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (317    ,@vid   ,'CannabisInterview','tledu_c',16);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (317    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (317    ,@vid   ,'CannabisInterview','tlpinc_c',2000);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (317    ,@vid   ,'CannabisInterview','livewP_c',0);
