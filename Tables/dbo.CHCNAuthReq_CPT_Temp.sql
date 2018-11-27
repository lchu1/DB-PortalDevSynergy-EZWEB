CREATE TABLE [dbo].[CHCNAuthReq_CPT_Temp]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[RequestID] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Common_ID] [int] NOT NULL,
[PHCODE] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ProcCode] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ProcDesc] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Qty] [int] NOT NULL,
[Modif] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Dup] [bit] NULL,
[Submitted] [bit] NOT NULL CONSTRAINT [DF_CHCNAuthReq_CPT_Temp_Submitted] DEFAULT ((0)),
[EntryAddedTS] [datetime] NULL,
[ASPType] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ASPGroupID] [int] NULL
) ON [PRIMARY]
GO
