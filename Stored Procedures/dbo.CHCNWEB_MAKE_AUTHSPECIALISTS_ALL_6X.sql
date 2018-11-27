SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO




CREATE  PROCEDURE [dbo].[CHCNWEB_MAKE_AUTHSPECIALISTS_ALL_6X]

AS


--Use this code to create CHCNWEB_SPECIALISTS new table and populate, otherwise truncate and fill
--Pulls from EZCAP production database using Linked Server connection
--Edited to pull from EZCAPDB server, 05/30/2008, CTA
--Changed MEDICAL_GROUP friom varchar(40) to varchar(45), CTA, 04/18/2014
	
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CHCNPORTAL_AUTHSPECIALISTS_ALL]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[CHCNPORTAL_AUTHSPECIALISTS_ALL]

CREATE TABLE CHCNPORTAL_AUTHSPECIALISTS_ALL (ID int IDENTITY(1,1),PROV_KEYID UNIQUEIDENTIFIER, FULLNAME varchar(80), LASTNAME varchar(40),FIRSTNAME varchar(25),
		PROVID varchar(20), STREET varchar(40), CITY varchar(30), ZIP varchar(10), PHONE varchar(12),
		FAX varchar(12), HOSPITAL varchar(40), DESCR varchar(30), CODE varchar(3), 
                MEMOLINE3 varchar(80), LANGUAGE varchar(30), MEDICAL_GROUP varchar(45), CONTRACT varchar(1))

	
-------------------------------------------------------------------------------
-- Remark code below if table does not exist and use above code. Remark Create Index lines.
-- if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CHCNWEB_SPECIALISTS]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
-- TRUNCATE TABLE CHCNWEB_SPECIALISTS
			
--------------------------------------------------------------------------------
INSERT INTO CHCNPORTAL_AUTHSPECIALISTS_ALL
SELECT PROV_KEYID, LEFT(FULLNAME,80),LEFT(LASTNAME,40),LEFT(FIRSTNAME,25),
		LEFT(PROVID, 20), LEFT(STREET,80), LEFT(CITY,30),LEFT(ZIP,10), LEFT(PHONE,12),LEFT(FAX, 12), LEFT(HOSPITAL,40), LEFT(DESCR,30), LEFT(CODE,3),LEFT(MEMOLINE3,80), LEFT(LANGUAGE, 30), LEFT(MEDICAL_GROUP, 45), LEFT(CONTRACT,1)
FROM [EZCAP65TEST].[EZCAPDB].[dbo].[CHCNPORTAL_AUTHSPECIALISTS_VS]

CREATE INDEX AUTHSPEC_ID on CHCNPORTAL_AUTHSPECIALISTS_ALL(ID)
CREATE INDEX AUTHSPEC_LN on CHCNPORTAL_AUTHSPECIALISTS_ALL(LASTNAME)
CREATE INDEX AUTHSPEC_PROVID on CHCNPORTAL_AUTHSPECIALISTS_ALL(PROVID)
CREATE INDEX AUTHSPEC_CODE on CHCNPORTAL_AUTHSPECIALISTS_ALL(CODE)
CREATE INDEX AUTHSPEC_CITY on CHCNPORTAL_AUTHSPECIALISTS_ALL(CITY)




GO
