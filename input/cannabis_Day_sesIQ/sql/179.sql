
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (345,  '2012-11-05','Behavioral',28.8597,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (345,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (345    ,@vid   ,'CannabisInterview','tlmar_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (345    ,@vid   ,'CannabisInterview','tledu_c',16);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (345    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (345    ,@vid   ,'CannabisInterview','tlpinc_c',6300);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (345    ,@vid   ,'CannabisInterview','livewP_c',1);
