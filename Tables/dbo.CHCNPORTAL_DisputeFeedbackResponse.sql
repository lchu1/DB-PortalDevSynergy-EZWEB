CREATE TABLE [dbo].[CHCNPORTAL_DisputeFeedbackResponse]
(
[UserID] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Response] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreatedOnDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
