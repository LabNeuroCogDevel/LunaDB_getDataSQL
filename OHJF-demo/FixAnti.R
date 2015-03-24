library(dplyr)
library(plyr)
library(tidyr)
filelist <- readLines('FixAntiFiles.txt');
# some have OS* info
df.list <- lapply( filelist,read.table, header=T,sep="\t" )
# so use ldapply to make NAs for those that dont
df.clps <- ldply(df.list,data.frame)
# remove some weird lines
badtype <- df.clps[df.clps$type==1,]
df.clps <- df.clps[!df.clps$type==1,]

write.table(df.clps,file="AntiFixVGS.txt",row.names=F,quote=F)

# count number of each
table(df.clps$type)
