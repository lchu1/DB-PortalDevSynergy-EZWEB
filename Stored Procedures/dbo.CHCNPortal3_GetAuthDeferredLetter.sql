SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








-- =============================================
-- SK.10/27/2016
-- For Auth Deferred letter: Status = 9
-- =============================================
CREATE PROCEDURE [dbo].[CHCNPortal3_GetAuthDeferredLetter]
	
	@AUTHNO VARCHAR(25)
	
AS
BEGIN
	
	SET NOCOUNT ON;

   	SELECT DISTINCT CAST(AUTHIMAGE AS VARBINARY(MAX)) AS AUTHIMAGE	
	FROM [EZCAP65TEST].[EZCAPDB].[DBO].[CHCNEDI_AUTHIMAGES_VS] ai WITH (NOLOCK) 
		INNER JOIN [EZCAP65TEST].[EZCAPDB].[DBO].AUTH_MASTERS_V am WITH (NOLOCK) ON ai.AUTHNO = am.AUTHNO
	WHERE ai.AUTHNO = @AUTHNO AND am.STATUS = '9' --Deferred Status
		AND (ai.ReferenceID = 'DEFERRED LETTER') AND ai.Contenttype = 'application/pdf'				
END










GO
