SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


















CREATE       PROCEDURE [dbo].[CHCNWEB_MAKE_CHCN_PCPS_6X]

AS


--Use this code to create CHCNWEB_CHCN_PCPS new table and populate, otherwise truncate and fill
--Pulls from EZCAP65TEST production database using Linked Server connection
--Edited to pull from EZCAP65TEST server, 05/30/2008, CTA
	
/*
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CHCNWEB_CHCN_PCPS]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[CHCNWEB_CHCN_PCPS]

CREATE TABLE [dbo].CHCNWEB_CHCN_PCPS (ID int IDENTITY(1,1), VENDOR varchar(20), LASTNAME varchar(40),FIRSTNAME varchar(25),
		REVFN varchar(67), PROVID varchar(20), FULLNAME varchar(67), SITE varchar(10), SPECIALTY varchar(50), SPECCODE varchar(10))
*/
	
-------------------------------------------------------------------------------
-- Remark code below if table does not exist and use above code. Remark Create Index lines.
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CHCNWEB_PCPS]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
TRUNCATE TABLE [dbo].CHCNWEB_PCPS
			
--------------------------------------------------------------------------------
INSERT INTO [dbo].CHCNWEB_PCPS
SELECT PROV_KEYID, VENDOR, LASTNAME,FIRSTNAME,
	REVFN, PROVID, FULLNAME, [SITE], SPECIALTY, SPECCODE, NPI
FROM [EZCAP65TEST].[EZCAPDB].[dbo].[CHCNWEB_PCPS_VS]



/*
CREATE INDEX WEB_ID on CHCNWEB_CHCN_PCPS(ID)
CREATE INDEX WEB_LN on CHCNWEB_CHCN_PCPS(LASTNAME)
CREATE INDEX WEB_PROVID on CHCNWEB_CHCN_PCPS(PROVID)
CREATE INDEX WEB_VENDORID on CHCNWEB_CHCN_PCPS(VENDOR)
CREATE INDEX WEB_SITE on CHCNWEB_CHCN_PCPS(SITE)
*/




























GO
