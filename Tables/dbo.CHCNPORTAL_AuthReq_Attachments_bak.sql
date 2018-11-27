CREATE TABLE [dbo].[CHCNPORTAL_AuthReq_Attachments_bak]
(
[ID] [int] NOT NULL,
[REQUESTID] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FILENAME] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CONTENTTYPE] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ATTACHMENT] [varbinary] (max) NULL,
[SUBMITTED] [bit] NULL
) ON [PRIMARY]
GO
