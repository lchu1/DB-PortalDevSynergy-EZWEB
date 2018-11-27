CREATE TABLE [dbo].[CHCNPDR_ClaimMulti]
(
[RowID] [int] NOT NULL IDENTITY(1, 1),
[RequestID] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ClaimNo] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Sequence] [int] NOT NULL,
[EnterDate] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CHCNPDR_ClaimMulti] ADD CONSTRAINT [PK_CHCNPDR_ClaimNo] PRIMARY KEY CLUSTERED  ([RequestID], [ClaimNo], [Sequence]) ON [PRIMARY]
GO
