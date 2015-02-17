
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (208,  '2012-10-19','Behavioral',26.9487,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (208,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (208    ,@vid   ,'CannabisInterview','tlmar_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (208    ,@vid   ,'CannabisInterview','tledu_c',18);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (208    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (208    ,@vid   ,'CannabisInterview','tlpinc_c',3300);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (208    ,@vid   ,'CannabisInterview','livewP_c',1);
