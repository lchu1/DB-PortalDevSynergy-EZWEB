CREATE TABLE [dbo].[CHCNPORTAL_LOG_EMAIL_TABLE]
(
[UserID] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Template] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Date] [datetime] NOT NULL,
[Email] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
