
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (125,  '2013-01-09','Behavioral',27.4743,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (125,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (125    ,@vid   ,'CannabisInterview','tlmar_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (125    ,@vid   ,'CannabisInterview','tledu_c',12);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (125    ,@vid   ,'CannabisInterview','tlwrk_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (125    ,@vid   ,'CannabisInterview','tlpinc_c',0);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (125    ,@vid   ,'CannabisInterview','livewP_c',0);
