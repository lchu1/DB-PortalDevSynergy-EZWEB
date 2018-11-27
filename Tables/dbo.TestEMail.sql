CREATE TABLE [dbo].[TestEMail]
(
[RowId] [int] NOT NULL,
[REQID] [int] NULL,
[REQDATE] [datetime] NULL,
[REQNAME] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[URGENT] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
