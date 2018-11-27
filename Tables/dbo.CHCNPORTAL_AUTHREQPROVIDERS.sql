CREATE TABLE [dbo].[CHCNPORTAL_AUTHREQPROVIDERS]
(
[PROV_KEYID] [uniqueidentifier] NOT NULL,
[VENDOR] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VENDORNM] [varchar] (75) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PROVID] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[REVNAME] [varchar] (129) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FULLNAME] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FIRSTNAME] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LASTNAME] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CONTRACT] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CONTRACT_DESCR] [varchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SPECCODE] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SPECDESCR] [varchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FROMDATE] [datetime] NULL,
[TERMDATE] [datetime] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [PROVID] ON [dbo].[CHCNPORTAL_AUTHREQPROVIDERS] ([PROVID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [VENDOR] ON [dbo].[CHCNPORTAL_AUTHREQPROVIDERS] ([VENDOR]) ON [PRIMARY]
GO