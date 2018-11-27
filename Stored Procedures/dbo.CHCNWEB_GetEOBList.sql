SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- Added code to strip out hyphens from COMPANYID comparison SK.5/17/2016
CREATE           PROCEDURE [dbo].[CHCNWEB_GetEOBList]

-- 10/18/2007	CTA 	Remove null CHECKNO exception
--			Edit DTCHKLIST selection to include NO CHECK 
-- 10/31/2007 	CTA	Change list order to descending
-- 08/30/2012 CTA, updated for 6 digit check numbers
-- 10/03/2014 CTA, updated check no to use EFT No

@COMPANYID varchar(25)

AS

SET @COMPANYID = REPLACE(@COMPANYID,'-','') 

SELECT     CONVERT(char(8), DATEPAID, 1) AS PAYDT, CHECKNO, DTCHKLIST = CASE WHEN CHECKNO ='0' THEN CONVERT(char(8), DATEPAID, 1) + ' - NO CHECK'  ELSE CONVERT(char(8), DATEPAID, 1) + ' - ' + CONVERT(varchar(80), CHECKNO) END
FROM   CHCNWEB_EOB
WHERE     (REPLACE(VENDORID,'-','') = @COMPANYID)
GROUP BY DATEPAID, CHECKNO
ORDER BY DATEPAID DESC


















GO
