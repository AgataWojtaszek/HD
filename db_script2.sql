/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2012                    */
/* Created on:     10.05.2018 10:13:09                          */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('"Zmiana zdarzenia"') and o.name = 'FK_ZMIANA Z_RELATIONS_S£OWNIK')
alter table "Zmiana zdarzenia"
   drop constraint "FK_ZMIANA Z_RELATIONS_S£OWNIK"
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('"Zmiana zdarzenia"') and o.name = 'FK_ZMIANA Z_RELATIONS_S£OWNIKA')
alter table "Zmiana zdarzenia"
   drop constraint "FK_ZMIANA Z_RELATIONS_S£OWNIKA"
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('"Zmiana zdarzenia"') and o.name = 'FK_ZMIANA Z_RELATIONS_KALENDAR')
alter table "Zmiana zdarzenia"
   drop constraint "FK_ZMIANA Z_RELATIONS_KALENDAR"
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Kalendarz')
            and   type = 'U')
   drop table Kalendarz
go

if exists (select 1
            from  sysobjects
           where  id = object_id('"S³ownik zdarzeñ"')
            and   type = 'U')
   drop table "S³ownik zdarzeñ"
go

if exists (select 1
            from  sysobjects
           where  id = object_id('"S³ownika stanów"')
            and   type = 'U')
   drop table "S³ownika stanów"
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('"Zmiana zdarzenia"')
            and   name  = 'Relationship_3_FK'
            and   indid > 0
            and   indid < 255)
   drop index "Zmiana zdarzenia".Relationship_3_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('"Zmiana zdarzenia"')
            and   name  = 'Relationship_2_FK'
            and   indid > 0
            and   indid < 255)
   drop index "Zmiana zdarzenia".Relationship_2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('"Zmiana zdarzenia"')
            and   name  = 'Relationship_1_FK'
            and   indid > 0
            and   indid < 255)
   drop index "Zmiana zdarzenia".Relationship_1_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('"Zmiana zdarzenia"')
            and   type = 'U')
   drop table "Zmiana zdarzenia"
go

/*==============================================================*/
/* Table: Kalendarz                                             */
/*==============================================================*/
create table Kalendarz (
   Id_Kalendarz         bigint               not null,
   Dzieñ                int                  null,
   Miesi¹c              int                  null,
   Kwarta³              int                  null,
   Rok                  int                  null,
   constraint PK_KALENDARZ primary key nonclustered (Id_Kalendarz)
)
go

/*==============================================================*/
/* Table: "S³ownik zdarzeñ"                                     */
/*==============================================================*/
create table "S³ownik zdarzeñ" (
   ID_S³ownika_Zdarzeñ  bigint               not null,
   "Nazwa zdarzenia"    varchar(100)         null,
   constraint "PK_S£OWNIK ZDARZEÑ" primary key nonclustered (ID_S³ownika_Zdarzeñ)
)
go

/*==============================================================*/
/* Table: "S³ownika stanów"                                     */
/*==============================================================*/
create table "S³ownika stanów" (
   ID_S³ownika_stanów   bigint               not null,
   "Nazwa stanu"        varchar(100)         null,
   constraint "PK_S£OWNIKA STANÓW" primary key nonclustered (ID_S³ownika_stanów)
)
go

/*==============================================================*/
/* Table: "Zmiana zdarzenia"                                    */
/*==============================================================*/
create table "Zmiana zdarzenia" (
   Data_Zmiany_Zdarzenia bigint               not null,
   ID_S³ownika_Zdarzeñ  bigint               null,
   ID_S³ownika_stanów   bigint               null,
   ID_Zmiiana_Zdarzenia bigint               not null,
   Numer_wniosku        varchar(20)          null,
   Tech_Start_Dtm       datetime             null,
   Tech_End_Dtm         datetime             null,
   Tech_System_Code     varchar(50)          null,
   Tech_Source_Id       varchar(20)          null,
   constraint "PK_ZMIANA ZDARZENIA" primary key nonclustered (ID_Zmiiana_Zdarzenia)
)
go

/*==============================================================*/
/* Index: Relationship_1_FK                                     */
/*==============================================================*/
create index Relationship_1_FK on "Zmiana zdarzenia" (
ID_S³ownika_Zdarzeñ ASC
)
go

/*==============================================================*/
/* Index: Relationship_2_FK                                     */
/*==============================================================*/
create index Relationship_2_FK on "Zmiana zdarzenia" (
ID_S³ownika_stanów ASC
)
go

/*==============================================================*/
/* Index: Relationship_3_FK                                     */
/*==============================================================*/
create index Relationship_3_FK on "Zmiana zdarzenia" (
Data_Zmiany_Zdarzenia ASC
)
go

alter table "Zmiana zdarzenia"
   add constraint "FK_ZMIANA Z_RELATIONS_S£OWNIK" foreign key (ID_S³ownika_Zdarzeñ)
      references "S³ownik zdarzeñ" (ID_S³ownika_Zdarzeñ)
go

alter table "Zmiana zdarzenia"
   add constraint "FK_ZMIANA Z_RELATIONS_S£OWNIKA" foreign key (ID_S³ownika_stanów)
      references "S³ownika stanów" (ID_S³ownika_stanów)
go

alter table "Zmiana zdarzenia"
   add constraint "FK_ZMIANA Z_RELATIONS_KALENDAR" foreign key (Data_Zmiany_Zdarzenia)
      references Kalendarz (Id_Kalendarz)
go

