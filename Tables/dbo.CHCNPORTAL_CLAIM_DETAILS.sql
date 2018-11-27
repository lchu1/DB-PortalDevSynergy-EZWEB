CREATE TABLE [dbo].[CHCNPORTAL_CLAIM_DETAILS]
(
[VENDOR] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[COMPANY_ID] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PROCCODE] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[QTY] [numeric] (5, 1) NULL,
[PROVID] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[REV_FULLNAME] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DATEPAID] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CHECKNO] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ADJCODE] [varchar] (7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NET] [numeric] (15, 2) NULL,
[MODIF] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DESCR] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BILLED] [numeric] (10, 2) NULL,
[DIAGCODE] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DIAGDESC] [varchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CLAIMNO] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DATERECD] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DATEFROM] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DATETO] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CASENO] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[STATUS] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TOTALNET] [numeric] (15, 2) NOT NULL,
[OPTDESC] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PROVCLAIM] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CROSSREF_ID] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IMAGE_URL] [varchar] (81) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VENDORNM] [varchar] (75) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MEMBID] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[NOTES] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MEMBNAME] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PLACESVC] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TBLROWID] [int] NULL,
[MODIF2] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MODIF3] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MODIF4] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[COPAY] [numeric] (15, 2) NULL,
[REMITT_CODE] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[REMITT_DESC] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AUTHNO] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FACILITY] [varchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SEQUENCE] [smallint] NULL,
[LINEFLAG] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [CLAIMNO] ON [dbo].[CHCNPORTAL_CLAIM_DETAILS] ([CLAIMNO]) ON [PRIMARY]
GO