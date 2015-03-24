library(plyr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(magrittr)

filelist <- readLines('FixAntiFiles.txt');
# some have OS* info
df.list <- lapply( filelist,read.table, header=T,sep="\t" )
# so use ldapply to make NAs for those that dont
df.clps <- ldply(df.list,data.frame)
# remove some weird lines
badtype <- df.clps[df.clps$type==1,]
badcount <- df.clps[df.clps$total==2,]
df.clps %<>% filter(type != 1, total !=2, total != Dropped )  

write.table(df.clps,file="AntiFixVGS.txt",row.names=F,quote=F)

# count number of each
table(df.clps$type)

# put all the lats into long format
#df.clps %>% gather_('ttype','lat',grep('lat',names(df.clps)))

# collapse everything
df.long <- df.clps %>% gather(sacc,value, -subj,-date,-run,-type,-total,-Dropped)
df.long %<>% 
     mutate(sacc = gsub('cor','Cor',sacc ) ) %>%  # bug, cor and Cor should be the same
     mutate(sacc.group = gsub('\\..*','',as.character(sacc)) ) %>%  # remove .lat to make a group name
     mutate(sacc=ifelse(grepl('lat',sacc),'lat','count') ) %>% # label as lat or count
     spread(sacc,value) %>% 
     mutate(sacc.group.notype = gsub('AS|OS|PS','',sacc.group))

p <- ggplot(df.long %>% filter(sacc.group.notype!='CorErr') ,aes(color=type,x=sacc.group.notype,y=lat))+geom_boxplot()+geom_point(aes(size=count),alpha=.3)+geom_line(aes(group=paste(subj,date,type))) + facet_grid(type~.)
ggsave('avgLat.png',p)
