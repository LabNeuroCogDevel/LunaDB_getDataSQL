
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (106,  '2013-06-18','Behavioral',28.1916,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (106,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (106    ,@vid   ,'CannabisInterview','tlmar_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (106    ,@vid   ,'CannabisInterview','tledu_c',18);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (106    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (106    ,@vid   ,'CannabisInterview','tlpinc_c',4000);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (106    ,@vid   ,'CannabisInterview','livewP_c',1);
