CREATE TABLE [dbo].[CHCNPORTAL_LocalAdmin]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[UserID] [int] NULL,
[TaxID] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NPI] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EnterDate] [datetime] NULL,
[IsValidated] [bit] NULL,
[IsActivated] [bit] NULL,
[ActivatedDate] [datetime] NULL
) ON [PRIMARY]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- SK.1/13/2016
-- Trigger to enter the record create date
-- =============================================
CREATE TRIGGER [dbo].[LocalAdminNPIInsert] 
   ON  [dbo].[CHCNPORTAL_LocalAdmin]
   AFTER INSERT
AS 
BEGIN
	
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    UPDATE a
    SET EnterDate = GETDATE()
    FROM CHCNPORTAL_LocalAdmin a 
		JOIN Inserted i ON a.ID = i.ID
    

END

GO
ALTER TABLE [dbo].[CHCNPORTAL_LocalAdmin] ADD CONSTRAINT [PK_CHCNPORTAL_LocalAdmin] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
