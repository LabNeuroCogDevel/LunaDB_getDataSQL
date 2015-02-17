
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (282,  '2012-10-15','Behavioral',27.9261,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (282,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (282    ,@vid   ,'CannabisInterview','tlmar_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (282    ,@vid   ,'CannabisInterview','tledu_c',12);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (282    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (282    ,@vid   ,'CannabisInterview','tlpinc_c',1400);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (282    ,@vid   ,'CannabisInterview','livewP_c',0);
