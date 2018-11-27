SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO




CREATE PROCEDURE [dbo].[CHCNPORTAL_MAKE_SPECIALISTS]

AS

--Use this code to create CHCNPORTAL_SPECIALISTS new table and populate, otherwise truncate and fill
--Pulls from EZCAP65TEST production database using Linked Server connection
--Edited to pull from EZCAP65TEST server, 11/01/2009, CTA
	
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CHCNPORTAL_SPECIALISTS]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[CHCNPORTAL_SPECIALISTS]

CREATE TABLE CHCNPORTAL_SPECIALISTS (ID int IDENTITY(1,1),PROV_KEYID uniqueidentifier, FULLNAME varchar(8000), LASTNAME varchar(40),FIRSTNAME varchar(30),PROVID varchar(25), STREET varchar(80), CITY varchar(80), ZIP varchar(10), PHONE varchar(12),
		FAX varchar(12), HOSPITAL varchar(40), DESCR varchar(300), CODE varchar(50), 
                MEMOLINE3 varchar(82), LANGUAGE varchar(300), MEDICAL_GROUP varchar(75), CONTRACT varchar(50))

	
-------------------------------------------------------------------------------
-- Remark code below if table does not exist and use above code. Remark Create Index lines.
-- if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CHCNPORTAL_SPECIALISTS]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
-- TRUNCATE TABLE CHCNPORTAL_SPECIALISTS
			
--------------------------------------------------------------------------------
INSERT INTO CHCNPORTAL_SPECIALISTS
SELECT *
FROM [EZCAP65TEST].[EZCAPDB].[dbo].[CHCNPORTAL_SPECIALISTS_VS]

CREATE INDEX WEB_ID2 on CHCNPORTAL_SPECIALISTS(ID)
CREATE INDEX WEB_LN2 on CHCNPORTAL_SPECIALISTS(LASTNAME)
CREATE INDEX WEB_PROVIDKEYID on CHCNPORTAL_SPECIALISTS(PROV_KEYID)
CREATE INDEX WEB_PROVID2 on CHCNPORTAL_SPECIALISTS(PROVID)
CREATE INDEX WEB_CODE2 on CHCNPORTAL_SPECIALISTS(CODE)
CREATE INDEX WEB_CITY2 on CHCNPORTAL_SPECIALISTS(CITY)




GO
