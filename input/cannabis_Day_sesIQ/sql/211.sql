
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (341,  '2012-11-07','Behavioral',28.7830,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (341,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (341    ,@vid   ,'CannabisInterview','tlmar_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (341    ,@vid   ,'CannabisInterview','tledu_c',14);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (341    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (341    ,@vid   ,'CannabisInterview','tlpinc_c',1200);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (341    ,@vid   ,'CannabisInterview','livewP_c',0);
