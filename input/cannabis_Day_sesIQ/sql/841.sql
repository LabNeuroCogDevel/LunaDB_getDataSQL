
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (225,  '2012-11-07','Behavioral',27.8960,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (225,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (225    ,@vid   ,'CannabisInterview','tlmar_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (225    ,@vid   ,'CannabisInterview','tledu_c',16);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (225    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (225    ,@vid   ,'CannabisInterview','tlpinc_c',1650);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (225    ,@vid   ,'CannabisInterview','livewP_c',0);
