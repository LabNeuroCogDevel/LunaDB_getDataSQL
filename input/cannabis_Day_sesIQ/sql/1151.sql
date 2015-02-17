
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (1163,  '2013-12-09','Behavioral',28.4627,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (1163,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (1163    ,@vid   ,'CannabisInterview','tlmar_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (1163    ,@vid   ,'CannabisInterview','tledu_c',14);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (1163    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (1163    ,@vid   ,'CannabisInterview','tlpinc_c',1400);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (1163    ,@vid   ,'CannabisInterview','livewP_c',0);
