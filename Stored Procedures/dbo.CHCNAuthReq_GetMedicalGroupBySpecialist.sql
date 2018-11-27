SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE PROCEDURE [dbo].[CHCNAuthReq_GetMedicalGroupBySpecialist]

@SPECCODE VARCHAR(3)   -- passed from drop down list 

AS

SELECT '--Select a Medical Group (Optional)--' as MEDICAL_GROUP
UNION
SELECT DISTINCT MEDICAL_GROUP
FROM  [EZCAP65TEST].[EZCAPDB].DBO.CHCNPORTAL_SPECIALISTS_RVS
WHERE SPECCODE = @SPECCODE and [CONTRACT] <> 'N'
ORDER BY MEDICAL_GROUP ASC




GO
