SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





CREATE     procedure [dbo].[CHCNWEB_MAKE_EOB_6X]


as

-------------------------------------------------------------------------------
--Use this code to create new CHCNWEB_EOB table and populate, otherwise truncate and fill
--Pulls from EZCAP65TEST production database via Linked Server connection
--Edited to include NULL checks
--Edit to use PROVCLAIM when vendor is CHCN PCP or BayImaging, else CROSSREFID, 03/04/2008 CTA
--Edit to include matching on Memb_KeyId to eliminate possible dup records associated with AACC member, 03/28/2008 CTA 
--Edited to pull from EZCAP65TEST server, 11/01/2009, CTA
--Added vendor NPI for CHCs, 08/12/2008 CTA
--Added logic to pull PROVCLAIM field for Office Ally claims, CEP and BEMG, 08/14/2008
--Added Claim Details Withhold field, 10/09/2008, CTA
--Filter on Claim_Adjusts.Sequence = 1, to remove dup records (multiple adjustments per detail line), 02/09/2009 CTA
--Increased claimno width to 25, CTA 11/01/2009
--Added MODIF2 Field, CTA, SLC 07/06/2011
--Added Vendor Type field to capture vendor contract code, CTA, 03/19/2013
--Change CHECKNo to int from varchar(6), VENDORNM from varchar(40) to varchar(75), CTA< 04/18/2014 
--Added NAHC tax id to VENDORID filter,CTA, 04/18/2014
-- Changed CHECKNO to varchar(80)to accomodate EFTNO, 10/03/2014, CTA
-- Updated COMMENTS filed to varchar(1000) from (255), CTA, 04/16/2015
-- Added WHEN CM.PROVCLAIM IS NOT NULL THEN CM.PROVCLAIM criteria to PROVCLAIM CASE statement, CTA, 01/05/2016 
	
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CHCNWEB_EOB]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[CHCNWEB_EOB]

CREATE TABLE CHCNWEB_EOB (CLAIMNO varchar(25),PROCCODE varchar(15), MODIF varchar(2), MODIF2 varchar(2), FROMDATESVC datetime, BILLED decimal(10,2), 
		      CONTRVAL decimal(15,2), COPAY decimal(15,2), ADJUST decimal(15,2), ADJCODE varchar(7), NET decimal(15,2), WITHHOLD decimal (15,2),
		      TODATESVC datetime, CAPITATED decimal(1,0), SEQUENCE smallint, STATUS varchar(2), DATEPAID datetime, 
		      CHPREFIX int, CHECKNO varchar(80), INTEREST decimal(15,2),LASTNM varchar(40),FIRSTNM varchar(30),MEMBNAME varchar(80),OPT varchar(25), 
		      PROVCLAIM varchar(25),PMTSTATUS varchar(8), COMMENTS varchar(1000), VENDORID varchar(25), 
		      VENDORNM varchar(75), STREET varchar(80), CITY varchar(80),STATE varchar(2), ZIP varchar(10), BIRTH datetime,
		      SEX varchar(1), PATID varchar(25), VENDNPI varchar(25), MCALID varchar(40), Type int, ADJUSTWH decimal(15,2), ADJCODEWH varchar(7))

-------------------------------------------------------------------------------
-- Remark code below if table does not exist and use above code
--if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CHCNWEB_EOB]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
--TRUNCATE sp_helptext proc_nameTABLE CHCNWEB_EOB
-- ADDED EFTNO SELECTION, CTA, 10/02/2014
-- UPDATED SELECT TO USE CLAIM_PMASTER_V INTEREST CHARGES WHEN PLACESVC = 23, CTA, 06/18/2015
			
--------------------------------------------------------------------------------
INSERT INTO CHCNWEB_EOB
(
CLAIMNO, PROCCODE, MODIF, MODIF2, FROMDATESVC, BILLED, CONTRVAL, COPAY, ADJUST, ADJCODE, NET, WITHHOLD, TODATESVC, CAPITATED, SEQUENCE, STATUS, DATEPAID, CHPREFIX, CHECKNO, INTEREST, LASTNM, FIRSTNM, MEMBNAME, OPT, PROVCLAIM, PMTSTATUS, COMMENTS, VENDORID, VENDORNM, STREET, CITY, STATE, ZIP, BIRTH, SEX, PATID, VENDNPI, MCALID, Type, ADJUSTWH, ADJCODEWH

)
SELECT     DISTINCT CD.CLAIMNO, CD.PROCCODE, CD.MODIF,CD.MODIF2, CD.FROMDATESVC, CD.BILLED, 
                      CD.CONTRVAL, CD.COPAY, CD.ADJUST, CD.ADJCODE, CD.NET,CD.WITHHOLD, 
                      CD.TODATESVC, CD.CAPITATED, CD.SEQUENCE, CD.STATUS, CD.DATEPAID, 
                      CD.CHPREFIX, CHECKNO = CASE WHEN NULLIF(CD.EFTNO,'') IS NOT NULL THEN CD.EFTNO WHEN NULLIF(CD.CHECKNO,'') IS NULL AND NULLIF(CD.EFTNO,'') IS NULL THEN '0' ELSE CAST(CD.CHECKNO AS VARCHAR(80)) END, CASE WHEN CM.PLACESVC = '23' AND CD.SEQUENCE = 1 THEN CM.INTEREST WHEN CM.PLACESVC = '23' AND CD.SEQUENCE > 1 THEN 00.00 ELSE CD.INTEREST END AS INTEREST, MC.LASTNM, MC.FIRSTNM,CM.MEMBNAME, CM.OPT, 
