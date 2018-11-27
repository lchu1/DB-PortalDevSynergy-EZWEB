SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- =============================================
-- Author:		Synergy BIS
-- Create date: 6/24/2016
-- Description:	Gets CPT Codes for PHCODE values of P only
-- =============================================
CREATE PROCEDURE [dbo].[CHCNPortal3_udf_GetCPT] 
@CPT varchar (20)

as

IF @CPT IS NULL 
	BEGIN
	RETURN
	END
ELSE
	BEGIN
	SET @CPT = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(@CPT,CHAR(9),''),CHAR(10),''),CHAR(13),'')))	
	SELECT  COMMON_ID, PROCCODE, PROCDESC
	FROM    [EZWEB].[DBO].[CHCNAUTHREQ_CPT]
	WHERE PROCCODE like @CPT+'%' OR (charindex(@CPT,PROCDESC) > 0) AND PHCODE = N'P'
End


GO
