library(dplyr)
library(tidyr)
library(ggvis)
library(DBI)


# connect to SQL server
con <- dbConnect(RMySQL::MySQL(),host='arnold.wpic.upmc.edu', 'lncddb3_test','lncd','B@ngal0re')


################ 
# 0. get list of subjects
################ 

subjlist <-read.table('aggsubjinfo.csv',header=T,sep=",")

# comma sep list of all lunas
lunalist <- paste(collapse=",",unique(subjlist$LunaID));

################ 
# 1. what tasks should we take
################ 

# first query for all data we have on subjects

query <- sprintf(
'select 

  pe.value as LunaID, age as visitAge, taskName, subsection, vt.value 

 from peopleEnroll as pe 
 join visits       as v   on v.peopleid = pe.peopleid 
 join visitsTasks  as vt  on vt.visitid = v.visitid 
 where
   pe.value in (%s)', lunalist )

dt<-dbGetQuery(con,query)

# count number of subjects that have done each task
numTasks <- dt %>% 
            group_by(taskName,LunaID) %>% 
            tally() %>% group_by(taskName) %>% 
            summarize(subj.cnt=n(),totresps=sum(n)) %>% 
            arrange(desc(subj.cnt))

print.data.frame(numTasks)
write.table(numTasks,file='SurveysCounts.csv',sep=",",row.names=F)


################ 
# 2. what subsections of chosen tasks
################ 
# for task description, see old table desc 
#  http://arnold.wpic.upmc.edu/dokuwiki/doku.php?id=database:database
 
## could do this we sql
#  but we already have it in mem. as a dataframe, so use that
##
# query2<-paste(sep=" and ",query, '
#    (
#     taskName in ("YSR","Puberty", "ASR", "DERS","DrugUse","NEOFFI","RPI", "SensationSeeking" ) 
#     or subsection in ("wfull2_t","wfull4_t","wfull2") 
#    )
# ')
# dt<-dbGetQuery(con,query2)
##

# subset dataframe to just taks we are interseted in
dt.f <- dt %>% 
  filter(taskName %in% 
           c("YSR","ASR","Puberty","DrugHistory",
             "BarrattImpulsiveness","SensationSeeking","WASI")
  )


# see what lunas are missing data
noQuestLunas <- setdiff(subjlist$LunaID,unique(dt.f$LunaID))
cat("no data for lunas:", noQuestLunas,"!\n")

# merge query and original list
# get one value for each subjsection that is closest to the scanAge
dtm <- merge(subjlist,dt.f,by='LunaID',all=T)

# check again
#noQuestLunas <- dtm %>% filter(is.na(visitAge)) %>% select(LunaID)

# tidy up the merged data a bit
dt.m <- dtm %>%
          mutate(agediff=abs(scanage-visitAge))%>% 
          mutate(subsr=gsub('^ysr|^asr','*sr',subsection)) %>%  # merge ysr and asr
          group_by(LunaID,taskName,subsection) %>%   # look at each subj's subsection
          filter(subsection!='completed')      %>%   # remove 'completed' rows
          filter(subsection!='scorePath')      %>%   # remove row with filesystem path info
          filter(min_rank(agediff)==1)               # take the subsection closest to scan age

write.table(dt.m,file='LunaAllSurveys.csv',sep=",",row.names=F)

## see how many of what exists
# plot histogram of # subjects responded to each subsection, color by task
subsectally <- dt.m %>% group_by(taskName,subsr) %>% tally(sort=T)

# plot subsec tailly 
p <- subsectally %>%
   ggvis(~subsr,~n,fill = ~taskName) %>% 
   layer_bars() %>% 
   add_axis("x",
        properties=axis_props(
           labels=list(angle=75,align="left")
       ))

print(p)


# export requires vega, and is broke anyway
#  sudo npm config set python python2.7
#  sudo npm -g install vega
#export_png(p,'avalQuests.png')



################ 
# 3. select subsections, format data for export
################ 
## ASR vs YSR
# ASR ONLY
# asrtmeanadapt  
# asrtperstrength   
# asrtintrusive  
# asrtcriticalitems 
# asrttobaccotime   
# asrtalcohol 
# asrtdrugs   
# asrtmeansubstuse  
# asrtavoidpersprob 
# SHARE
# asrtanxdep  ysrtanxdep
# asrtthoprob ysrtthoprob
# asrtattprob ysrtattprob
# asrtaggbehav   ysrtaggbehav
# asrtrulebreak  ysrtrulebreak
# asrtinternal   ysrtinternal
# asrtexternal   ysrtexternal
# asrttotalprob  ysrttotalprob
# asrtanxprob ysrtanxprob
# asrtsomprob ysrtsomprob
# asrtadhprob ysrtadhprob
# asrtsomcomp ysrtsomcomp
# RENAME
# asrtantisocprob   ysrtoppdefprob
# asrtdepprob ysrtaffprob
# asrtwithdrawn  ysrtwithdep

# * wfull2 is part of wfull4 -- not everyone did all 4 
#     Jen: wfull2 and wfull4 are the iq scores- wfull2/4_t are the sums of t scores used to calculate iq
# * withdrawn is withDep in kids (A/YSR)
# * using 'tsr' as final pub. metric
# * ditching all of Barrat
dt.selected <- dt.m %>% 
            ungroup %>%
            # grab only what we want
            #filter( subsr %in% 
            #          c('wfull2','*srTInternal','*srTExternal','*srTAnxDep',
            #            '*srTAnxProb','*srTWithDep','*srTWithdrawn','*srTThoProb',
            #            '*srTAttProb','*srTAggBehav','tsr', 'sssTOT') 
            # ) %>%
            filter(subsr %in% c('wfull2','wfull4','tsr','sssTOT') | taskName %in% c('ASR','YSR') ) %>%

            # remove task differences
            mutate(taskName=gsub('^YSR|^ASR','*SR',taskName)) %>%  # merge ysr and asr for good
            mutate(subsection=gsub('^ysr|^asr','sr',subsection)) %>%  

            # rename ysr to asr fields
            mutate(subsection=gsub('srTOppDefProb','srTAntiSocProb',subsection))  %>%
            mutate(subsection=gsub('srTWithDep'   ,'srTWithdrawn',subsection))  %>%
            mutate(subsection=gsub('srTAffProb'   ,'srTDepProb',subsection))  %>%

            # task and section together
            unite(task.sub,taskName,subsr)

# take the subsection closest to scan age (min_rank again b/c some have YSR+ASR)
dt.sr       <- dt.selected      %>%
             group_by(LunaID,task.sub) %>%
             filter(min_rank(agediff)==1)                      

# spread out the data so rows no longer have variables
dt.tabular  <- dt.sr %>%
             ungroup %>%
             select(-subsection,-visitAge,-agediff) %>% 
             spread(task.sub,value)

names(dt.tabular) <- gsub('\\*','',names(dt.tabular))

write.table(dt.tabular,file='LunaSelectSurvey.csv',sep=",",row.names=F,quote=F)

#######
# 4.  show missing
#######
nna <- function(x){sum(is.na(x))}
print(t( dt.tabular %>% summarise_each(funs(nna), 4:ncol(dt.tabular)) ))

## Histogram plot of subject responses per task subsection
p2 <- dt.sr %>% 
      separate(task.sub,c('task','sub'),sep="_") %>% 
      ggvis(~sub,fill=~task) %>% 
      layer_bars() %>%
      add_axis("x",
        properties=axis_props(
           labels=list(angle=45,align="left")
       ))
      #add_axis("x",orient="top",ticks=0,title="Subjects per question")
print(p2)

# merge Withdrawn+Depression(youth) and Withdrawn(adult)
# b/c this is time point 1, use the youth if it's there -- otherwise use adult
#     this is not a good way to do it (what if came in first for another study)
#     better way is to merge earlier when we still have agediff (visit vs scan) to pick the best one
dt.tt <- dt.tabular %>% 
         mutate(withdraw=ifelse(!is.na(SR_srTWithDep),SR_srTWithDep,SR_srTWithdrawn)) %>% 
         select(-SR_srTWithDep,-SR_srTWithdrawn)

# ugly way to collect whats missing for each subject
# n is number of things missing
# m is list of those things (comma sep)
whatsmissing <- as.data.frame(t(sapply(
              FUN=function(i){
                mis<-is.na(dt.tt[i,]);
                c(unlist(dt.tt[i,1]),
                  n=sum(mis), 
                  m=paste(collapse=",",names(dt.tt)[mis])
                )   
               },
               1:nrow(dt.tt) 
            )))
write.table(whatsmissing,row.names=F, file="missing.txt",sep="\t",quote=F)



########################################################
## knowing what we know now, we can grab the values we want right from sql
########################################################

cumlquery <- "
select pe.value as LunaID, age, taskName, subsection, vt.value
 from visitsTasks as vt 
 join visits as v on vt.visitid=v.visitid
 join peopleEnroll as pe on v.peopleid=pe.peopleid
 where
   pe.enrollType like 'LunaID' and
   subsection in (
    'tsr','sssTOT','wfull2',
    'ysrTAggBehav','asrTAggBehav',
    'ysrTInternal','asrTInternal',
    'ysrTAnxDep','asrTAnxDep',
    'ysrTThoProb','asrTThoProb',
    'ysrTAnxProb','asrTAnxProb',
    'ysrTWithDep','asrTWithdrawn',
    'ysrTAttProb','asrTAttProb')
    "

db.res <- dbGetQuery(con,cumlquery)

# merge results with provided list
db.mrg <- merge(db.res,subjlist) %>% 
     mutate(agediff=round(age-scanage,2)) %>%
     mutate(taskName=gsub('^YSR|^ASR','SR',taskName)) %>%  # merge ysr and asr for good
     mutate(subsection=gsub('^ysr|^asr','sr',subsection)) %>%  
     mutate(subsection=gsub('srTWithDep','srTWithdrawn',subsection)) 

# select values closest to scan date, spread into wide format
# for aduit, provide agediff
dt.tab.age <-db.mrg %>% 
     unite(tasksec,c(taskName,subsection)) %>%
     group_by(LunaID,tasksec) %>%
     filter(min_rank(abs(agediff))==1) %>%
     ungroup %>%
     select(-age) %>% 
     unite(ageval,c(value,agediff), sep=' ') %>% 
     spread(tasksec,ageval)

write.csv(dt.tab.age,file="LunaSelectSurveyWithAgeDiff.csv",row.names=F,quote=F)


# to extract only value (or only age) from 'value age' pairing in dt.tab.age:
nthword <- function(x,n=1) { strsplit(x,' ')[[1]][n] }

# undo age part, here for ref
dt.tab.age %>%
  group_by(LunaID,scanage,group) %>%
  summarise_each(funs(nthword))

########
## look at difference between ages of survey responses and scan
########

# get only ages
dt.ages <- dt.tab.age %>%
  group_by(LunaID,scanage,group) %>%
  summarise_each(funs(as.numeric(nthword(.,n=2)))) 

# plot age by group by task
ageplot <- dt.ages %>%
    gather(section,timesincescan,-LunaID,-scanage,-group,na.rm=T) %>% 
    ggvis(~timesincescan,~section) %>% 
    layer_points(fill=~group,opacity:=.2)
print(ageplot)

# summary stats on age
dt.ages %>% 
  gather(section,agediff,-LunaID,-scanage,-group,na.rm=T) %>% 
  group_by(section,group) %>% 
  summarise(mu=mean(agediff),low=min(agediff),high=max(agediff),n=n() )
