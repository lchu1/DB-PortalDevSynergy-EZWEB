CREATE TABLE [dbo].[CHCNPORTAL_AuthReqNotes_Temp_bak]
(
[ID] [int] NOT NULL,
[RequestID] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Subject] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Notes] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Submitted] [bit] NOT NULL
) ON [PRIMARY]
GO
