CREATE TABLE [dbo].[CHCNWEB_CHCELIG]
(
[CHC] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[COMPANY] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EFFDATE] [datetime] NULL,
[TERMDATE] [datetime] NULL,
[PATID] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PLAN] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MEMBSSN] [varchar] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LASTNM] [varchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FIRSTNM] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[STREET] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CITY] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ZIP] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DOB] [datetime] NULL,
[SEX] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PHONE] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LANGUAGE] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MCAL10] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OTHERID2] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SITE] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TRANCODE] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TRANDATE] [datetime] NULL,
[VENDORID] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[HMO] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MEMBID] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[HIC] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MCARE_A] [datetime] NULL,
[MCARE_B] [datetime] NULL,
[CCS] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CCSDT] [datetime] NULL,
[COB] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[HFPCOPAY] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AC] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [WEB_HMO] ON [dbo].[CHCNWEB_CHCELIG] ([HMO]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [WEB_VENDORID] ON [dbo].[CHCNWEB_CHCELIG] ([VENDORID]) ON [PRIMARY]
GO
