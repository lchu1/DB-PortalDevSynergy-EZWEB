CREATE TABLE [dbo].[CHCNPORTAL3_MESSAGE_LOG]
(
[MessageID] [int] NOT NULL IDENTITY(1, 1),
[AuthNo] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CHCNUserID] [int] NULL,
[CHCNUserName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UserID] [int] NULL,
[Messages] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Msg_Leng] [int] NULL,
[EnterDate] [datetime] NULL,
[IsRead] [bit] NULL,
[ReadDate] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CHCNPORTAL3_MESSAGE_LOG] ADD CONSTRAINT [PK_CHCNPORTAL3_MESSAGE_LOG] PRIMARY KEY CLUSTERED  ([MessageID]) ON [PRIMARY]
GO
