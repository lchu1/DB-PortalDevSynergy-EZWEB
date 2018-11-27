CREATE TABLE [dbo].[CHCNAuthReq_CPT_ICD_DUP_Temp]
(
[RequestID] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ProcCode] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Modif] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DiagCode] [varchar] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DIAGREFNO] [int] NULL,
[EntryAddedTS] [datetime] NULL
) ON [PRIMARY]
GO
