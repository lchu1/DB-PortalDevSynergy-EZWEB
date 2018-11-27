SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO















CREATE     PROCEDURE [dbo].[CHCNWEB_MAKE_CHCELIG_6X]

AS


--Use this code to create CHCNWEB_CHCELIG new table and populate, otherwise truncate and fill
--Pulls from EZCAP65TEST production database using Linked Server connection
--Edited to pull from EZCAP65TEST server, 05/30/2008, CTA
-- Updated to remove truncation problems, CTA, 09/14/2012
	
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CHCNWEB_CHCELIG]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[CHCNWEB_CHCELIG]

CREATE TABLE CHCNWEB_CHCELIG (
CHC char(10),
COMPANY varchar(40), 
EFFDATE datetime, 
TERMDATE datetime,
PATID varchar(15), 
[PLAN] varchar(4), 
MEMBSSN varchar(9), 
LASTNM varchar(35),
FIRSTNM varchar(25),
STREET varchar(40), 
CITY varchar(30),
ZIP varchar(10), 
DOB datetime, 
SEX varchar(1), 
PHONE varchar(20),
[LANGUAGE] varchar(30),
MCAL10 varchar(40),
OTHERID2 varchar(40),
SITE varchar(20),
TRANCODE varchar(1), 
TRANDATE datetime, 
VENDORID varchar(20), 
HMO varchar(2), 
MEMBID varchar(20), 
HIC varchar(30),
MCARE_A datetime, 
MCARE_B datetime, 
CCS varchar(30), 
CCSDT datetime, 
COB varchar (20),
HFPCOPAY varchar(40),
AC VARCHAR(40) 
)

	
-------------------------------------------------------------------------------
-- Remark code below if table does not exist and use above code. Remark Create Index lines.
-- if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CHCNWEB_CHCELIG]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
-- TRUNCATE TABLE CHCNWEB_CHCELIG
			
--------------------------------------------------------------------------------
INSERT INTO CHCNWEB_CHCELIG (CHC, COMPANY, EFFDATE, TERMDATE,PATID, [PLAN], MEMBSSN, LASTNM,FIRSTNM,STREET, CITY,ZIP, DOB, 
SEX, PHONE,[LANGUAGE],MCAL10,OTHERID2,SITE,TRANCODE, TRANDATE, VENDORID , HMO, MEMBID, HIC,MCARE_A, MCARE_B, CCS, 
CCSDT, COB,HFPCOPAY,AC)
SELECT LEFT(CHC,10),LEFT(COMPANY,40),EFFDATE, TERMDATE,LEFT(PATID,15),LEFT([PLAN],4),LEFT(MEMBSSN, 9),LEFT(LASTNM,35),
LEFT(FIRSTNM,25), LEFT(STREET,40), LEFT(CITY,30),LEFT(ZIP,10), DOB datetime, LEFT(SEX,1), LEFT(PHONE,20),LEFT(LANGUAGE, 30),
LEFT(MCAL10,40),LEFT(OTHERID2,40),LEFT(SITE,20),LEFT(TRANCODE,1), TRANDATE datetime, LEFT(VENDORID,20), LEFT(HMO,2), 
LEFT(MEMBID,20), LEFT(HIC,30),MCARE_A datetime, MCARE_B datetime, LEFT(CCS,30), CCSDT datetime, LEFT(COB,20),LEFT(HFPCOPAY,40),
LEFT(AC,40)
FROM [EZCAP65TEST].[EZCAPDB].[dbo].[CHCNWEB_CHC_ELIG_VS]

CREATE INDEX WEB_VENDORID on CHCNWEB_CHCELIG(VENDORID)
CREATE INDEX WEB_HMO on CHCNWEB_CHCELIG(HMO)


























GO
