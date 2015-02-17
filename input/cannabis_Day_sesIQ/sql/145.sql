
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (217,  '2013-03-27','Behavioral',29.2402,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (217,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (217    ,@vid   ,'CannabisInterview','tlmar_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (217    ,@vid   ,'CannabisInterview','tledu_c',14);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (217    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (217    ,@vid   ,'CannabisInterview','tlpinc_c',1600);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (217    ,@vid   ,'CannabisInterview','livewP_c',1);
