
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (78,  '2012-11-27','Behavioral',28.1944,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (78,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (78    ,@vid   ,'CannabisInterview','tlmar_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (78    ,@vid   ,'CannabisInterview','tledu_c',15);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (78    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (78    ,@vid   ,'CannabisInterview','tlpinc_c',1600);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (78    ,@vid   ,'CannabisInterview','livewP_c',0);
