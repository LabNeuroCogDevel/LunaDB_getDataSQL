
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (310,  '2013-09-17','Behavioral',29.4073,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (310,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (310    ,@vid   ,'CannabisInterview','tlmar_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (310    ,@vid   ,'CannabisInterview','tledu_c',16);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (310    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (310    ,@vid   ,'CannabisInterview','tlpinc_c',800);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (310    ,@vid   ,'CannabisInterview','livewP_c',1);
