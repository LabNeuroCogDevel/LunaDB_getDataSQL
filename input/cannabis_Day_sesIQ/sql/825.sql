
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (244,  '2012-12-10','Behavioral',27.8631,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (244,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (244    ,@vid   ,'CannabisInterview','tlmar_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (244    ,@vid   ,'CannabisInterview','tledu_c',12);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (244    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (244    ,@vid   ,'CannabisInterview','tlpinc_c',1100);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (244    ,@vid   ,'CannabisInterview','livewP_c',0);