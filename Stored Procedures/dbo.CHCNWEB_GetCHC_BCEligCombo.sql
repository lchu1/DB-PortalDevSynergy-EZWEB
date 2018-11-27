SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- Added code to strip out hyphens from COMPANYID comparison SK.5/17/2016

CREATE            procedure [dbo].[CHCNWEB_GetCHC_BCEligCombo]

@COMPANYID varchar(20),
@HMO varchar(10)

as

--Uses last Cap post date as transaction date filter
-- ADDED AC FIELD, 09/01/2011, CTA
	
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CHC_BCELIG]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[CHC_BCELIG]

CREATE TABLE [dbo].CHC_BCELIG (CHC char(10), COMPANY varchar(40), EFFDATE varchar(10), TERMDATE varchar(10), PATID varchar(15),
			[PLAN] varchar(20), SUBSSN varchar(9), LASTNM varchar(35), FIRSTNM varchar(25), STREET varchar(40),
			CITY varchar(30), ZIP varchar(10), DOB varchar(10), SEX varchar(1), PHONE varchar(20), LANGUAGE varchar(30),
			MCAL10 varchar (40), OTHERID2 varchar(15), SITE varchar(20), MEMBID varchar(20), HIC varchar(30),
			MCARE_A varchar(10), MCARE_B varchar(10), CCS varchar(30), CCSDT varchar(10), COB varchar (30), HFPCOPAY varchar (30), AC VARCHAR(40))

SET @COMPANYID = REPLACE(@COMPANYID,'-','') 
			
INSERT INTO [dbo].CHC_BCELIG
SELECT     CHC, COMPANY, CONVERT(char(12), EFFDATE, 112) AS EFFDATE, CONVERT(char(12), TERMDATE, 112) AS TERMDATE, PATID, 
                     [PLAN], MEMBSSN, LASTNM,FIRSTNM, STREET, CITY, ZIP, 
                      CONVERT(char(12), DOB, 112) AS DOB, SEX, PHONE, 
                      [LANGUAGE], MCAL10, OTHERID2, SITE, MEMBID, HIC,
	              CONVERT(char(12),MCARE_A,112) AS MCARE_A, CONVERT(char(12), MCARE_B,112) AS MCARE_B, 
		      CCS, CONVERT(char(12),CCSDT,112) AS CCSDT, COB, HFPCOPAY, AC

FROM         [dbo].CHCNWEB_CHCELIG
WHERE     (TERMDATE IS NULL OR
                      TERMDATE >= GETDATE()) AND (REPLACE(VENDORID,'-','') =@COMPANYID) AND 
                      (HMO = @HMO)


INSERT INTO [dbo].CHC_BCELIG
SELECT     CHC, COMPANY, CONVERT(char(12), EFFDATE, 112) AS EFFDATE, 
                      CONVERT(char(12), TERMDATE, 112) AS TERMDATE, PATID, 
                      [PLAN], MEMBSSN, LASTNM, 
                      FIRSTNM, STREET, CITY, ZIP, 
                      CONVERT(char(12), DOB, 112) AS DOB, SEX, PHONE, 
                      [LANGUAGE], MCAL10, OTHERID2, SITE, MEMBID, HIC,
	              CONVERT(char(12),MCARE_A,112) AS MCARE_A, CONVERT(char(12), MCARE_B,112) AS MCARE_B, 
		      CCS, CONVERT(char(12),CCSDT,112) AS CCSDT, COB, HFPCOPAY, AC            
FROM      [dbo].CHCNWEB_CHCELIG
WHERE     TRANCODE = 'T' AND (TERMDATE IS NOT NULL OR
                      TERMDATE <= GETDATE()) AND (REPLACE(VENDORID,'-','') =@COMPANYID) AND 
 (TRANDATE >= (SELECT CONVERT(char(10), DATEADD(month, - 1,MAX(POSTDATE)), 101) AS Date
FROM  [EZCAP65TEST].[EZCAPDB].[dbo].CAP_MM_HIST))AND 
(HMO =@HMO)


SELECT *
FROM [dbo].CHC_BCELIG

























GO
