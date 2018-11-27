SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO











-- Include RENDPROVID filter to allow lookup
-- by Rendering Provider, CTA, 11/09/2009
-- Added code to strip out hyphens from COMPANYID comparison SK.5/17/2016
CREATE        PROCEDURE [dbo].[CHCNWEB_GetAuthsMulti]

@COMPANYIDLIST varchar(150),
@LASTNM varchar(30),
@FIRSTNM varchar(30),
@Patid varchar(15),
@DOB datetime,
@FROMDT datetime,
@TODT datetime

as

SET @COMPANYIDLIST = REPLACE(@COMPANYIDLIST,'-','') 

SELECT DISTINCT 
                      AUTHNUMBER = CASE WHEN STATUSCODE <> '1' THEN 'NONE' ELSE 'AUTHNO' END, 
                      AUTHNO, COMPANY_ID, MEMBNAME, STATUS, 
                      CONVERT(char(10),REQDATE, 101) As REQDATE, CONVERT(char(10),AUTHDATE,101) AS AUTHDATE, 
		      CONVERT(char(10),EXPRDATE,101) AS EXPRDATE, REQPROV, 
                      RQPROVID, RENDPROV, MEMBID, 
                      LASTNM, FIRSTNM, CONVERT(char(10),BIRTH,101) As BIRTH, PATID, 
                      CLINIC, PCP
FROM    CHCNWEB_AUTHS
WHERE  ((CHARINDEX(REPLACE(COMPANY_ID,'-',''),@CompanyIDList)>0 or CHARINDEX(REPLACE(RQPROVID,'-',''), @CompanyIDList)>0 or CHARINDEX(REPLACE(RENDPROVID,'-',''), @CompanyIDList)>0 or CHARINDEX(REPLACE(CLINIC,'-',''), @CompanyIDList)>0)) AND
	((LASTNM = @LASTNM) or (LASTNM LIKE @LASTNM + '%') or (@LASTNM is null)) and	
	((FIRSTNM = @FIRSTNM) or (FIRSTNM LIKE @FIRSTNM + '%') or (@FIRSTNM is null))and	
	((PATID = @Patid) or (PATID LIKE @Patid + '%') or (@PATID is null)) and
	((BIRTH = @DOB) or (@DOB is null)) and
	((REQDATE BETWEEN @FROMDT AND @TODT) or ((@FROMDT is null) AND (@TODT is null))) 
ORDER BY LASTNM ASC, FIRSTNM ASC, BIRTH ASC, REQDATE ASC



































GO
