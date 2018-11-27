SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO




CREATE        PROCEDURE [dbo].[CHCNWEB_MAKE_REFDIAGS_6X]

AS


--Use this code to create CHCNWEB_REFDIAGS new table and populate, otherwise truncate and fill
--Pulls from EZCAP production database using Linked Server connection
	

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CHCNWEB_REFDIAGS]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[CHCNWEB_REFDIAGS]

--CREATE TABLE [dbo].CHCNWEB_REFDIAGS ( COMMON_ID INT, DIAGCODE varchar(10), DIAGDESC varchar(300)) --SK.9/3/2015 increased size of DIAGCODE column 6 -> 10
CREATE TABLE [dbo].CHCNWEB_REFDIAGS ( COMMON_ID INT, DIAGCODE varchar(10), DIAGDESC varchar(300), [VERSION] INT) --SK.9/15/2015 Added [Version]

CREATE INDEX WEB_DXID on CHCNWEB_REFDIAGS(COMMON_ID)
CREATE INDEX WEB_DXCODE on CHCNWEB_REFDIAGS(DIAGCODE)
CREATE INDEX WEB_DXDESC on CHCNWEB_REFDIAGS(DIAGDESC)
CREATE INDEX WEB_VERSION on CHCNWEB_REFDIAGS([VERSION]) --SK.9/15/2015 Added 

	
-------------------------------------------------------------------------------
-- Remark code below if table does not exist and use above code. Remark Create Index lines.
--if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CHCNWEB_REFDIAGS]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
--TRUNCATE TABLE [dbo].CHCNWEB_REFDIAGS
			
--------------------------------------------------------------------------------
INSERT INTO [dbo].CHCNWEB_REFDIAGS
SELECT COMMON_ID, DIAGCODE,DIAGDESC, [VERSION]
FROM [EZCAP65TEST].[EZCAPDB].[dbo].[DIAG_CODES_V] WHERE CURRHIST='C'





GO
