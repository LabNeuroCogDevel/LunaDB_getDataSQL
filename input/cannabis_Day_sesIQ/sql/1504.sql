
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (257,  '2013-01-04','Behavioral',27.0856,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (257,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (257    ,@vid   ,'CannabisInterview','tlmar_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (257    ,@vid   ,'CannabisInterview','tledu_c',18);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (257    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (257    ,@vid   ,'CannabisInterview','tlpinc_c',1600);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (257    ,@vid   ,'CannabisInterview','livewP_c',0);
