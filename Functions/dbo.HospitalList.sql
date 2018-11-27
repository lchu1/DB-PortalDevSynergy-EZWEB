SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






create  function [dbo].[HospitalList]( @PROVID varchar(20))

RETURNS VARCHAR(500)
AS
BEGIN
DECLARE @HospitalList varchar(500)

SELECT @HospitalList = COALESCE(@HospitalList + ', ', '') + 
   CAST(Hospital AS varchar(40)) 
FROM CHCNWEB_SPEC_HOSPITAL_VS
WHERE PROVID = @PROVID

RETURN @HospitalList

END









GO
