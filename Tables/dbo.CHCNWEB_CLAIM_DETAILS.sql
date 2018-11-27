CREATE TABLE [dbo].[CHCNWEB_CLAIM_DETAILS]
(
[VENDOR] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[COMPANY_ID] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PROCCODE] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[QTY] [int] NULL,
[PROVID] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[REV_FULLNAME] [varchar] (129) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DATEPAID] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CHECKNO] [int] NULL,
[ADJCODE] [varchar] (7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NET] [decimal] (15, 2) NULL,
[MODIF] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DESCR] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BILLED] [decimal] (10, 2) NULL,
[DIAGCODE] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DIAGDESC] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CLAIMNO] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DATERECD] [datetime] NULL,
[DATEFROM] [datetime] NULL,
[DATETO] [datetime] NULL,
[CASENO] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[STATUS] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TOTALNET] [decimal] (15, 2) NULL,
[OPTNAME] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
