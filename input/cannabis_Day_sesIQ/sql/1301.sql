
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (253,  '2013-04-03','Behavioral',27.5784,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (253,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (253    ,@vid   ,'CannabisInterview','tlmar_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (253    ,@vid   ,'CannabisInterview','tledu_c',14);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (253    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (253    ,@vid   ,'CannabisInterview','tlpinc_c',1300);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (253    ,@vid   ,'CannabisInterview','livewP_c',1);
