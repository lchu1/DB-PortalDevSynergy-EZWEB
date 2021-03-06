CREATE TABLE [dbo].[CHCNWEB_EOB]
(
[CLAIMNO] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PROCCODE] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MODIF] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MODIF2] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FROMDATESVC] [datetime] NULL,
[BILLED] [decimal] (10, 2) NULL,
[CONTRVAL] [decimal] (15, 2) NULL,
[COPAY] [decimal] (15, 2) NULL,
[ADJUST] [decimal] (15, 2) NULL,
[ADJCODE] [varchar] (7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NET] [decimal] (15, 2) NULL,
[WITHHOLD] [decimal] (15, 2) NULL,
[TODATESVC] [datetime] NULL,
[CAPITATED] [decimal] (1, 0) NULL,
[SEQUENCE] [smallint] NULL,
[STATUS] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DATEPAID] [datetime] NULL,
[CHPREFIX] [int] NULL,
[CHECKNO] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[INTEREST] [decimal] (15, 2) NULL,
[LASTNM] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FIRSTNM] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MEMBNAME] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OPT] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PROVCLAIM] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PMTSTATUS] [varchar] (8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[COMMENTS] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VENDORID] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VENDORNM] [varchar] (75) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[STREET] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CITY] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[STATE] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ZIP] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BIRTH] [datetime] NULL,
[SEX] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PATID] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VENDNPI] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MCALID] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Type] [int] NULL,
[ADJUSTWH] [decimal] (15, 2) NULL,
[ADJCODEWH] [varchar] (7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [EOB_CHECKNO] ON [dbo].[CHCNWEB_EOB] ([CHECKNO]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [EOB_CLAIMNO] ON [dbo].[CHCNWEB_EOB] ([CLAIMNO]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [EOB_DATEPD] ON [dbo].[CHCNWEB_EOB] ([DATEPAID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [EOB_VENDOR] ON [dbo].[CHCNWEB_EOB] ([VENDORID]) ON [PRIMARY]
GO
