SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


-- UPDATED TO USE STATIC TABLE, REFRESHED NIGHTLY, CTA, 03/11/2014 
CREATE  PROCEDURE [dbo].[CHCNPortal_GetMemberOthCov]

@MEMBKEYID VARCHAR(MAX)

AS

SELECT DISTINCT MEMBID, [TYPE] AS DESCRIPTION, OUTSIDEID, CONVERT(char(10),FROMDATE,101) AS FROMDATE, CONVERT(char(10),TODATE,101) AS TODATE
FROM CHCNPORTAL_MEMB_OTHCOV -- EZCAPDB2].[EZCAPDB].[dbo].[CHCN_OMID_VS]
WHERE     (CAST(MEMB_KEYID AS VARCHAR(MAX)) = @MEMBKEYID)  AND [TYPE] <> 'PROV' 
ORDER BY FROMDATE 



GO