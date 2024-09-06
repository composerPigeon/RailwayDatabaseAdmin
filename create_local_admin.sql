-- Craeta tablespace for users
create tablespace users
    datafile '/opt/oracle/oradata/XE/pdb_railway/users.dbf' 
    size 100M 
    autoextend on next 50M maxsize unlimited
    logging
    extent management local
    segment space management auto;

create user railway_admin identified by RailwayAdmin101;

grant dba to railway_admin;
grant connect, resource to railway_admin;
alter user railway_admin
    quota unlimited on users;