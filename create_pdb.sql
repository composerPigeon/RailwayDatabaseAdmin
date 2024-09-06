-- Create pdb
create pluggable database pdb_railway
    admin user railway_pdb_admin identified by Railway34
    file_name_convert = ('/opt/oracle/oradata/XE/pdbseed/', '/opt/oracle/oradata/XE/pdb_railway/')
    storage unlimited;


-- Set pdb to open with database
alter pluggable database pdb_railway open;
alter pluggable database pdb_railway save state;

-- Switch to pdb context
alter session set container = pdb_railway;