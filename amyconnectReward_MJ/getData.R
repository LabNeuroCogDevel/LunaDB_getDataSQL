library(dplyr)
library(tidyr)
library(ggvis)
library(RMySQL)

lunas <- read.table('lunas.txt',sep="_")
names(lunas)<-c('LunaID','dateOfScan')
lunas$dateOfScan <-  as.Date(as.character(lunas$dateOfScan),format="%Y%m%d")

# SQL code to get all the suvery data we are interested in
cumlquery <- "
select pe.value as LunaID,DOB, age as surveyage, taskName, subsection, vt.value
 from visitsTasks as vt 
 join visits as v on vt.visitid=v.visitid
 join peopleEnroll as pe on v.peopleid=pe.peopleid
 join people as p on pe.peopleid=p.peopleid
 where
   pe.enrollType like 'LunaID' and
   (
     subsection in (
      'wfull2', 'wfull4',
      'bdiTOTAL',
      'Tanner1hair','Tanner2TSP_orBreast','pps1to5', 
      'sssTOT', 'sssDIS','sssBS','sssTOT','sssES','sssTAS',
      'cbclTAffProb', 'cbclTInternal', 'cbclTWithDep', 'cbclTAnxProb', 'cbclTAnxDep',
      'cdiTOTAL', 'cdiT', 'cdiB', 'cdiA', 'cdiE', 'cdiC', 'cdiD' 
     ) 
     or 
      vt.taskName in ('YSR','ASR')
    )
    "

# connect to SQL server
con <- dbConnect(RMySQL::MySQL(),host='arnold.wpic.upmc.edu', 'lncddb3_test','lncd','B@ngal0re')
# and get query results
db.res <- dbGetQuery(con,cumlquery)

# merge results with provided list
db.mrg <- merge(db.res,lunas)
df.full <- db.mrg %>% mutate(scanage=as.vector(difftime(dateOfScan,DOB,units="days")/365.25)) %>% select(-DOB) 

# rename ysr/asr so we only get one metric closest to the scan
df.sr <- df.full %>% mutate(agediff=round(surveyage-scanage,3)) %>%
     mutate(taskName=gsub('^YSR|^ASR','SR',taskName)) %>%  # merge ysr and asr for good
     mutate(subsection=gsub('^ysr|^asr','sr',subsection)) %>%  
     # rename ysr to asr fields
     mutate(subsection=gsub('srTOppDefProb','srTAntiSocProb',subsection))  %>%
     mutate(subsection=gsub('srTWithDep'   ,'srTWithdrawn',subsection))  %>%
     mutate(subsection=gsub('srTAffProb'   ,'srTDepProb',subsection))  


# save this giant thing with all the values
write.csv(df.sr,file="LunaSelectSurvey_AllValues.csv",row.names=F,quote=F)

# select values closest to scan date, spread into wide format
# for aduit, provide agediff
dt.tab.age.long <-df.sr %>% 
     unite(tasksec,c(taskName,subsection)) %>%
     group_by(LunaID,dateOfScan,tasksec) %>%
     filter(min_rank(abs(agediff))==1) %>%
     ungroup %>%
     select(-surveyage) %>% 
     unite(ageval,c(value,agediff), sep=' ') %>%
     filter(!grepl('scorePath|complete',tasksec,perl=T))
dt.tab.age <- dt.tab.age.long %>% spread(tasksec,ageval)

write.csv(dt.tab.age,file="LunaSelectSurvey_WithAgeDiff.csv",row.names=F,quote=F)


# to extract only value (or only age) from 'value age' pairing in dt.tab.age:
nthword <- function(x,n=1) { strsplit(x,' ')[[1]][n] }

# undo age part, here for ref
dt.tab.age %>%
  group_by(LunaID,scanage,dateOfScan) %>%
  summarise_each(funs(nthword)) %>% 
  write.csv(file="LunaSelectSurvey.csv",row.names=F,quote=F)

########
## look at difference between ages of survey responses and scan
########

# get only ages
dt.ages <- dt.tab.age %>%
  group_by(LunaID,scanage,dateOfScan) %>%
  summarise_each(funs(as.numeric(nthword(.,n=2))))  

write.csv(dt.ages,file="LunaSelectSurvey_MinAgeDiffOnly.csv",row.names=F,quote=F)
# plot age by group by task
dt.ageplot <- dt.ages %>% 
    mutate(group=cut(scanage,breaks=c(0,13,18,99))) %>% select(-dateOfScan) %>%
    gather(section,timesincescan,-group,-LunaID,-scanage,na.rm=T)

ageplot <- dt.ageplot %>%
    ggvis(~timesincescan,~section) %>% 
    layer_points(fill=~group,opacity:=.2)
print(ageplot)

# summary stats on age
dt.ages %>% 
  mutate(group=cut(scanage,breaks=c(0,13,18,99))) %>% select(-dateOfScan) %>%
  gather(section,agediff,-LunaID,-scanage,-group,na.rm=T) %>% 
  group_by(section,group) %>% 
  summarise(mu=mean(agediff),low=min(agediff),high=max(agediff),n=n() )
