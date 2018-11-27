SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- =============================================
-- Author:		Kang, Sarah
-- Create date: 06/15/2015
-- Description:	Get denial letter for authorizations that been denied.
-- CONDITION: - AUTH Current Status: Denied (STATUS = '3')
--			  - File Reference ID = 'DENIAL LETTER'
--			  - File Content Type = 'application/pdf'
--	          - English and PDF format only
-- QUESTION: What if multiple DENIAL LETTERS found for an AUTH? Provide only TOP 1? 
-- =============================================
CREATE PROCEDURE [dbo].[CHCNPortal3_GetAuthDenialLetter]
	
	@AUTHNO VARCHAR(25)--,
	--@IMAGEFILE VARBINARY(MAX) OUTPUT
AS
BEGIN
	
	SET NOCOUNT ON;

   	SELECT DISTINCT CAST(AUTHIMAGE AS VARBINARY(MAX)) AS AUTHIMAGE
	--SELECT @IMAGEFILE = AUTHIMAGE  
	FROM [EZCAP65TEST].[EZCAPDB].[DBO].[CHCNEDI_AUTHIMAGES_VS] ai WITH (NOLOCK) 
		INNER JOIN [EZCAP65TEST].[EZCAPDB].[DBO].AUTH_MASTERS_V am WITH (NOLOCK) ON ai.AUTHNO = am.AUTHNO
	WHERE ai.AUTHNO = @AUTHNO AND am.STATUS = '3' --Denied Status
		AND (ai.ReferenceID = 'DENIAL LETTER') -- OR ai.Description = 'DENIAL LETTER')
		AND ai.Contenttype = 'application/pdf'
		AND CHARINDEX('Spanish',ai.FILENAME) = 0 AND CHARINDEX('Chinese',ai.FILENAME) = 0 AND CHARINDEX('Vietnamese',ai.FILENAME) = 0
END






GO
