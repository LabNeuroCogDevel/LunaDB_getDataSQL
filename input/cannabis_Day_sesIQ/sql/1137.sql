
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (120,  '2013-05-02','Behavioral',27.8905,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (120,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (120    ,@vid   ,'CannabisInterview','tlmar_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (120    ,@vid   ,'CannabisInterview','tledu_c',14);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (120    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (120    ,@vid   ,'CannabisInterview','tlpinc_c',650);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (120    ,@vid   ,'CannabisInterview','livewP_c',1);
