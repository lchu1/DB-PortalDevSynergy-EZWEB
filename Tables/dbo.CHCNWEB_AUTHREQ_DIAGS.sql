CREATE TABLE [dbo].[CHCNWEB_AUTHREQ_DIAGS]
(
[REQUESTID] [int] NULL,
[DIAGREFNO] [smallint] NULL,
[DIAGCODE] [varchar] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DIAGDESC] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO