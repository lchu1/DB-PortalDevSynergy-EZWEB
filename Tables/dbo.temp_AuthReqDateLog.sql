CREATE TABLE [dbo].[temp_AuthReqDateLog]
(
[RequestID] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AUTHNO] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[EzcapREQDATE] [datetime] NOT NULL,
[CorrectREQDATE] [datetime] NULL,
[CREATEBY] [int] NULL,
[CREATEDATE] [datetime] NOT NULL,
[LASTCHANGEBY] [int] NULL,
[LASTCHANGEDATE] [datetime] NOT NULL,
[EnterDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
