SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO




CREATE   PROCEDURE [dbo].[CHCNWEB_MAKE_REFPROCCODES_6X]

AS


--Use this code to create CHCNWEB_REFPROCCODES new table and populate, otherwise truncate and fill
--Pulls from EZCAP65TEST production database using Linked Server connection
	

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CHCNWEB_REFPROCCODES]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[CHCNWEB_REFPROCCODES]

CREATE TABLE [dbo].CHCNWEB_REFPROCCODES ( COMMON_ID INT, PHCODE VARCHAR(10), PROCCODE varchar(15), PROCDESC varchar(30))

CREATE INDEX WEB_PROCCODE on CHCNWEB_REFPROCCODES(PROCCODE)
CREATE INDEX WEB_PROCDESC on CHCNWEB_REFPROCCODES(PROCDESC)

	
-------------------------------------------------------------------------------
-- Remark code below if table does not exist and use above code. Remark Create Index lines.
--if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CHCNWEB_REFPROCCODES]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
--TRUNCATE TABLE [dbo].CHCNWEB_REFPROCCODES
			
--------------------------------------------------------------------------------
INSERT INTO [dbo].CHCNWEB_REFPROCCODES
SELECT COMMON_ID, PHCODE, UPPER(LTRIM(RTRIM(SVCCODE))) AS PROCCODE,UPPER(LEFT(SVCDESC,30)) AS PROCDESC
FROM [EZCAP65TEST].[EZCAPDB].[dbo].[SERVICE_CODES_VS]
WHERE PHCODE = 'P' AND CURRHIST = 'C'




GO
