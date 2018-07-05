/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2012                    */
/* Created on:     05.07.2018 11:36:39                          */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Zmiana_zdarzenia') and o.name = 'FK_ZMIANA_Z_RELATIONS_SLOWNIK_1')
alter table Zmiana_zdarzenia
   drop constraint FK_ZMIANA_Z_RELATIONS_SLOWNIK_1
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Zmiana_zdarzenia') and o.name = 'FK_ZMIANA_Z_RELATIONS_SLOWNIK_')
alter table Zmiana_zdarzenia
   drop constraint FK_ZMIANA_Z_RELATIONS_SLOWNIK_
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Slownik_stanow')
            and   type = 'U')
   drop table Slownik_stanow
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Slownik_zdarzen')
            and   type = 'U')
   drop table Slownik_zdarzen
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Zmiana_zdarzenia')
            and   name  = 'Relationship_2_FK'
            and   indid > 0
            and   indid < 255)
   drop index Zmiana_zdarzenia.Relationship_2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Zmiana_zdarzenia')
            and   name  = 'Relationship_1_FK'
            and   indid > 0
            and   indid < 255)
   drop index Zmiana_zdarzenia.Relationship_1_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Zmiana_zdarzenia')
            and   type = 'U')
   drop table Zmiana_zdarzenia
go

/*==============================================================*/
/* Table: Slownik_stanow                                        */
/*==============================================================*/
create table Slownik_stanow (
   ID_Sl_St             bigint               not null,
   Nazwa_stanu          varchar(50)          null,
   Stan_koncowy         bit                  null,
   constraint PK_SLOWNIK_STANOW primary key nonclustered (ID_Sl_St)
)
go

/*==============================================================*/
/* Table: Slownik_zdarzen                                       */
/*==============================================================*/
create table Slownik_zdarzen (
   ID_Sl_Zd             bigint               not null,
   Nazwa_zdarzenia      varchar(50)          null,
   constraint PK_SLOWNIK_ZDARZEN primary key nonclustered (ID_Sl_Zd)
)
go

/*==============================================================*/
/* Table: Zmiana_zdarzenia                                      */
/*==============================================================*/
create table Zmiana_zdarzenia (
   ID_Zm_Zd             bigint               not null,
   ID_Sl_Zd             bigint               not null,
   ID_Sl_St             bigint               not null,
   Numer_wniosku        varchar(30)          null,
   Data_zmiany_zdarzenia datetime             null,
   Data_zakonczenia_zdarzenia datetime             null,
   System               varchar(50)          null,
   Numer_systemowy_wniosku varchar(30)          null,
   constraint PK_ZMIANA_ZDARZENIA primary key nonclustered (ID_Zm_Zd)
)
go

/*==============================================================*/
/* Index: Relationship_1_FK                                     */
/*==============================================================*/
create index Relationship_1_FK on Zmiana_zdarzenia (
ID_Sl_St ASC
)
go

/*==============================================================*/
/* Index: Relationship_2_FK                                     */
/*==============================================================*/
create index Relationship_2_FK on Zmiana_zdarzenia (
ID_Sl_Zd ASC
)
go

alter table Zmiana_zdarzenia
   add constraint FK_ZMIANA_Z_RELATIONS_SLOWNIK_1 foreign key (ID_Sl_St)
      references Slownik_stanow (ID_Sl_St)
go

alter table Zmiana_zdarzenia
   add constraint FK_ZMIANA_Z_RELATIONS_SLOWNIK_ foreign key (ID_Sl_Zd)
      references Slownik_zdarzen (ID_Sl_Zd)
go

