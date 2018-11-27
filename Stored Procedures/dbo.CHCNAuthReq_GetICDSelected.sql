SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE PROCEDURE [dbo].[CHCNAuthReq_GetICDSelected]

@RequestID varchar(20)

as

SET @RequestID = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(@RequestID,CHAR(9),''),CHAR(10),''),CHAR(13),'')))

SELECT ID, RequestID, DiagCode, DiagDesc
FROM CHCNAuthReq_ICD_Temp 
WHERE RequestID = @RequestID






GO
