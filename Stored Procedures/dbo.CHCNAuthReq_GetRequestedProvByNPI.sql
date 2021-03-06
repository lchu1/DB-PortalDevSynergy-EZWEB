SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







--SK 8/11/2017
CREATE PROCEDURE [dbo].[CHCNAuthReq_GetRequestedProvByNPI]

@IN_NPI  VARCHAR(25) -- Search Criteria

AS 

SELECT DISTINCT PROV_KEYID, PROVID, FULLNAME, MEDICAL_GROUP, DESCR AS SPECIALTY, CITY, STREET,
CASE	WHEN [CONTRACT] = 'N' THEN 'No' ELSE 'YES' END AS [CONTRACT], SPECCODE, 
CASE	WHEN PHONE IS NULL OR PHONE = '--' OR PHONE = '-' THEN '' ELSE PHONE END AS PHONE,
CASE	WHEN FAX IS NULL OR FAX = '--' OR FAX = '-' THEN '' ELSE FAX END AS FAX, CLASS AS PROVCLASS, CLASS_DESC AS PROVCLASS_DESC
,NPINO, VENDOR_NPI
FROM  [EZCAP65TEST].[EZCAPDB].DBO.CHCNPORTAL_SPECIALISTS_RVS
WHERE  (NPINO LIKE @IN_NPI+'%' OR VENDOR_NPI LIKE @IN_NPI+'%') AND PROVID NOT IN ('UNKNOWNNPI', 'UNKNOWNNPI2') AND CLASS <> 'H' --AND SPECCODE <> N'HOS'
ORDER BY FULLNAME ASC






GO
