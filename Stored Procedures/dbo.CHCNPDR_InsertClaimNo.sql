SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







--SK 11/30/2016
CREATE  PROCEDURE [dbo].[CHCNPDR_InsertClaimNo]

@RequestID VARCHAR(30), 
@ClaimNo VARCHAR(25), 
@Sequence INT

AS

BEGIN

SET @RequestID = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(@RequestID,CHAR(9),''),CHAR(10),''),CHAR(13),'')))	

IF NULLIF(@RequestID,'') IS NULL OR NULLIF(@ClaimNo,'') IS NULL OR @Sequence IS NULL
	RETURN
ELSE
	BEGIN		
		INSERT INTO CHCNPDR_ClaimMulti (RequestID, ClaimNo, Sequence, EnterDate) 
		VALUES (@RequestID, @ClaimNo, @Sequence, GETDATE())
	END


END










GO
