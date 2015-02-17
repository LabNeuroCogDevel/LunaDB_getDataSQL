
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (242,  '2012-09-25','Behavioral',27.9918,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (242,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (242    ,@vid   ,'CannabisInterview','tlmar_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (242    ,@vid   ,'CannabisInterview','tledu_c',16);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (242    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (242    ,@vid   ,'CannabisInterview','tlpinc_c',550);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (242    ,@vid   ,'CannabisInterview','livewP_c',0);
