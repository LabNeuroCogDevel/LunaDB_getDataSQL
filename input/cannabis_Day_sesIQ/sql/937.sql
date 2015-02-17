
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (177,  '2012-12-07','Behavioral',27.7755,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (177,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (177    ,@vid   ,'CannabisInterview','tlmar_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (177    ,@vid   ,'CannabisInterview','tledu_c',16);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (177    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (177    ,@vid   ,'CannabisInterview','tlpinc_c',99999);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (177    ,@vid   ,'CannabisInterview','livewP_c',0);