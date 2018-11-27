CREATE TABLE [dbo].[CHCNWEB_MEMBER_HISTORY]
(
[VENDOR] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MEMBID] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PCPFROMDT] [datetime] NULL,
[PCPTHRUDT] [datetime] NULL,
[PCP] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[COMPANY_ID] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OPTNAME] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
