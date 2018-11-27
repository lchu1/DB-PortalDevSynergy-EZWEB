SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- Added code to strip out hyphens from VENDORID comparison SK.5/17/2016

CREATE                 PROCEDURE [dbo].[CHCNWEB_GetCHCProviders]

@VendorID varchar(10)
as

SET @VendorID = REPLACE(@VendorID,'-','') 

SELECT DISTINCT   PROVID, dbo.ProperCase(REPLACE(REVFN, '-', ' ')) AS REVNAME, FULLNAME
FROM         CHCNWEB_CHCN_PCPS
WHERE REPLACE(vendor,'-','') = @VendorID AND FULLNAME IS NOT NULL
ORDER BY REVNAME ASC

























GO
