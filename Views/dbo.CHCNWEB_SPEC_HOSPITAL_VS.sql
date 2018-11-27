SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE VIEW [dbo].[CHCNWEB_SPEC_HOSPITAL_VS]
AS
SELECT DISTINCT TOP 100 PERCENT PROVID, HOSPITAL
FROM         dbo.CHCNWEB_SPECIALISTS
WHERE     (NOT (HOSPITAL IS NULL))
ORDER BY PROVID, HOSPITAL



GO
