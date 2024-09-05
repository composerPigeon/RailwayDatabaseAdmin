
-- Create pdb
create pluggable database pdb_railway
    admin user railway_admin identified by Railway34
    filename_convert = ('/opt/oracle/oradata/SEED/', '/opt/oracle/oradata/pdb_railway/')
    storage unlimited;


-- Set pdb to open with database
alter pluggable database pdb_railway open;
alter pluggable database pdb_railway save state;


-- Grant privilages to admin of pdb
grant dba to railway_admin;
grant connect, resource to railway_admin;
alter user railway_admin
    quota unlimited on users;