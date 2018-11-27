CREATE TABLE [dbo].[CHCNPORTAL_AUTH_MEMOS]
(
[AUTHNO] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[MEMOLINE1] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MEMOLINE2] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MEMOLINE3] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MEMOLINE4] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CREATEBY] [int] NULL,
[CREATEDATE] [datetime] NOT NULL,
[LASTCHANGEBY] [int] NULL,
[LASTCHANGEDATE] [datetime] NOT NULL,
[ROWID] [int] NULL,
[COMPANY_ID] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ORGANIZATION_NAME] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[COMPANY_DESC] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ISEZNET] [bit] NULL,
[REQUEST_TYPE] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [AUTHNO] ON [dbo].[CHCNPORTAL_AUTH_MEMOS] ([AUTHNO]) ON [PRIMARY]
GO
