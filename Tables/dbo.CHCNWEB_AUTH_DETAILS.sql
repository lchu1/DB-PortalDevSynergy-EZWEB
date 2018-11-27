CREATE TABLE [dbo].[CHCNWEB_AUTH_DETAILS]
(
[AUTHNUMBER] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[COMPANY_ID] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[STATUS] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AUTHNO] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[REQDATE] [datetime] NULL,
[AUTHDATE] [datetime] NULL,
[EXPRDATE] [datetime] NULL,
[REQPROV] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RQPROVID] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RENDPROV] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MEMBID] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PROCCODE] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DIAGCODE] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DESCR] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DIAGDESC] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CASENO] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[QTY] [int] NULL,
[OPTNAME] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DEPARTMENT] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
