SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







CREATE  PROCEDURE [dbo].[CHCNPDR_InsertDraft]

@RequestID VARCHAR(30), 
@UserID INT,
@ClaimNo VARCHAR(25),
@RetValue VARCHAR(200) OUTPUT

AS

BEGIN

SET @RequestID = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(@RequestID,CHAR(9),''),CHAR(10),''),CHAR(13),'')))	

IF (SELECT COUNT(*) FROM CHCNPDR_Master WHERE RequestID=@RequestID) <> 0 
	BEGIN
		SET @RetValue = 'Duplicate RequestID Exists'
		RETURN
	END
IF NULLIF(@ClaimNo,'') IS NULL
	BEGIN
		SET @RetValue = 'No Claim Number Provided'
		RETURN
	END

INSERT INTO CHCNPDR_Master (RequestID, UserID, ClaimNo, EnterDate, LastChangeBy, LastChangeDate) 
VALUES (@RequestID, @UserID, @ClaimNo, GETDATE(), @UserID, GETDATE())

END









GO
