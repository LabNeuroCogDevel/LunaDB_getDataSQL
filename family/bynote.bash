#!/usr/bin/env bash

getids(){
  perl -slane 'print $& while m/1\d{4}/g;' |sort |uniq|tr '\n' ' '
  echo
}

sqlstr=postgres://lncd@localhost/lncddb

#[ ! -r allnoteids.txt ] &&
 sql $sqlstr "
    select id, replace(note,'\n',';') 
    from note n join enroll e on n.pid=e.pid and etype like 'LunaID'
    where note ilike '%sibling%' ;
   "| while read line; do 
   echo $line |getids;
 done |sort |uniq  > allnoteids.txt

