
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (162,  '2013-06-27','Behavioral',28.8460,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (162,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (162    ,@vid   ,'CannabisInterview','tlmar_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (162    ,@vid   ,'CannabisInterview','tledu_c',13);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (162    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (162    ,@vid   ,'CannabisInterview','tlpinc_c',800);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (162    ,@vid   ,'CannabisInterview','livewP_c',0);
