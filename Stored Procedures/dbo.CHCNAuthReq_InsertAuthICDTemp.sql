SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








CREATE   PROCEDURE [dbo].[CHCNAuthReq_InsertAuthICDTemp]

@RequestID varchar(20),
@DiagCode varchar(10),
@DiagDesc varchar(200)

as
DECLARE @prevDIAGREFNO int

SET @RequestID = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(@RequestID,CHAR(9),''),CHAR(10),''),CHAR(13),'')))
SET @DiagCode = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(@DiagCode,CHAR(9),''),CHAR(10),''),CHAR(13),'')))
SET @DiagDesc = LTRIM(RTRIM(@DiagDesc))

SET @prevDIAGREFNO = (SELECT count(*) FROM CHCNAuthReq_ICD_Temp WHERE RequestID=@RequestID) 

IF (SELECT count(*) FROM CHCNAuthReq_ICD_Temp WHERE RequestID=@RequestID and DiagCode=@DiagCode) = 0
	BEGIN 
		INSERT INTO CHCNAuthReq_ICD_Temp (RequestID, Common_ID, DiagCode, DiagDesc, DIAGREFNO)
		SELECT  @RequestID, r.Common_ID, @DiagCode, @DiagDesc, (@prevDIAGREFNO + 1)
		FROM [EZCAP65TEST].[EZCAPDB].[dbo].[DIAG_CODES_V] as r
		WHERE r.currhist='C' and ltrim(rtrim(r.DiagCode)) = @DiagCode
			
		RETURN 1
	END
ELSE
	BEGIN
		RETURN -1
	END











GO
