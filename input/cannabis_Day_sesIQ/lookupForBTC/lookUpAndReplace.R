library(RMySQL)
sgk <- read.table('stategrant_kids_0215.txt')
# connect to SQL server
con <- dbConnect(RMySQL::MySQL(),host='arnold.wpic.upmc.edu', 'lncddb3','lncd','B@ngal0re')
query <- 'select pel.value as LunaID, pem.value  as id
   from peopleEnroll as pem 
   join peopleEnroll as pel 
    on pem.peopleid=pel.peopleid 
   where pem.enrollType like "MHPID" and pel.enrollType like "LunaId"'
# and get query results
db.res <- dbGetQuery(con,query)

msgk <- merge(sgk,db.res)
write.table(msgk,'stategrant_kids_0215_luna.txt')
