SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


--UPDATED TO USE STATIC TABLE, CHCNPORTAL_AUTH_DETAILS, CTA, 03/11/2014
CREATE PROCEDURE [dbo].[CHCNPortal_GetMemberAuthDetails]

@AUTHNUMBER varchar(25)

AS

If @AUTHNUMBER  IS NULL  
	BEGIN
	RETURN
	END
ELSE
BEGIN

SELECT   DISTINCT AUTHNUMBER, COMPANY_ID, STATUS, AUTHNO, CONVERT(char(10),REQDATE, 101) As REQDATE, 
	 CONVERT(char(10),AUTHDATE,101) AS AUTHDATE, CONVERT(char(10),EXPRDATE,101) AS EXPRDATE, 
	 REQPROV, RQPROVID, RENDPROV, REV_RENDPROV, MEMBID, PROCCODE, [DESCRIPTION] AS DESCR, CASENO, QTY, OPTDESC AS OPTNAME, VENDORNM,PLACESVC, MODIF, PHCODE, CERTTYPE, ONSETDT, CASE WHEN STATUSCODE IN('1','2','3','4','F') AND CERTTYPE IS NOT NULL AND ONSETDT IS NOT NULL THEN '1' ELSE '0' END AS AUTHLTR, MEMBNAME
FROM   [DBO].[CHCNPORTAL_AUTH_DETAILS]
WHERE  (AUTHNUMBER = @AUTHNUMBER)
ORDER BY AUTHNUMBER ASC

END



GO
