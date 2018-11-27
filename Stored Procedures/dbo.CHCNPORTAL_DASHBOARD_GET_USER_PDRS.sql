SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE PROCEDURE [dbo].[CHCNPORTAL_DASHBOARD_GET_USER_PDRS]
-- RETURNS PDRS COUNT FOR RENDERING TAX ID AND DATE RANGE SPECIFIED
-- CTA, 11/08/2017

@COMPANYID NVARCHAR(15),
@DATERANGE INT  -- NUMBER OF MONTHS FROM CURRENT DATE AS SELECTED FROM DASHBOARD DROP DOWN LIST

AS

DECLARE @DATESTART DATETIME

SET @DATESTART = DATEADD(M, -@DATERANGE, GETDATE()) 

SELECT COUNT(CM.CASENO)
FROM [EZCAP65TEST].[EZCAPDB].[DBO].[CASE_MASTERS_V] CM INNER JOIN
[EZCAP65TEST].[EZCAPDB].[dbo].[PROV_VENDINFO] AS PV WITH (NOLOCK) ON CM.ATTENDPROV_KEYID = PV.PROV_KEYID 
WHERE CM.CREATEDATE BETWEEN @DATESTART AND GETDATE() AND 
(REPLACE(PV.VENDOR,'-','') = REPLACE(@COMPANYID,'-','')) AND  CM.CASETYPE IN ('A1','C1','D1','P1','R1','NC')


GO
