/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2012                    */
/* Created on:     04.07.2018 22:52:49                          */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('"Zmiana zdarzenia"') and o.name = 'FK_ZMIANA_Z_RELATIONS_S£OWNIK1')
alter table "Zmiana zdarzenia"
   drop constraint FK_ZMIANA_Z_RELATIONS_S£OWNIK1
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('"Zmiana zdarzenia"') and o.name = 'FK_ZMIANA Z_RELATIONS_S£OWNIK')
alter table "Zmiana zdarzenia"
   drop constraint "FK_ZMIANA Z_RELATIONS_S£OWNIK"
go

if exists (select 1
            from  sysobjects
           where  id = object_id('"S³ownik stanów"')
            and   type = 'U')
   drop table "S³ownik stanów"
go

if exists (select 1
            from  sysobjects
           where  id = object_id('"S³ownik zdarzeñ"')
            and   type = 'U')
   drop table "S³ownik zdarzeñ"
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
/* Table: "S³ownik stanów"                                      */
/*==============================================================*/
create table "S³ownik stanów" (
   ID_Sl_St             bigint               not null,
   Nazwa_stanu          varchar(50)          null,
   Stan_koncowy         bit                  null,
   constraint "PK_S£OWNIK STANÓW" primary key nonclustered (ID_Sl_St)
)
go

/*==============================================================*/
/* Table: "S³ownik zdarzeñ"                                     */
/*==============================================================*/
create table "S³ownik zdarzeñ" (
   ID_Sl_Zd             bigint               not null,
   Nazwa_zdarzenia      varchar(50)          null,
   constraint "PK_S£OWNIK ZDARZEÑ" primary key nonclustered (ID_Sl_Zd)
)
go

/*==============================================================*/
/* Table: "Zmiana zdarzenia"                                    */
/*==============================================================*/
create table "Zmiana zdarzenia" (
   ID_Zm_Zd             bigint               not null,
   ID_Sl_Zd             bigint               not null,
   ID_Sl_St             bigint               not null,
   Numer_wniosku        varchar(30)          null,
   Data_zmiany_zdarzenia datetime             null,
   Data_zakonczenia_zdarzenia datetime             null,
   System               varchar(50)          null,
   Numer_systemowy_wniosku varchar(30)          null,
   constraint "PK_ZMIANA ZDARZENIA" primary key nonclustered (ID_Zm_Zd)
)
go

/*==============================================================*/
/* Index: Relationship_1_FK                                     */
/*==============================================================*/
create index Relationship_1_FK on "Zmiana zdarzenia" (
ID_Sl_St ASC
)
go

/*==============================================================*/
/* Index: Relationship_2_FK                                     */
/*==============================================================*/
create index Relationship_2_FK on "Zmiana zdarzenia" (
ID_Sl_Zd ASC
)
go

alter table "Zmiana zdarzenia"
   add constraint FK_ZMIANA_Z_RELATIONS_S£OWNIK1 foreign key (ID_Sl_St)
      references "S³ownik stanów" (ID_Sl_St)
go

alter table "Zmiana zdarzenia"
   add constraint "FK_ZMIANA Z_RELATIONS_S£OWNIK" foreign key (ID_Sl_Zd)
      references "S³ownik zdarzeñ" (ID_Sl_Zd)
go

