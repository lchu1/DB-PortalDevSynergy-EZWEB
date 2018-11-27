CREATE TABLE [dbo].[CHCNPORTAL_AUTH_NOTES]
(
[COMPANY_ID] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AUTHNO] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SEQUENCE] [smallint] NOT NULL,
[SUBJECT] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NOTES] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SECURED_YN] [smallint] NULL,
[CREATEBY] [int] NULL,
[CREATEDATE] [datetime] NOT NULL,
[LASTCHANGEBY] [int] NULL,
[LASTCHANGEDATE] [datetime] NOT NULL,
[ORGANIZATION_NAME] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[COMPANY_DESC] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ISEZNET] [bit] NULL,
[REQUEST_TYPE] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [AUTHNO] ON [dbo].[CHCNPORTAL_AUTH_NOTES] ([AUTHNO]) ON [PRIMARY]
GO