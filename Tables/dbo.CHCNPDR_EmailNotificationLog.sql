CREATE TABLE [dbo].[CHCNPDR_EmailNotificationLog]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[CaseNo] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PostDt] [datetime] NULL,
[UserID] [int] NULL,
[Email] [varchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StatusChangeDt] [datetime] NULL,
[EmailSentDt] [datetime] NULL,
[PDRStatus] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
