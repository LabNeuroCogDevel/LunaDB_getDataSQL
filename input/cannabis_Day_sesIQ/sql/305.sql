
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (292,  '2012-11-14','Behavioral',28.7940,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (292,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (292    ,@vid   ,'CannabisInterview','tlmar_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (292    ,@vid   ,'CannabisInterview','tledu_c',14);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (292    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (292    ,@vid   ,'CannabisInterview','tlpinc_c',2300);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (292    ,@vid   ,'CannabisInterview','livewP_c',1);
