CREATE TABLE [dbo].[CHCNAuthReq_ICD_Temp]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[RequestID] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Common_ID] [int] NULL,
[DiagCode] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DiagDesc] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Submitted] [bit] NOT NULL CONSTRAINT [DF_CHCNAuthReq_ICD_Temp_Submitted] DEFAULT ((0)),
[EntryAddedTS] [datetime] NULL,
[Dup] [bit] NOT NULL CONSTRAINT [DF_CHCNAuthReq_ICD_Temp_Dup] DEFAULT ((0)),
[DIAGREFNO] [int] NULL
) ON [PRIMARY]
GO
