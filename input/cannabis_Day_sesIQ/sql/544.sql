
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (557,  '2013-09-23','Behavioral',29.2512,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (557,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (557    ,@vid   ,'CannabisInterview','tlmar_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (557    ,@vid   ,'CannabisInterview','tledu_c',14);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (557    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (557    ,@vid   ,'CannabisInterview','tlpinc_c',1856);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (557    ,@vid   ,'CannabisInterview','livewP_c',0);
