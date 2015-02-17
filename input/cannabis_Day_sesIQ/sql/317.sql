
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (320,  '2013-07-10','Behavioral',29.0951,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (320,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (320    ,@vid   ,'CannabisInterview','tlmar_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (320    ,@vid   ,'CannabisInterview','tledu_c',13);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (320    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (320    ,@vid   ,'CannabisInterview','tlpinc_c',3000);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (320    ,@vid   ,'CannabisInterview','livewP_c',1);
