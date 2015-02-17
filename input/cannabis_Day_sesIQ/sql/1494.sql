
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (1165,  '2014-02-04','Behavioral',28.1643,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (1165,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (1165    ,@vid   ,'CannabisInterview','tlmar_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (1165    ,@vid   ,'CannabisInterview','tledu_c',18);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (1165    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (1165    ,@vid   ,'CannabisInterview','tlpinc_c',2500);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (1165    ,@vid   ,'CannabisInterview','livewP_c',0);
