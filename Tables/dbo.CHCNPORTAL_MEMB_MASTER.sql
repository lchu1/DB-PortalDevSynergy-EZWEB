CREATE TABLE [dbo].[CHCNPORTAL_MEMB_MASTER]
(
[MEMB_KEYID] [uniqueidentifier] NOT NULL,
[MEMB_MPI_NO] [uniqueidentifier] NOT NULL,
[MEMBID] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[MEMBSSN] [varchar] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PATID] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LASTNM] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FIRSTNM] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[REV_FULLNAME] [varchar] (72) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SEX] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BIRTH] [datetime] NOT NULL,
[Code] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[STREET] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[STREET2] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CITY] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ZIP] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PHONE] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OTHCOV] [bit] NULL,
[OTHPRIM] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OTHNAME] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MEMOLINE1] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MEMOLINE2] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MEMOLINE3] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MEMOLINE4] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PCP] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PCPFROMDT] [datetime] NULL,
[PCPTHRUDT] [datetime] NULL,
[TRANDATE] [datetime] NULL,
[OPFROMDT] [datetime] NOT NULL,
[OPTHRUDT] [datetime] NULL,
[HPFROMDT] [datetime] NULL,
[HPCODE] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[OPT] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[HMO] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[HP] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CHC] [varchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CREATEDATE] [datetime] NOT NULL,
[SITE] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[USERFIELD1] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[USERFIELD2] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[NOTES] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LANGUAGE] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[STATUS] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EMPGROUP] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CLINIC] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AAH_ID] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AAHS_ID] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AACC_ID] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ANTHEM_ID] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[HN_ID] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OPTDESC] [varchar] (8000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [AACC_ID] ON [dbo].[CHCNPORTAL_MEMB_MASTER] ([AACC_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [AAH_ID] ON [dbo].[CHCNPORTAL_MEMB_MASTER] ([AAH_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [AAHS_ID] ON [dbo].[CHCNPORTAL_MEMB_MASTER] ([AAHS_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [ANTHEM_ID] ON [dbo].[CHCNPORTAL_MEMB_MASTER] ([ANTHEM_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [FIRSTNM] ON [dbo].[CHCNPORTAL_MEMB_MASTER] ([FIRSTNM]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [HN_ID] ON [dbo].[CHCNPORTAL_MEMB_MASTER] ([HN_ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [LASTNM] ON [dbo].[CHCNPORTAL_MEMB_MASTER] ([LASTNM]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [MEMB_KEYID] ON [dbo].[CHCNPORTAL_MEMB_MASTER] ([MEMB_KEYID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [MEMBID] ON [dbo].[CHCNPORTAL_MEMB_MASTER] ([MEMBID]) ON [PRIMARY]
GO
