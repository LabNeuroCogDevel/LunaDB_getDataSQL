library(ggplot2)
library(dplyr)
library(tidyr)
library(scales)

library(DBI)
# connect to SQL server
con <- dbConnect(RMySQL::MySQL(),host='arnold.wpic.upmc.edu', 'lncddb3','lncd','B@ngal0re')

query <- "
select 
 t.taskName,t.mode,count(*) as totalvisits,
 min(visitdate) as firstvisit, max(visitdate) as lastvisit,
 min(age) as youngets ,max(age) oldest ,avg(age) muage,
 count(distinct vs.StudyName) as totalStudies, group_concat(distinct vs.StudyName) as studies
 from visitstasks vt join visits v
   on v.visitID=vt.visitID and subsection like 'completed' and v.visitdate not like '1900-01-01'
   join tasks t on t.taskName=vt.taskName
   join visitsStudies vs on vs.visitID=v.visitID
   group by t.taskName;
"


d<-dbGetQuery(con,query)
write.table(d,file="taskBreakdown.txt",row.names=F,quote=F,sep="\t")

d2 <- gather(d,dt,visitdate,c(firstvisit,lastvisit)) %>% mutate(visitdate=as.Date(visitdate))
p <- ggplot(d2,aes(x=taskName,y=visitdate,group=taskName,color=mode,size=totalvisits))+geom_line()
date_breaks("1 year")
p + theme_bw() +theme(axis.text.x=element_text(angle=65,hjust=1))
ggsave('alltasksOvertime.pdf',p)

