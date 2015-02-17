
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (902,  '2013-03-14','Behavioral',28.5503,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (902,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (902    ,@vid   ,'CannabisInterview','tlmar_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (902    ,@vid   ,'CannabisInterview','tledu_c',16);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (902    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (902    ,@vid   ,'CannabisInterview','tlpinc_c',4750);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (902    ,@vid   ,'CannabisInterview','livewP_c',1);
