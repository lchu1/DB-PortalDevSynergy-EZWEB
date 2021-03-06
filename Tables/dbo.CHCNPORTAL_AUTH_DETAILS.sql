CREATE TABLE [dbo].[CHCNPORTAL_AUTH_DETAILS]
(
[AUTHNUMBER] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AUTHNO] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[COMPANY_ID] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[STATUS] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[REQDATE] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AUTHDATE] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EXPRDATE] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[REQPROV] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RQPROVID] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RENDPROV] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MEMBID] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PROCCODE] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DIAGCODE] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DESCRIPTION] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DIAGDESC] [varchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CASENO] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[QTY] [numeric] (5, 1) NULL,
[OPTDESC] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VENDORNM] [varchar] (75) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[REV_RENDPROV] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PLACESVC] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MODIF] [varchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PHCODE] [varchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[STATUSCODE] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MEMBNAME] [varchar] (120) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CERTTYPE] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ONSETDT] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PROCCODE_COMMON_ID] [int] NULL,
[AUTHSTATUS] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [AUTHNUMBER] ON [dbo].[CHCNPORTAL_AUTH_DETAILS] ([AUTHNUMBER]) ON [PRIMARY]
GO
