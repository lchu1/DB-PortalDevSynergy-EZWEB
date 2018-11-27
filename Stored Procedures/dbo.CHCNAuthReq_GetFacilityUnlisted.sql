SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE PROCEDURE [dbo].[CHCNAuthReq_GetFacilityUnlisted]

AS

SELECT DISTINCT P.PROVID, P.PROV_KEYID, P.FULLNAME, PA.STREET, PA.CITY
FROM [EZCAP65TEST].[EZCAPDB].DBO.PROV_COMPANY_V P 
LEFT JOIN [EZCAP65TEST].[EZCAPDB].DBO.PROV_ADDINFO_V PA ON P.PROV_KEYID=PA.PROV_KEYID
WHERE PROVID='UNKNOWNNPI2'






GO
