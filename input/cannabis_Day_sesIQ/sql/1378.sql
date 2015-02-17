
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (128,  '2013-06-19','Behavioral',27.5811,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (128,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (128    ,@vid   ,'CannabisInterview','tlmar_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (128    ,@vid   ,'CannabisInterview','tledu_c',15);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (128    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (128    ,@vid   ,'CannabisInterview','tlpinc_c',5400);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (128    ,@vid   ,'CannabisInterview','livewP_c',0);
