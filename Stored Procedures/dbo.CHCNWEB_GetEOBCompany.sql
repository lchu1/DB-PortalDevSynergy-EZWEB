SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- Added code to strip out hyphens from COMPANYID comparison SK.5/17/2016
CREATE             PROCEDURE [dbo].[CHCNWEB_GetEOBCompany]

-- 08/30/2012 CTA, updated for 6 digit check numbers
-- Added Type filed to capture vendor contract code
-- UPDATED TO ACCOMODATE EFTNO, CTA, 10/03/2014

@COMPANYID varchar(25),
@DTCHKLIST varchar(40)

AS

SET @COMPANYID = REPLACE(@COMPANYID,'-','') 

SELECT  DISTINCT   MEMBNAME,CONVERT(char(10),BIRTH,101) AS DOB,PROVCLAIM, OPT,PATID,
	 CLAIMNO, LTRIM(PROCCODE) AS PROCCODE, MODIF, MODIF2, CONVERT(char(10),FROMDATESVC,101) AS DOSFROM,
         CONVERT(char(10),TODATESVC,101) AS DOSTO, CAPITATED, SEQUENCE, BILLED, CONTRVAL, 
	 COPAY, ADJUST, ADJCODE, COMMENTS, PMTSTATUS, NET, WITHHOLD, INTEREST,CHECK_REF = CASE WHEN CHECKNO='0' THEN 'NO CHECK' WHEN CHPREFIX = '0' AND NULLIF(CHECKNO,'')
	  IS NOT NULL THEN RTRIM(CONVERT(CHAR(80),CHECKNO))  ELSE RTRIM(CONVERT(CHAR(10),CHPREFIX))+' - ' + RTRIM(CONVERT(CHAR(80),CHECKNO)) END,
	 CONVERT(char(10), DATEPAID, 101) AS DATEPD, VENDORID, VENDORNM, STREET, CITY,
	 STATE, ZIP, VENDNPI, MCALID, Type
FROM       CHCNWEB_EOB
WHERE     REPLACE(VENDORID,'-','') = @COMPANYID AND (CONVERT(VARCHAR,DATEPAID,1) = RTRIM(LEFT(@DTCHKLIST,8))) AND 
	  (CHECKNO = CASE WHEN RTRIM(SUBSTRING(@DTCHKLIST,12,80))like '%CHECK%' THEN '0' ELSE RTRIM(SUBSTRING(@DTCHKLIST,12,80)) END)


























GO
