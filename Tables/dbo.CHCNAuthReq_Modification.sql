CREATE TABLE [dbo].[CHCNAuthReq_Modification]
(
[RowID] [int] NOT NULL IDENTITY(1, 1),
[UserID] [nchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AuthNo] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AuthDetail] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AuthDiags] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ServiceStartDate] [datetime] NULL,
[ServiceEndDate] [datetime] NULL,
[RendProvID] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Attachment] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Notes] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Notes_EZCAPMOD] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EZCAP_CSINO] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EnterDate] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CHCNAuthReq_Modification] ADD CONSTRAINT [PK_CHCNAuthReq_Modification] PRIMARY KEY CLUSTERED  ([RowID]) ON [PRIMARY]
GO
