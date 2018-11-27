CREATE TABLE [dbo].[CHCNWEB_CHCN_PCPS]
(
[ID] [int] NOT NULL,
[VENDOR] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LASTNAME] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FIRSTNAME] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[REVFN] [varchar] (67) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PROVID] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FULLNAME] [varchar] (67) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SITE] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SPECIALTY] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SPECCODE] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NPI] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
