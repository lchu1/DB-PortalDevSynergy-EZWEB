SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- =============================================
-- Synergy 07/13/2016
-- Inert
-- =============================================
CREATE PROCEDURE [dbo].[CHCNPORTAL_LOG_EMAIL_ENTRY]

	@UserID VARCHAR(5),
	@Template VARCHAR(MAX),
	@Date DATETIME,
	@Email VARCHAR(50)

AS
IF @UserId IS NULL OR @Template IS NULL OR @Email IS NULL
	RETURN
ELSE
BEGIN
  INSERT INTO CHCNPORTAL_LOG_EMAIL_TABLE(UserID, Template, Date, Email)
	VALUES (@UserID, @Template, @Date, @Email)
END






GO
