#!/usr/bin/env bash
#
#
# group LunaIDs that might be in the same family
# 
#

## two ways to find families:
# they share contacts
[ ! -r postgres_maybefamily.txt ] && psql  lncddb lncd  <family.sql |sed 1,5d |sed '$d' > postgres_maybefamily.txt

# the RA notes say they are siblings
[ ! -r allnoteids.txt ] && ./bynote.bash


# parse maybefamiliy to look like bynote
# cat both so we can uniq them

(
 # go through each pair in postgres export (based on contact info)
 # and make a list of related people
 perl -slane '
   push @{ $f{$F[0]} }, $F[1];  # key by first in pair
   push @{ $f{$F[1]} }, $F[0];  # kye by 2nd   in pair
   END{ 
      # at the end go through each id
      for $k (keys %f){ 
         # print the sorted collection of all pairs that have been built
         print join(" ", 
                     sort(  ($k,@{$f{$k}})  ) 
                    ) 
         }
   }' < postgres_maybefamily.txt ; 

   # also print all family lists from outputed by bynote.bash
   cat allnoteids.txt

)|
 ## remove duplicates
 sort |
 uniq  > allfamilies_redudant.txt
