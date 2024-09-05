-- Place tables
create table CargoType (
    id integer
        constraint CargoType_id_PK primary key,
    comodity varchar2(50) not null
        constraint CargoType_comodity_Unique unique,
    unit character(2) not null
);

create table Place(
    id integer
        constraint Place_PK primary key
);

create table Train(
    id integer
        constraint Train_id_PK primary key,
    name varchar2(50 char) not null
        constraint Train_name_Unique unique,
    placeId integer not null
        constraint Train_placeId_FK_Place
            references Place(id)
);

create index Train_placeId_Inx on Train(placeId);

create table Track(
    id integer
        constraint Track_id_PK primary key
        constraint Track_id_FK_Place
            references Place(id)
            on delete cascade,
    code character(6) not null
        constraint Track_code_Unique unique,
    length number(5, 0)
        constraint Track_length_gt0 check(length > 0),
    speedLimit number(3, 0) default 160
        constraint Track_speedLimit_gt0 check(speedLimit > 0),
    numOfRails number(1, 0) default 1 not null,
        constraint Track_numOfRails_gt0 check(numOfRails > 0)
);

create table Station(
    id integer
        constraint Station_id_PK primary key
        constraint Station_id_FK_Place
            references Place(id)
            on delete cascade,
    name varchar2(50 char) not null
        constraint Station_name_Unique unique,
    trainCapacity number(4, 0) not null
        constraint Station_trainCap_gt0 check(trainCapacity > 0),
    cargoTypeId integer not null
        constraint Station_cargoTypeId_FK_CargoType
            references CargoType(id),
    cargoCapacity number
        constraint Station_cargoCap_gt0 check(cargoCapacity > 0)
);

create index Station_cargoTypeId_Inx on Station(cargoTypeId);

-- Create Trains Tables
create table Car (
    id integer
        constraint Car_id_PK primary key,
    brand varchar2(50) not null,
    model varchar2(50) not null,
    maxSpeed number(3, 0) default 160 not null
        constraint Car_maxSpeed_gt0 check(maxSpeed > 0),
    weight number not null
        constraint Car_maxWeight_gt0 check(weight > 0)
);

create table Carriage (
    id integer
        constraint Carriage_id_PK primary key
        constraint Carriage_id_FK_Car
            references Car(id)
            on delete cascade,
    code character(4) not null
        constraint Carriage_code_Unique unique,
    cargoTypeId integer not null
        constraint Carriage_cargoTypeId_FK_CargoType
            references CargoType(id),
    capacity number
        constraint Carriage_cap_gt0 check(capacity > 0)
);

create index Carriage_cargoTypeId_Inx on Carriage(cargoTypeId);

create table License (
    id integer
        constraint License_id_PK primary key,
    code char(4) not null
        constraint License_code_Unique unique,
    description varchar2(50 char)
);

create table Locomotive (
    id integer
        constraint Locomotive_id_PK primary key
        constraint Locomotive_id_FK_Car
            references Car(id)
            on delete cascade,
    code character(4) not null
        constraint Locomotive_code_Unique unique,
    weightCapacity number
        constraint Locomotive_weightCapacity_gt0 check(weightCapacity > 0),
    licenseId integer
        constraint Locomotive_licenseId_FK_License
            references License(id)
);

create index Locomotive_licenseId_inx on Locomotive(licenseId);

create table TrainRecipe (
    trainId integer
        constraint TrainRecipe_trainId_FK_Train
            references Train(id)
            on delete cascade,
    carId integer
        constraint TrainRecipe_carId_FK_Car
            references Car(id),
    constraint TrainRecipe_PK primary key (trainId, carId)
);

create index TrainRecipe_trainId_Inx on TrainRecipe(trainId);
create index TrainRecipe_carId_Inx on TrainRecipe(carId);