
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (79,  '2013-06-11','Behavioral',27.7864,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (79,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (79    ,@vid   ,'CannabisInterview','tlmar_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (79    ,@vid   ,'CannabisInterview','tledu_c',14);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (79    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (79    ,@vid   ,'CannabisInterview','tlpinc_c',1700);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (79    ,@vid   ,'CannabisInterview','livewP_c',1);
