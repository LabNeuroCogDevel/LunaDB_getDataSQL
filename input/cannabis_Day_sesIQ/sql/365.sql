
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (205,  '2012-10-02','Behavioral',28.5092,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (205,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (205    ,@vid   ,'CannabisInterview','tlmar_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (205    ,@vid   ,'CannabisInterview','tledu_c',12);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (205    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (205    ,@vid   ,'CannabisInterview','tlpinc_c',3000);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (205    ,@vid   ,'CannabisInterview','livewP_c',0);
