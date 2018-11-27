CREATE TABLE [dbo].[CHCNPORTAL3_UDF_ASP_TABLES]
(
[ASPGROUPID] [int] NOT NULL,
[FROM_DATE] [datetime] NOT NULL,
[TO_DATE] [datetime] NULL,
[PHCODE] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AUTH_SVCCODE] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[COMMON_ID] [int] NOT NULL,
[QTY] [decimal] (5, 1) NULL,
[MODIF] [varchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CREATEBY] [int] NOT NULL,
[CREATEDATE] [datetime] NOT NULL,
[LASTCHANGEBY] [int] NOT NULL,
[LASTCHANGEDATE] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CHCNPORTAL3_UDF_ASP_TABLES] ADD CONSTRAINT [PK_CHCNPORTAL3_UDF_ASP_TABLES] PRIMARY KEY CLUSTERED  ([ASPGROUPID], [FROM_DATE], [AUTH_SVCCODE], [PHCODE]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CHCNPORTAL3_UDF_ASP_TABLES] ADD CONSTRAINT [FK_CHCNPORTAL3_UDF_ASP_TABLES_CHCNPORTAL3_UDF_ASP_GROUPS] FOREIGN KEY ([ASPGROUPID]) REFERENCES [dbo].[CHCNPORTAL3_UDF_ASP_GROUPS] ([ASPGROUPID])
GO