
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (278,  '2012-12-03','Behavioral',28.2218,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (278,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (278    ,@vid   ,'CannabisInterview','tlmar_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (278    ,@vid   ,'CannabisInterview','tledu_c',10);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (278    ,@vid   ,'CannabisInterview','tlwrk_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (278    ,@vid   ,'CannabisInterview','tlpinc_c',0);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (278    ,@vid   ,'CannabisInterview','livewP_c',1);
