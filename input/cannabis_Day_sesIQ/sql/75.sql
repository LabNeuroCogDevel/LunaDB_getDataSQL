
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (243,  '2012-10-23','Behavioral',29.0815,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (243,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (243    ,@vid   ,'CannabisInterview','tlmar_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (243    ,@vid   ,'CannabisInterview','tledu_c',18);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (243    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (243    ,@vid   ,'CannabisInterview','tlpinc_c',4900);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (243    ,@vid   ,'CannabisInterview','livewP_c',1);
