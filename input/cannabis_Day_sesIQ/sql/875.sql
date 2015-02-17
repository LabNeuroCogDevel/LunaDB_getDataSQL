
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (81,  '2012-10-20','Behavioral',27.5619,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (81,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (81    ,@vid   ,'CannabisInterview','tlmar_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (81    ,@vid   ,'CannabisInterview','tledu_c',12);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (81    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (81    ,@vid   ,'CannabisInterview','tlpinc_c',4600);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (81    ,@vid   ,'CannabisInterview','livewP_c',1);
