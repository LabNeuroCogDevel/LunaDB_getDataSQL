
   -- create visit 
   insert into visits (peopleID, visitdate,visitType,age,location) values
                    (166,  '2013-07-16','Behavioral',29.5414,'Day lab');
   SET @vid = last_insert_id();

   -- set visit as CannabisDayLab
   insert into visitsStudies 
        (peopleID,visitID,studyName,cohort) values
        (166,@vid,'CannabisDayLab','Contorl');

   -- visit has these attributes
   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (166    ,@vid   ,'CannabisInterview','tlmar_c',0);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (166    ,@vid   ,'CannabisInterview','tledu_c',12);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (166    ,@vid   ,'CannabisInterview','tlwrk_c',1);

   insert into visitsTasks
   (peopleID,visitID,taskName,subsection,value) values
   (166    ,@vid   ,'CannabisInterview','tlpinc_c',2200);

   insert into visitsTasks
    (peopleID,visitID,taskName,subsection,value) values
    (166    ,@vid   ,'CannabisInterview','livewP_c',1);
