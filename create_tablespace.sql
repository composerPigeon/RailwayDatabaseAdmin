-- Create tablespace
create tablespace railway_data
    datafile '/opt/oracle/oradata/XE/pdb_railway/railway_data.dbf'
    size 500M autoextend on next 100M maxsize unlimited
    logging
    extent management local
    autoallocate
    segment space management auto;

-- Create data owner
create user data_owner identified by Owner56
    default tablespace railway_data
    quota unlimited on railway_data;

-- Grant privilages to data owner
grant connect, resource to data_owner;