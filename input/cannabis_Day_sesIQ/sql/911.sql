
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (194,  '2012-12-04','Behavioral',27.8056,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (194,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (194    ,@vid   ,'CannabisInterview','tlmar_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (194    ,@vid   ,'CannabisInterview','tledu_c',15);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (194    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (194    ,@vid   ,'CannabisInterview','tlpinc_c',1500);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (194    ,@vid   ,'CannabisInterview','livewP_c',0);
