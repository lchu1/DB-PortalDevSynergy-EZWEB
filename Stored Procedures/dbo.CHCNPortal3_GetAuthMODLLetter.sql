SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO











-- =============================================
-- SK.03/08/2018
-- For Auth MODL letter for partial approved auth: Status = 0
-- =============================================
CREATE PROCEDURE [dbo].[CHCNPortal3_GetAuthMODLLetter]
	
	@AUTHNO VARCHAR(25)
	
AS
BEGIN
	
	SET NOCOUNT ON;

   	SELECT DISTINCT CAST(AUTHIMAGE AS VARBINARY(MAX)) AS AUTHIMAGE	
	FROM [EZCAP65TEST].[EZCAPDB].[DBO].[CHCNEDI_AUTHIMAGES_VS] ai WITH (NOLOCK) 
		INNER JOIN [EZCAP65TEST].[EZCAPDB].[DBO].AUTH_MASTERS_V am WITH (NOLOCK) ON ai.AUTHNO = am.AUTHNO
	WHERE ai.AUTHNO = @AUTHNO AND am.STATUS = '0' --Partially Approved Status
		AND (ai.ReferenceID = 'MODL LETTER') --AND ai.Contenttype = 'application/pdf'				
END













GO
