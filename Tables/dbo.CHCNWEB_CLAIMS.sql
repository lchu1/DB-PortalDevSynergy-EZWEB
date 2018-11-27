CREATE TABLE [dbo].[CHCNWEB_CLAIMS]
(
[LASTNM] [varchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FIRSTNM] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MEMBID] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PATID] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BIRTH] [datetime] NULL,
[CLAIMNO] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DATEFROM] [datetime] NULL,
[DATETO] [datetime] NULL,
[STATUS] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DATERECD] [datetime] NULL,
[BILLED] [decimal] (15, 2) NULL,
[VENDOR] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[COMPANY_ID] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
