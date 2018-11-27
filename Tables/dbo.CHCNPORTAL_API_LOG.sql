CREATE TABLE [dbo].[CHCNPORTAL_API_LOG]
(
[ID] [uniqueidentifier] NOT NULL,
[LOGTIME] [datetime] NULL,
[DURATION] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[USERID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[REMOTE_IP] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[REQUEST_URL] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[REQUEST_METHOD] [nchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[REQUEST_HEADERS] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[REQUEST_BODY] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[REQUEST_LENGTH] [nchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RESPONSE_HEADERS] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RESPONSE_BODY] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RESPONSE_LENGTH] [nchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[STATUS_CODE] [nchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
