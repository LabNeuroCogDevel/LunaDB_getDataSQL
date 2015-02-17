
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (211,  '2012-12-03','Behavioral',27.7591,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (211,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (211    ,@vid   ,'CannabisInterview','tlmar_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (211    ,@vid   ,'CannabisInterview','tledu_c',14);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (211    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (211    ,@vid   ,'CannabisInterview','tlpinc_c',1100);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (211    ,@vid   ,'CannabisInterview','livewP_c',0);