PROVCLAIM = CASE 
WHEN VM.VENDORID IN('94-2232394','94-2235908','94-1744108','94-2502308','23-7135928', '23-7255435','23-7118361', '94-1667294') AND CM.PROVCLAIM IS NOT NULL THEN CM.PROVCLAIM  
WHEN 	(REPLACE(VM.VENDORID,'-','') IN(SELECT VENDOR_TAXID FROM [EZCAP65TEST].[EZCAPDB].[dbo].[_CHCNEDI_VENDORS_VS] WHERE SUBMITTERID IN('330897513','GR0091230','DOCUSTREAM','BAYMEDICAL','P70')) AND CHARINDEX('T',CD.CLAIMNO)>0) THEN CM.PROVCLAIM WHEN (REPLACE(VM.VENDORID,'-','') IN(SELECT VENDOR_TAXID FROM [EZCAP65TEST].[EZCAPDB].[dbo].[_CHCNEDI_VENDORS_VS] WHERE SUBMITTERID IN('330897513','GR0091230','DOCUSTREAM','BAYMEDICAL','P70')) AND CHARINDEX('921',CD.CLAIMNO)>0) THEN CM.PROVCLAIM WHEN CM.PROVCLAIM IS NOT NULL THEN CM.PROVCLAIM ELSE CM.CROSSREF_ID END, CM.PMTSTATUS
, CA.COMMENTS
, VM.VENDORID, VM.VENDORNM, VM.STREET, VM.CITY, LEFT(VM.STATE,2) AS STATE, LEFT(VM.ZIP,10) AS ZIP, MC.BIRTH, MC.SEX, MC.PATID, VM.VENDEREXTID AS VENDNPI, MM.MEMOLINE2 AS MCALID, VM.Type
, CD.ADJUSTWH, CD.ADJCODEWH
FROM     [EZCAP65TEST].[EZCAPDB].[dbo].[CLAIM_DETAILS] AS CD WITH(NOLOCK) LEFT OUTER JOIN
         [EZCAP65TEST].[EZCAPDB].[dbo].[CLAIM_PMASTERS_V] AS CM WITH(NOLOCK) LEFT OUTER JOIN 
         [EZCAP65TEST].[EZCAPDB].[dbo].[MEMB_MEMOFLDS] AS MM WITH(NOLOCK) RIGHT OUTER JOIN
         [EZCAP65TEST].[EZCAPDB].[dbo].[MEMB_COMPANY_V] AS MC WITH(NOLOCK) ON MM.MEMB_KEYID = MC.MEMB_KEYID ON CM.MEMB_KEYID = MC.MEMB_KEYID AND CM.MEMBID = MC.MEMBID ON CD.CLAIMNO = CM.CLAIMNO LEFT OUTER JOIN
         [EZCAP65TEST].[EZCAPDB].[dbo].[VEND_MASTERS_vs] AS VM WITH(NOLOCK) ON CM.VENDOR = VM.VENDORID AND ISDEFAULT = 1 LEFT OUTER JOIN -- ADDED ISDEFAULT CRITERIA TO REMOVE POTENTIAL DUPS, CTA, 11/03/2014
         [EZCAP65TEST].[EZCAPDB].[dbo].[CLAIM_ADJUSTS] AS CA WITH(NOLOCK) ON CD.CLAIMNO = CA.CLAIMNO AND CD.TBLROWID = CA.CLAIMTBLROW AND CD.LINEFLAG=CA.LINEFLAG--AND CA.SEQUENCE='1' REMOVED 03/16/2010, CTA, ADDED MATCHING OF LINEPLAG TO GET ONE TO ONE MATCH, CTA, 11/03/2014
WHERE     (CD.STATUS = '9') AND CD.LINEFLAG <> 'R' AND -- added exclusion of LineFlag = 'R', CTA, SLC, 07/15/2013
	  (CD.DATEPAID >= CONVERT(char(12), 
                      DATEADD(month, - 6, GETDATE()), 101))

--Remark if table is already created
CREATE INDEX EOB_CLAIMNO ON CHCNWEB_EOB(CLAIMNO)
CREATE INDEX EOB_VENDOR ON CHCNWEB_EOB(VENDORID)
CREATE INDEX EOB_CHECKNO ON CHCNWEB_EOB(CHECKNO)
CREATE INDEX EOB_DATEPD ON CHCNWEB_EOB(DATEPAID)








































GO
