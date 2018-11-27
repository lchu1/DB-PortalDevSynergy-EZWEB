SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- Added code to strip out hyphens from COMPANYID comparison SK.5/17/2016

CREATE             procedure [dbo].[CHCNWEB_GetCHCTerm]

@COMPANYID varchar(20),
@HMO varchar(10)

as

--Uses last Cap post date as filter
-- ADDED AC FIELD, 09/01/2011, CTA

SET @COMPANYID = REPLACE(@COMPANYID,'-','') 

SELECT     CHC, COMPANY, CONVERT(char(12),EFFDATE,112) AS EFFDATE, 
                      CONVERT(char(12),TERMDATE,112) AS TERMDATE, PATID,[PLAN], 
                      MEMBSSN AS SUBSSN, LASTNM, FIRSTNM, 
                      STREET, CITY, ZIP, CONVERT(char(12),DOB,112) AS DOB, SEX, 
                      PHONE, [LANGUAGE], 
                      MCAL10, OTHERID2, SITE, MEMBID, HIC,
	   CONVERT(char(12),MCARE_A,112) AS MCARE_A, CONVERT(char(12), MCARE_B,112) AS MCARE_B, 
	   CCS, CONVERT(char(12),CCSDT,112) AS CCSDT, COB, HFPCOPAY, AC
                      
FROM         CHCNWEB_CHCELIG
WHERE     TRANCODE = 'T' AND (TERMDATE IS NOT NULL OR
                      TERMDATE <= GETDATE()) AND (REPLACE(VENDORID,'-','') = @COMPANYID) AND 
 (TRANDATE >= (SELECT CONVERT(char(10), DATEADD(month, - 1,MAX(POSTDATE)), 101) AS Date
FROM  [EZCAP65TEST].[EZCAPDB].[dbo].CAP_MM_HIST)) AND (HMO = @HMO)

/*WHERE     TRANCODE = 'T' AND (TERMDATE IS NOT NULL OR
                      TERMDATE <= GETDATE()) AND (VENDORID = @COMPANYID) AND 
 (TRANDATE >= LEFT(CONVERT(char(12), DATEADD(month, - 1, GETDATE()), 101), 2) + '/' + '14' + '/' + RIGHT(CONVERT(char(12), DATEADD(month, - 1, GETDATE()), 101), 4))AND 
(HMO = @HMO)
*/






















GO
