library(dplyr)
library(tidyr)
library(ggvis)
library(RMySQL)

lunas <- read.table('lunas.txt',sep="_")
names(lunas)<-c('LunaID','dateOfScan')
lunas$dateOfScan <-  as.Date(as.character(lunas$dateOfScan),format="%Y%m%d")

# SQL code to get all the suvery data we are interested in
cumlquery <- "
select pe.value as LunaID,DOB, age as surveyage,visitdate, taskName, subsection, vt.value
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
     filter(!grepl('scorePath|complete',subsection,perl=T)) %>%
     group_by(LunaID,dateOfScan,taskName,subsection) %>%
     filter(abs(agediff)<1 ) %>%  #WF20150315 -- older stuff not useful 
     filter(min_rank(abs(agediff))==1) %>%
     ungroup %>%
     unite(ageval,c(value,agediff,visitdate), sep=' ') %>%
     select(-surveyage) 
dt.tab.age <- dt.tab.age.long %>%
              unite(tasksec,c(taskName,subsection)) %>%
              spread(tasksec,ageval) 

write.csv(dt.tab.age,file="LunaSelectSurvey_WithAgeDiff.csv",row.names=F,quote=F)


# to extract only value (or only age) from 'value age' pairing in dt.tab.age:
nthword <- function(x,n=1) { strsplit(x,' ')[[1]][n] }


##  what are the dates
# extract only the date of the picked SR
vdates <- dt.tab.age %>%
  group_by(LunaID,scanage,dateOfScan) %>%
  summarise_each(funs(nthword(.,3))) %>%
  gather(tsec,val,-LunaID,-scanage,-dateOfScan) %>%
  filter(!is.na(val)) %>%
  separate(tsec,c('task','s'),extra="merge") %>%
  group_by(LunaID,scanage,dateOfScan,task) %>%
  summarise(date=paste(unique(val),collapse=" "))  %>%
  spread(task,date) 
SRdate <- vdates %>% select(LunaID,dateOfScan,SR)
dt.SRmerg <- merge(SRdate,dt.noage) 
write.csv(dt.SRmerg,file="LunaSelectSurveySRdate.csv",row.names=F,quote=F)
dt.SRmerg %>% select(LunaID,dateOfScan,SR) %>% 
              group_by(LunaID,SR) %>%
              summarise(n=n(),dates=paste(dateOfScan,collapse=" ")) %>%
              filter(LunaID %in% c(10567,10568,10572)) %>% print
#  LunaID       SR  n                 dates
#  10567 2010-01-13 2 2009-01-14 2010-08-10
#  10568 2010-01-06 2 2009-01-12 2010-06-19
#  10572 2011-08-04 2 2011-01-12 2012-05-14
##
##
#select pe.value as luna, visitdate,taskName from visitstasks as vt
# join visits as v on v.visitID = vt.visitID
# join peopleEnroll as pe on pe.peopleID = v.peopleID
# where pe.enrollType like 'LunaID' and pe.value in (10567,10568,10572)
# group by luna,visitdate,taskName
# having taskName like 'ASR' or taskName like 'YSR'
##
#### 10567 -> 2009 has no asr
# 10567 2010-01-13  ASR
# 10567 2011-08-15  ASR

##### 10568 -> 2009 has no asr
# 10568 2010-01-06  ASR
# 10568 2011-07-05  ASR

##### 10572 -> 2012 has no as
# 10572 2008-06-10  ASR
# 10572 2010-01-11  ASR
# 10572 2011-08-04  ASR

# undo age part, here for ref
dt.noage <- dt.tab.age %>%
  group_by(LunaID,scanage,dateOfScan) %>%
  summarise_each(funs(nthword))

# remove SRs with overlapping dates
# grab by hand as "explained" above
sridx=grepl('SR_',names(dt.noage))
rowidx=function(l,d) dt.noage$LunaID==l&dt.noage$dateOfScan==d
dt.noage[rowidx(10567,'2009-01-14'), sridx] <- NA
dt.noage[rowidx(10568,'2009-01-12'), sridx] <- NA
dt.noage[rowidx(10572,'2012-05-1$'), sridx] <- NA

dt.noage %>% 
  write.csv(file="LunaSelectSurvey.csv",row.names=F,quote=F)

# do we have repeats
dt.noage %>% group_by(LunaID) %>% summarise_each(funs(length(unique(.,incomparables=NA)))) %>% group_by(LunaID,dateOfScan,scanage) %>% 
 summarise_each(funs(.-scanage))  %>% print
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

dt.tab.age %>% group_by(LunaID)
