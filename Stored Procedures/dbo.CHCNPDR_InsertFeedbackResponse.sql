SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- =============================================
-- Synergy 07/13/2016
-- Inert
-- =============================================
CREATE PROCEDURE [dbo].[CHCNPDR_InsertFeedbackResponse]

	@UserID VARCHAR(5),
	@Response VARCHAR(MAX)

AS
IF @UserId IS NULL OR @Response IS NULL
	RETURN
ELSE
BEGIN
  INSERT INTO CHCNPORTAL_DisputeFeedbackResponse (UserID, Response, CreatedOnDate)
	VALUES (@UserID, @Response, GETDATE())
END


GO
