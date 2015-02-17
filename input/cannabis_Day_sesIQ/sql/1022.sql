
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (663,  '2014-01-17','Behavioral',28.7912,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (663,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (663    ,@vid   ,'CannabisInterview','tlmar_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (663    ,@vid   ,'CannabisInterview','tledu_c',12);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (663    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (663    ,@vid   ,'CannabisInterview','tlpinc_c',3000);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (663    ,@vid   ,'CannabisInterview','livewP_c',0);
