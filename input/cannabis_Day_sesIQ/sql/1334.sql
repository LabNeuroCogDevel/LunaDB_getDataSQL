
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (245,  '2013-07-26','Behavioral',27.7892,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (245,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (245    ,@vid   ,'CannabisInterview','tlmar_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (245    ,@vid   ,'CannabisInterview','tledu_c',13);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (245    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (245    ,@vid   ,'CannabisInterview','tlpinc_c',1100);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (245    ,@vid   ,'CannabisInterview','livewP_c',0);
