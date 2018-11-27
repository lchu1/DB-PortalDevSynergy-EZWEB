SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- =============================================
-- Author:		Synergy
-- Description:	Returns all requesting providers under a vendor id
-- =============================================
CREATE PROCEDURE [dbo].[CHCNPortal3_GetPCPs]
	@VendorID varchar(10)
AS
SET @VendorID = REPLACE(@VendorID,'-','')

SELECT PROV_KEYID, PROVID, REPLACE(REV_FULLNAME, ',', ', ') AS REVNAME, VENDOR
FROM  [EZWEB].[DBO].[REQUESTING_PROV]
WHERE REPLACE(vendor,'-','') = @VendorID


GO
