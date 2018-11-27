SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE  PROCEDURE [dbo].[CHCNAuthReq_InsertAuthCPTTemp]

@RequestID varchar(20),
@COMMONID VARCHAR(20), 
@Qty int,
@Modif varchar(2)

as
	
	BEGIN
		SET @RequestID = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(@RequestID,CHAR(9),''),CHAR(10),''),CHAR(13),'')))	
		SET @COMMONID = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(@COMMONID,CHAR(9),''),CHAR(10),''),CHAR(13),'')))	

		INSERT INTO CHCNAuthReq_CPT_Temp (RequestID, Common_ID, PHCode, ProcCode, ProcDesc, Qty, Modif)
		SELECT @RequestID, P.Common_ID, P.PHCode, LTRIM(RTRIM(p.SVCCODE)), p.SvcDesc, @Qty, @Modif
		FROM  [EZCAP65TEST].[EZCAPDB].[DBO].[SERVICE_CODES_V] P
		WHERE P.Common_ID = @CommonID
				
		Return 1
	END
	 




GO
