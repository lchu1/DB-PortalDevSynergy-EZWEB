SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







create function [dbo].[DXCodeList]( @REQUESTID varchar(30))

RETURNS VARCHAR(500)
AS
BEGIN
DECLARE @DXCodeList varchar(500)

SELECT @DXCodeList = COALESCE(@DXCodeList + ', ', '') + 
   CAST([DiagCode] AS varchar(15))+' - ' + CAST([DiagDesc] as Varchar(30)) 
FROM CHCNPORTAL_AuthReqICD_Temp
WHERE REQUESTID = @REQUESTID

RETURN @DXCodeList

END










GO
