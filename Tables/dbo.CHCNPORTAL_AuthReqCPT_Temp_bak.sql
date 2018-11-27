CREATE TABLE [dbo].[CHCNPORTAL_AuthReqCPT_Temp_bak]
(
[ID] [int] NOT NULL,
[RequestID] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Common_ID] [int] NOT NULL,
[PHCODE] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ProcCode] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ProcDesc] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Qty] [int] NOT NULL,
[Modif] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Dup] [bit] NULL,
[Submitted] [bit] NOT NULL
) ON [PRIMARY]
GO
