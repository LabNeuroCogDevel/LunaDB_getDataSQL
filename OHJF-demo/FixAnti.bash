 #!/usr/bin/env bash
 #
 function sql {  mysql -h arnold.wpic.upmc.edu -ulocaladmin -p'local!123' lncddb3 -NBe "$@"; }

 #hdrf=FixAnti.header
 #echo -n "" > $hdrf

 sql 'select pe.value, pej.value from peopleEnroll as pe join peopleEnroll as pej on pe.peopleid=pej.peopleid  where pe.enrollType like "LunaID" and pej.enrollType like "OHID"'|
  while read lid oid; do 
    for f in /mnt/B/bea_res/Data/Tasks/{MGS,VGS,Anti,Fix,Mix}/*/$lid/*/Scored/txt/*summary*; do 
      [ ! -r "$f" ] && continue
      echo $f 
      #echo "$(echo $f | cut -f7 -d/)    $(basename $f|cut -f1,2 -d.|sed 's/\./  /')     $(tail -n1 $f)"
      #head -n1 $f >> $hdrf
    done
   done > FixAntiFiles.txt

#sort $hdrf | uniq -c 
