CREATE TABLE [dbo].[CHCNPORTAL3_UDF_ASP_GROUPS]
(
[ASPGROUPID] [int] NOT NULL,
[COMPANY_ID] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[GROUP_DESCR] [varchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ASPSET] [int] NOT NULL CONSTRAINT [DF_CHCNPORTAL3_UDF_ASP_GROUPS_ASPSET] DEFAULT ((100)),
[STATUS] [bit] NOT NULL,
[CREATEBY] [int] NOT NULL,
[CREATEDATE] [datetime] NOT NULL,
[LASTCHANGEBY] [int] NOT NULL,
[LASTCHANGEDATE] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CHCNPORTAL3_UDF_ASP_GROUPS] ADD CONSTRAINT [PK_CHCNPORTAL3_UDF_ASP_GROUPS_1] PRIMARY KEY CLUSTERED  ([ASPGROUPID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CHCNPORTAL3_UDF_ASP_GROUPS] ADD CONSTRAINT [IX_CHCNPORTAL3_UDF_ASP_GROUPS] UNIQUE NONCLUSTERED  ([ASPGROUPID], [ASPSET]) ON [PRIMARY]
GO
