
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (272,  '2012-11-16','Behavioral',27.6468,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (272,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (272    ,@vid   ,'CannabisInterview','tlmar_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (272    ,@vid   ,'CannabisInterview','tledu_c',13);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (272    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (272    ,@vid   ,'CannabisInterview','tlpinc_c',900);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (272    ,@vid   ,'CannabisInterview','livewP_c',1);
