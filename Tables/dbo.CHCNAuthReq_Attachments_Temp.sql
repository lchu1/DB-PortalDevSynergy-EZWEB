CREATE TABLE [dbo].[CHCNAuthReq_Attachments_Temp]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[REQUESTID] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FILENAME] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DESCR] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CONTENTTYPE] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ATTACHMENT] [varbinary] (max) NULL,
[SUBMITTED] [bit] NULL,
[ENTRY_ADDED_TS] [datetime] NULL,
[MSG_FLAG] [bit] NULL
) ON [PRIMARY]
GO
