SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
















-- 09/17/2009, CTA, Edited to exclude PHA - Physician Assistant from selection

CREATE    PROCEDURE [dbo].[CHCNWEB_GetSpecialty]

as

SELECT DISTINCT CODE, dbo.ProperCase(DESCR) AS DESCR 
FROM      CHCNWEB_SPECIALISTS 
WHERE CODE <> 'PHA'
ORDER BY DESCR ASC











GO
