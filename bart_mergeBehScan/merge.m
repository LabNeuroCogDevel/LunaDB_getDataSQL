% mysql in matlab on linux
% http://www.mathworks.com/help/database/ug/mysql-jdbc-linux.html
% http://dev.mysql.com/downloads/file.php?id=456316 
%
%archlinux:
%   yaourt -S mysql-connector-java
%   javaaddpath('/usr/share/java/mysql-connector-java-bin.jar') 

%% database access settings
% java db driver
sqljar='/usr/share/java/mysql-connector-java-bin.jar';
% load if it exists and isn't loaded
if exist(sqljar,'file') && ~strmatch(sqljar,javaclasspath)
 javaaddpath(sqljar) 
end
% return data as table 
setdbprefs('DataReturnFormat','dataset')


% load inital list
load('master_ds_20150401.mat')

% connect to DB
conn = database('lncddb3','localadmin','local!123','com.mysql.jdbc.Driver', 'jdbc:mysql://arnold.wpic.upmc.edu:3306/lncddb3');

% put data in DB (way faster than for loop 'select+join')
exec(conn,'DROP TABLE IF EXISTS ldtemp');
exec(conn,'CREATE TEMPORARY TABLE ldtemp ( id INTEGER, age REAL, vd INTEGER)');
datainsert(conn,'ldtemp',{'id','age','vd'},[master_ds.subID,master_ds.age,master_ds.visitDate]);
% test=fetch(exec(conn,'select * from ldtemp'));
% test.Data

% select all visits joined
c=exec(conn,[ ...
'select ' ...
 't.id, t.vd, abs(t.age-v.age) as adiff, t.age as scanage,v.age as visitage, DATE_FORMAT(v.visitDate,"%Y%m%d"), '...
 'visitType, studyName, v.visitid as vid, pe.peopleid as pid '...
  'from ldtemp as t '                                 ... % our fresh temp table
  'left join peopleEnroll as pe on pe.value = t.id '       ... % matched to lunaids
  'left join visits as v on pe.peopleid = v.peopleid '     ... % matched to visits
  'left join visitsStudies as s on v.visitid = s.visitid ' ... % matched to study
]); 
% % -- do this filtering with matlab
%   'where v.visitType like "Behavioral" '              ... % only behavioral
%   '  and s.studyName like "Reward%"    '              ... % only rewards
% ]);
c=fetch(c);
bigd=c.Data;

%% filter
% want only the Reward Behaviorals.. but sometimes (RewardR21?) study is null
% we could also do this in SQL
smalld = bigd( strcmp(bigd.visitType,'Behavioral')&(strncmp(bigd.studyName,'Reward',6)|strcmp(bigd.studyName,'null') ), : );
d=sortrows(smalld(:,[1:6,9,10]),{'id','vd','adiff'});

% matlab doesn't respect SQL 'as bhvdate'. Force it
d.Properties.VarNames{6} = 'bhvdate';


%% remove dups
% create uniq subjid+visitid number
u_idvst = d.id*100000 + d.vd;
% find where id+visit does not change (set for discarding)
discard=[0; u_idvst( 1:(end-1) )  ==  u_idvst(2:end)  ];
% keep only those not discarded
BhvScnMerged=d(discard==0,:);

% [~,i,~] = unique(u_idvst)
% BhvScnMerged=d(i,:);

%% checks
% did we lose any scan visits
lostids = setdiff(master_ds.subID,d.id);
if ~isempty(lostids) 
 fprintf('could not find behave visits (or SQL join error) for %d subjs:\n', length(lostids) )
 fprintf('%d ', lostids); fprintf('\n');
end

% no scan visit should be more than a year from it's matching behave
if length(BhvScnMerged(BhvScnMerged.adiff>1,:)) > 0
  fprintf('Some visits are too far from a scan!\n')
  BhvScnMerged(BhvScnMerged.adiff>1,:)
end

% repeated behaves means behave date was matched to more than one scan 
id_=arrayfun(@(x) [num2str(x) '_'], BhvScnMerged.id, 'UniformOutput',0 );
allbehavVisits =  cell2mat([ id_ BhvScnMerged.bhvdate]);
[~,~,ic] = unique(allbehavVisits,'rows');
if any(accumarray(ic,1)>1)
 fprintf('some behaves are repeated!\n')
end

%% save 
save BhvScnMerged  BhvScnMerged;
BhvScnMerged.bhvdate= cellfun(@str2num, BhvScnMerged.bhvdate);

%% now go back to sql and get the SensationSeeking stuff
% extract data
columns={'id','vd','adiff','age','age_5','bhvdate','visitID','peopleID'};
vals = cell2mat(cellfun(@(x) BhvScnMerged.(x), columns, 'UniformOutput',0));

% make sql table
exec(conn,'DROP TABLE IF EXISTS ldtemp');
exec(conn,['CREATE TEMPORARY TABLE ldtemp ( ' ...
           ' id INTEGER, vd integer, adiff REAL,'...
           ' age REAL,age_5 REAL, bhvdate integer,'...
           ' visitid INTEGER, peopleid INTEGER)']);

datainsert(conn,'ldtemp',columns,vals);

% find all the sensation seeking data for the subjects, ingore notes and completed
c=exec(conn,[ ...
 'select * from ldtemp t'...
 ' left join visitstasks vt on vt.taskName ' ...
 ' like "SensationSeeking" and vt.visitid = t.visitID and subsection not in ("Notes", "completed")']);
c=fetch(c);
c=c.Data;

% null -> Inf
v=c.value;
for i=find(cellfun(@(x) ~isempty(strmatch(x,'null')), v))', v{i}='Inf'; end
c.value= cellfun(@str2num,v);
c.taskName = [];

% from tall to wide
BhvScnMergedSS =  unstack(c,'value','subsection');
% if there was no value collected, we have 'null' for subsection. we dont want that column
BhvScnMergedSS.null = [];

%save
save BhvScnMergedSS  BhvScnMergedSS;

close(conn);
%% really wanted to use grpstats to do the filtering, couldn't make it work
% 1:5 b/c grpstats panics on date as a string
%ga=grpstats(d(:,1:5),{'id','vd'})

