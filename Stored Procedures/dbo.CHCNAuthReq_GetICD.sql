SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





CREATE PROCEDURE [dbo].[CHCNAuthReq_GetICD]

@RequestID varchar(30),
@ICD varchar (20),
@VERSION int

as

If @RequestID IS NULL OR @ICD IS NULL 
	BEGIN
	RETURN
	END
ELSE
	BEGIN
	SET @RequestID = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(@RequestID,CHAR(9),''),CHAR(10),''),CHAR(13),'')))
	SET @ICD = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(@ICD,CHAR(9),''),CHAR(10),''),CHAR(13),'')))	
	
	SELECT  DISTINCT COMMON_ID,DIAGCODE, DIAGDESC
	FROM    [EZCAP65TEST].[EZCAPDB].[dbo].[DIAG_CODES_V]
	WHERE CURRHIST='C' AND [version]=@VERSION AND((ltrim(rtrim(diagcode)) like @ICD+'%') or 
	(charindex(@ICD,diagdesc) > 0)) and (Ltrim(Rtrim(DiagCode)) not in(select Ltrim(Rtrim(DiagCode)) 
	from CHCNAuthReq_ICD_Temp where RequestID = @RequestID))

	END




GO
