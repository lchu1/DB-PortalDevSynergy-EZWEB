SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- =============================================
-- Author:		CHCN
-- Create date: 11/23/2015
-- Description:	Checks for at least one matching entry with the supplied NPI and Tax ID values.
-- =============================================
CREATE  PROCEDURE [dbo].[CHCNPortal3_ValidateVendor]
	@TAXID VARCHAR(11),
	@NPI VARCHAR(25)
AS
IF @TAXID IS NULL OR @NPI IS NULL 
	RETURN
ELSE
BEGIN
	SET @TAXID = REPLACE(@TAXID,'-','')
	SELECT COUNT(*) FROM [EZCAP65TEST].[EZCAPDB].[dbo].[VEND_MASTERS_V] WHERE REPLACE(VENDORID,'-','') = @TAXID --AND VENDOR_NPI = @NPI SK.1/29/2016 Commented out to not validate NPI
END



GO
