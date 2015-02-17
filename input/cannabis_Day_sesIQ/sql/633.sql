
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (834,  '2013-09-25','Behavioral',29.0048,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (834,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (834    ,@vid   ,'CannabisInterview','tlmar_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (834    ,@vid   ,'CannabisInterview','tledu_c',16);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (834    ,@vid   ,'CannabisInterview','tlwrk_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (834    ,@vid   ,'CannabisInterview','tlpinc_c',0);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (834    ,@vid   ,'CannabisInterview','livewP_c',1);
