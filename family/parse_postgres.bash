#!/usr/bin/env bash

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
