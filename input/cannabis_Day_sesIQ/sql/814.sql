
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (247,  '2012-10-09','Behavioral',27.6988,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (247,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (247    ,@vid   ,'CannabisInterview','tlmar_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (247    ,@vid   ,'CannabisInterview','tledu_c',12);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (247    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (247    ,@vid   ,'CannabisInterview','tlpinc_c',600);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (247    ,@vid   ,'CannabisInterview','livewP_c',1);
