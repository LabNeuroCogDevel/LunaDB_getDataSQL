
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (346,  '2012-09-27','Behavioral',28.2190,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (346,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (346    ,@vid   ,'CannabisInterview','tlmar_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (346    ,@vid   ,'CannabisInterview','tledu_c',14);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (346    ,@vid   ,'CannabisInterview','tlwrk_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (346    ,@vid   ,'CannabisInterview','tlpinc_c',0);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (346    ,@vid   ,'CannabisInterview','livewP_c',1);
