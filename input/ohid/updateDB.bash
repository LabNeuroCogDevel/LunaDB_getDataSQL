#!/usr/bin/env bash
set -e
RES=""

function sql {
 mysql -h arnold.wpic.upmc.edu -ulocaladmin -p'local!123' lncddb3 -NBe "$@"
}
# does the sql statement return results?
function sqlexist {
 RES=$(mysql -h arnold.wpic.upmc.edu -ulocaladmin -p'local!123' lncddb3 -NBe "$@")
 [ -n "$RES" ] 
}

# insert adult and kid mhpid's into db
sed 1d OHernToLuna.txt | 
 while read  OHID Luna_ID ; do
   [ -z "$Luna_ID" -o -z "$OHID" ] && continue

   # find peopleID
   pid=$(sql "select peopleid from peopleEnroll where enrollType like 'LunaID' and value = $Luna_ID"|sed 1q)
   [ -z "$pid" ] && echo "no lunaid $Luna_ID in db!" && continue

   ohid=$(sql "select value from peopleEnroll where enrollType like 'OHID' and (peopleID = $pid or value like '$OHID')")
   [ -n "$ohid" ] && echo "OHID for $Luna_ID (pid:$pid) already in DB ($OHID as $ohid)!" && continue

   echo "$Luna_ID is $pid, adding OHID $OHID"
   sql "insert into peopleEnroll (peopleID,enrollType, value) values ($pid,'OHID','$OHID')"  && echo "$pid $Luna_ID $OHID" >> oh_luna_added.txt
done


# undo:
# sql "select * from peopleEnroll where enrollType like 'OHID' ";
