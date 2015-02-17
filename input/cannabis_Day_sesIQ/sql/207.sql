
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (130,  '2012-11-05','Behavioral',28.8077,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (130,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (130    ,@vid   ,'CannabisInterview','tlmar_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (130    ,@vid   ,'CannabisInterview','tledu_c',11);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (130    ,@vid   ,'CannabisInterview','tlwrk_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (130    ,@vid   ,'CannabisInterview','tlpinc_c',0);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (130    ,@vid   ,'CannabisInterview','livewP_c',0);
