library(dplyr)
library(tidyr)
library(DBI)


# connect to SQL server
con <- dbConnect(RMySQL::MySQL(),host='arnold.wpic.upmc.edu', 'lncddb3','lncd','B@ngal0re')



# first query for all data we have on subjects

query <- "
select 
  p.peopleid, e.enrollType as IDt, e.value as ID, 
  sex,age,hand,visitdate, 
  subsection,vt.value 
 -- group_concat(vt.subsection) as ethnicity 
from visitsStudies as vs 
join visits as v on vs.visitID=v.visitID
join people as p on p.peopleID = v.peopleID
join peopleEnroll as e on p.peopleID=e.peopleID
join visitsTasks as vt on vt.visitID=v.visitID
where vs.studyName like 'Cog%'
   and visitType like 'Behavioral'
   and (e.enrollType like 'OHID' or e.enrollType like 'LunaID')
   and (   subsection like 'wfull2_t'
        or subsection like 'Black'
        or subsection like 'Asian'
        or subsection like 'White'
        or subsection like 'HawaiianPacIsl'
        or subsection like 'AmerIndianAlaskan'
        or subsection like 'Hispanic')
  -- group by(concat(v.visitid,e.enrollType,taskName))
"

dt<-dbGetQuery(con,query)

dt.wide <- dt %>% spread(IDt,ID) %>% spread(subsection,value) 

# eth<-c('AmerIndianAlaskan','Asian','Black','HawaiianPacIsl',' Hispanic','White')
# geteth <- function(x){
#   eth[!is.na(x)]
# }
#dt.wide %>% head %>%group_by(peopleid,sex,age,hand,visitdate,LunaID,OHID,wfull2_t) %>%
#   summarise_each(funs(function(x){!isna(x)}))
eths <- c('AmerIndianAlaskan','Asian','Black','HawaiianPacIsl','Hispanic','White')
for(eth in eths) {
  dt.wide[,eth] = ifelse(is.na(dt.wide[,eth]),'',eth)
}
dt.eth <- dt.wide %>% unite(eth,AmerIndianAlaskan,Asian,Black,HawaiianPacIsl,Hispanic,White) %>% 
           mutate(eth=gsub('NA_','',eth))

