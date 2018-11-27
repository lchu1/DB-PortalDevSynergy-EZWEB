SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


-- UPDATED TO USE STATIC TABLE, REFRESHED NIGHTLY, CTA, 03/11/2014
CREATE   PROCEDURE [dbo].[CHCNPORTAL_GetMemberHistory]

@MEMBKEYID VARCHAR(MAX)

AS

SELECT DISTINCT VENDOR, MEMBID, PCPFROMDT, PCPTHRUDT, PCP, 
	COMPANY_ID, OPTNAME
FROM  [dbo].[CHCNPORTAL_MEMB_HISTORY]-- [EZCAPDB2].[EZCAPDB].[DBO].[CHCNPORTAL_MEMB_HIST_VS]
WHERE    (CAST(MEMB_KEYID AS VARCHAR(MAX)) = @MEMBKEYID)
ORDER BY PCPFROMDT DESC  



GO
