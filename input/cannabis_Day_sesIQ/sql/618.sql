
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (98,  '2013-07-03','Behavioral',28.7584,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (98,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (98    ,@vid   ,'CannabisInterview','tlmar_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (98    ,@vid   ,'CannabisInterview','tledu_c',12);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (98    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (98    ,@vid   ,'CannabisInterview','tlpinc_c',4500);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (98    ,@vid   ,'CannabisInterview','livewP_c',0);
