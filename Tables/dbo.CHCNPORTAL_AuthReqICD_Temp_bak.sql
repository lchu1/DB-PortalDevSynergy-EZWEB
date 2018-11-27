CREATE TABLE [dbo].[CHCNPORTAL_AuthReqICD_Temp_bak]
(
[ID] [int] NOT NULL,
[RequestID] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Common_ID] [int] NULL,
[DiagCode] [varchar] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DiagDesc] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Submitted] [bit] NOT NULL
) ON [PRIMARY]
GO
