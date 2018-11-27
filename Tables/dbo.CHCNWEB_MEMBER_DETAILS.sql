CREATE TABLE [dbo].[CHCNWEB_MEMBER_DETAILS]
(
[VENDOR] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MEMBID] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LASTNM] [varchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FIRSTNM] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[REV_FULLNAME] [varchar] (98) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SEX] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DOB] [datetime] NULL,
[PATID] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PCP] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PCPFROMDT] [datetime] NULL,
[PCPTHRUDT] [datetime] NULL,
[STATUS] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OPTNAME] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[COMPANY_ID] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
