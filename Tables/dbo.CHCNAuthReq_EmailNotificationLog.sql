CREATE TABLE [dbo].[CHCNAuthReq_EmailNotificationLog]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[AuthNo] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PostDt] [datetime] NULL,
[UserID] [int] NULL,
[Email] [varchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StatusChangeDt] [datetime] NULL,
[EmailSentDt] [datetime] NULL,
[AuthStatus] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
