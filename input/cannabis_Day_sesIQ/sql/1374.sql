
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (52,  '2012-09-21','Behavioral',26.8884,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (52,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (52    ,@vid   ,'CannabisInterview','tlmar_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (52    ,@vid   ,'CannabisInterview','tledu_c',13);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (52    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (52    ,@vid   ,'CannabisInterview','tlpinc_c',4000);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (52    ,@vid   ,'CannabisInterview','livewP_c',0);
