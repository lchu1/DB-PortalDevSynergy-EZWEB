SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





create function [dbo].[LanguageList]( @PROVID varchar(20))

RETURNS VARCHAR(500)
AS
BEGIN
DECLARE @LanguageList varchar(500)

SELECT @LanguageList = COALESCE(@LanguageList + ', ', '') + 
   CAST(LANGUAGE AS varchar(20)) 
FROM CHCNWEB_SPEC_LANGUAGE_VS
WHERE PROVID = @PROVID

RETURN @LanguageList

END








GO
