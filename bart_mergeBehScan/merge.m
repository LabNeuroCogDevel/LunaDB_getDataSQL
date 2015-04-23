% mysql in matlab on linux
% http://www.mathworks.com/help/database/ug/mysql-jdbc-linux.html
% http://dev.mysql.com/downloads/file.php?id=456316 
%
%archlinux:
%   yaourt -S mysql-connector-java
%   javaaddpath('/usr/share/java/mysql-connector-java-bin.jar') 

%% database access settings
% java db driver
if exist('/usr/share/java/mysql-connector-java-bin.jar','file')
 javaaddpath('/usr/share/java/mysql-connector-java-bin.jar') 
end
% return data as table 
setdbprefs('DataReturnFormat','dataset')


% load data
load('master_ds_20150401.mat')

% connect to DB
conn = database('lncddb3','localadmin','local!123','com.mysql.jdbc.Driver', 'jdbc:mysql://arnold.wpic.upmc.edu:3306/lncddb3')

% put data in DB (way faster than for loop 'select+join')
exec(conn,'DROP TABLE IF EXISTS ldtemp');
exec(conn,'CREATE TEMPORARY TABLE ldtemp ( id INTEGER, age REAL, vd INTEGER)');
datainsert(conn,'ldtemp',{'id','age','vd'},[master_ds.subID,master_ds.age,master_ds.visitDate]);
% test=fetch(exec(conn,'select * from ldtemp'));
% test.Data

% select all visits joined
c=exec(conn,[ ...
'select ' ...
 't.id, t.vd, abs(t.age-v.age) as adiff, t.age as scanage,v.age as visitage, DATE_FORMAT(v.visitDate,"%Y%m%d") '...
  'from ldtemp as t '                                 ... % our fresh temp table
  'join peopleEnroll as pe on pe.value = t.id '       ... % matched to lunaids
  'left join visits as v on pe.peopleid = v.peopleid '     ... % matched to visits
  'left join visitsStudies as s on v.visitid = s.visitid ' ... % matched to study
  'where v.visitType like "Behavioral" '              ... % only behavioral
  '  and s.studyName like "Reward%"    '              ... % only rewards
]);
c=fetch(c);
close(conn)

% sort and then find repeat id+vd
% exclude repeats
d=sortrows(c.Data,{'id','vd','adiff'});
d.discard=[0;( d.id( 1:(end-1) )  + d.vd( 1:(end-1) ) ) == ( d.id(2:end) + d.vd(2:end) )  ]
BhvScnMerged=d(d.discard==0,:)

% save and be done
save BhvScnMerged 

%% really wanted to use grpstats to do the filtering, couldn't make it work
% 1:5 b/c grpstats panics on date as a string
%ga=grpstats(d(:,1:5),{'id','vd'})

