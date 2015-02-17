
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (305,  '2013-04-24','Behavioral',27.4360,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (305,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (305    ,@vid   ,'CannabisInterview','tlmar_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (305    ,@vid   ,'CannabisInterview','tledu_c',13);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (305    ,@vid   ,'CannabisInterview','tlwrk_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (305    ,@vid   ,'CannabisInterview','tlpinc_c',316);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (305    ,@vid   ,'CannabisInterview','livewP_c',0);
