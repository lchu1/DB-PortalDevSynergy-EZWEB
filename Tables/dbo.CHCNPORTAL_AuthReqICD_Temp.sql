CREATE TABLE [dbo].[CHCNPORTAL_AuthReqICD_Temp]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[RequestID] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Common_ID] [int] NULL,
[DiagCode] [varchar] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DiagDesc] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Submitted] [bit] NOT NULL CONSTRAINT [DF_CHCNPORTAL_AuthReqICD_Temp_Submitted] DEFAULT ((0))
) ON [PRIMARY]
GO
