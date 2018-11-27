SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- =============================================
-- Synergy 07/13/2016
-- Insert Local Admin Referral Response
-- =============================================
CREATE PROCEDURE [dbo].[CHCNPortal3_InsertReferralResponse]
	
	@UserID VARCHAR(5),
	@Response VARCHAR(MAX)
	
AS
IF @UserId IS NULL OR @Response IS NULL 
	RETURN
ELSE
BEGIN	
  INSERT INTO CHCNPORTAL_LocalAdminReferralResponse (UserID, Response, CreatedOnDate)
	VALUES (@UserID, @Response, GETDATE())
END






GO
