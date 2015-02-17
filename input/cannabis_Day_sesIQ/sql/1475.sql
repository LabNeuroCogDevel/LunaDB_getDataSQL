
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (132,  '2013-06-13','Behavioral',27.5044,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (132,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (132    ,@vid   ,'CannabisInterview','tlmar_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (132    ,@vid   ,'CannabisInterview','tledu_c',12);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (132    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (132    ,@vid   ,'CannabisInterview','tlpinc_c',1650);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (132    ,@vid   ,'CannabisInterview','livewP_c',0);
