SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- =============================================
-- Author:		Synergy
-- Description:	Gets Referring Providers based on a User's Tax IDs
-- =============================================
CREATE PROCEDURE [dbo].[CHCNPortal3_GetPCPsMulti]

@COMPANYIDLIST VARCHAR(150)
AS

SET @COMPANYIDLIST = REPLACE(@COMPANYIDLIST,'-','')

SELECT PROV_KEYID, PROVID, REPLACE(REV_FULLNAME, ',', ', ') AS REVNAME, VENDOR
FROM  [EZWEB].[DBO].[REQUESTING_PROV]
WHERE (CHARINDEX(REPLACE(VENDOR, '-', ''), @COMPANYIDLIST) > 0)


GO
