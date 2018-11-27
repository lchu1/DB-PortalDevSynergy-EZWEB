CREATE TABLE [dbo].[CHCNWEB_SPECIALISTS_ALL]
(
[ID] [int] NOT NULL,
[FULLNAME] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LASTNAME] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FIRSTNAME] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PROVID] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[STREET] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CITY] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ZIP] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PHONE] [varchar] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FAX] [varchar] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[HOSPITAL] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DESCR] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CODE] [varchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MEMOLINE3] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LANGUAGE] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MEDICAL_GROUP] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CONTRACT] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
