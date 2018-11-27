CREATE TABLE [dbo].[CHCNWEB_AUTHS]
(
[AUTHNO] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[COMPANY_ID] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MEMBNAME] [varchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[STATUSCODE] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[STATUS] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[REQDATE] [datetime] NULL,
[AUTHDATE] [datetime] NULL,
[EXPRDATE] [datetime] NULL,
[REQPROV] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RQPROVID] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RENDPROV] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RENDPROVID] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MEMBID] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LASTNM] [varchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FIRSTNM] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BIRTH] [datetime] NULL,
[PATID] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CLINIC] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PCP] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OPT] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
