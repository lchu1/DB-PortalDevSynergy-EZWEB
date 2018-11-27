SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








create	   PROCEDURE [dbo].[CHCNWEB_MAKE_PATID_REF_6X]

AS


--Use this code to create CHCNWEB_PATID_REF new table and populate, otherwise truncate and fill
--Pulls from EZCAP65TEST production database using Linked Server connection
--Edited to pull from EZCAP65TEST server, 11/01/2009, CTA
	
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CHCNWEB_PATID_REF]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[CHCNWEB_PATID_REF]

create TABLE CHCNWEB_PATID_REF (MEMBID varchar(20),PATID varchar(15))

	
-------------------------------------------------------------------------------
-- Remark code below if table does not exist and use above code. Remark Create Index lines.
-- if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CHCNWEB_PATID_REF]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
-- TRUNCATE TABLE CHCNWEB_PATID_REF
			
--------------------------------------------------------------------------------
INSERT INTO CHCNWEB_PATID_REF
SELECT MEMBID, LEFT(PATID,15) AS PATID
FROM [EZCAP65TEST].[EZCAPDB].[dbo].[_CHCN_PATIDREF_VS]

CREATE INDEX WEB_MEMBID on CHCNWEB_PATID_REF(MEMBID)
CREATE INDEX WEB_PATID on CHCNWEB_PATID_REF(PATID)


















GO
