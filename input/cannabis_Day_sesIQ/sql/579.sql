
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (154,  '2013-04-18','Behavioral',28.6215,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (154,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (154    ,@vid   ,'CannabisInterview','tlmar_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (154    ,@vid   ,'CannabisInterview','tledu_c',12);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (154    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (154    ,@vid   ,'CannabisInterview','tlpinc_c',1400);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (154    ,@vid   ,'CannabisInterview','livewP_c',0);
