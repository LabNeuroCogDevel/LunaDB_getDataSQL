 -- ------------------
 -- family
 drop table if exists contact_abrv;
 create temporary table  contact_abrv as (
 select 
  pid,fname,lname, relation,date_part('day',(now()-dob))/365.25 as curage, 
  case when cvalue ~ '^[ ,]+PA[, ]+$' then null else regexp_replace(cvalue,'[)(-.]','','g') end as cvalue,
  ctype,
  who,
  (select e.id from enroll e where etype like 'LunaID' and e.pid = person.pid limit 1) as lunaid
 from person
 natural join contact
 );
 
 
 
 drop table if exists maybefamily;
 create temporary table  maybefamily as (
  select 
	  case when ca1.pid>ca2.pid then ca1.pid*100000+ca2.pid else ca2.pid*100000+ca1.pid end as relid,
	  count(*)/2 as score,
	  min(ca1.pid) pid1,
	  max(ca1.pid) pid2,
	  min(ca1.lunaid::int) luna1,
	  max(ca1.lunaid::int) luna2,
	  count(distinct(ca1.lname))<=1 as samelastname,
	  max(ca1.curage)- min(ca1.curage) as agediff,
	  json_agg(distinct ca1.lname) as lnames,
	  json_agg(distinct ca1.fname) as fnames
	  from contact_abrv ca1 
	  join contact_abrv ca2 on
	      ca1.pid != ca2.pid and
	      ( ca1.cvalue = ca2.cvalue or ca1.who = ca2.who ) 
	  group by relid
      order by score
);
 
select luna1,luna2 from maybefamily; --where score>3 or samelastname or agediff=0;
