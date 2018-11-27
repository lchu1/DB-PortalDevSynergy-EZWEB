SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO









-- UPDATED TO USE EZWEB.DBO.CHCNPORTAL_CLAIM_DETAILS TABLE - REFRESHED NIGHTLY
-- ADDED MODIFIER 2-4,COPAY, REMMITTANCE CODE AND DESCRIPTION PER SHAWNA LA CHAPELLE
-- CTA 01/22/2014
-- Updated to use [EZCAP65TEST].[EZCAPDB].[dbo].[CHCNPORTAL_CLAIMDETAILS_VS2], 01/28/2016, CTA  

CREATE PROCEDURE [dbo].[CHCNPortal_GetMemberClaimDetails]

@CLAIMNO VARCHAR(25)

AS

IF @CLAIMNO IS NULL 
	BEGIN
	RETURN
	END
ELSE
BEGIN

SELECT   DISTINCT VENDOR,COMPANY_ID, PROCCODE, QTY, PROVID, REV_FULLNAME, DATEPAID, CHECKNO, ADJCODE, NET, 
                      MODIF, DESCR, BILLED, DIAGCODE, DIAGDESC, CLAIMNO, DATERECD,DATEFROM, 
                      DATETO, CASENO, STATUS, TOTALNET, OPTDESC AS OPTNAME,IMAGE_URL, VENDORNM, MEMBID, --NOTES, --SK.3/1/2017 Commented out non-used column (Duplicate record issue)
					  MODIF2, MODIF3,MODIF4,COPAY, REMITT_CODE, REMITT_DESC, AUTHNO, FACILITY, MEMBNAME, SEQUENCE --SK.12/16/2016 Added for PDR module
FROM    [EZCAP65TEST].[EZCAPDB].[dbo].[CHCNPORTAL_CLAIMDETAILS_VS2]
WHERE     (CLAIMNO = @CLAIMNO) AND LINEFLAG NOT IN ('R','X')
ORDER BY SEQUENCE

END






GO