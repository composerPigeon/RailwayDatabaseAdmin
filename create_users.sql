-- Create help roles for application
create role trains_read_role;
create role trains_write_role;
create role places_read_role;
create role places_write_role;

grant select on Place, Station, Track to places_read_role;
grant insert, update, delete on Place, Station, Track to places_write_role;

grant select
    on Train, Car, Locomotive, Carriage, License, TrainRecipe
    to trains_read_role;

grant insert, update, delete
    on Train, Car, Locomotive, Carriage, License, TrainRecipe
    to trains_write_role;

-- Create final roles
create role railway_infrastructure_manager;
create role railcar_manager;
create role train_dispatcher;

grant places_read_role, places_write_role, trains_read_role to railway_infrastructure_manager;
grant places_read_role, trains_read_role, trains_write_role to railcar_manager;
grant places_read_role, trains_read_role to train_dispatcher;


-- Create users
create user pavel_vomacka identified by Vomacka107
    default tablespace railway_data
    quota unlimited on railway_data;

grant railway_infrastructure_manager to pavel_vomacka;

create user petr_cara identified by Cara304
    default tablespace railway_data
    quota unlimited on railway_data;

grant railcar_manager to petr_cara;

create user albrecht_novak identified by Novak33
    default tablespace railway_data
    quota unlimited on railway_data;

grant train_dispatcher to albrecht_novak;