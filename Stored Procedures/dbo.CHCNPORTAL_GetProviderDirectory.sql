SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- SK.06/02/2017
-- Description:	Modified from [dbo].[CHCNWEB_GetSpecialistDetails]
-- Added addtional columns based on PR request (PRIOR-1122) SK.9/8/2017
-- =============================================
CREATE PROCEDURE [dbo].[CHCNPORTAL_GetProviderDirectory]
	
AS
BEGIN

	SET NOCOUNT ON;

 --   SELECT  DISTINCT PROVID, DESCR, FULLNAME,STREET,CITY, ZIP, PHONE, FAX, MEDICAL_GROUP, ISNULL(MEMOLINE3,'') AS MEMOLINE3 , 
 --    ISNULL(dbo.LanguageList(PROVID),'') As LanguageList, ISNULL(dbo.HospitalList(PROVID),'') As HospitalList, 
	-- ISNULL(PANEL_INFO,'') AS PANEL_INFO, ISNULL(AREA_OF_FOCUS,'') AS AREA_OF_FOCUS
	--FROM EZWEB.dbo.CHCNWEB_SPECIALISTS

	-- SELECT  DISTINCT PROVID, DESCR AS Specialty, FULLNAME,STREET,CITY, ZIP, PHONE, FAX, MEDICAL_GROUP, 
 --    ISNULL(dbo.LanguageList(PROVID),'') As 'Language(s)', ISNULL(dbo.HospitalList(PROVID),'') As 'Hospital Affiliation', 	 
	-- ISNULL(AREA_OF_FOCUS,'') AS AREA_OF_FOCUS
	--FROM EZWEB.dbo.CHCNWEB_SPECIALISTS

	SELECT  DISTINCT NPINO, LASTNAME, FIRSTNAME, DESCR AS Specialty, STREET,CITY, ZIP, PHONE, FAX, MEDICAL_GROUP, 
	ISNULL(dbo.LanguageList(PROVID),'') As 'Language(s)', ISNULL(AREA_OF_FOCUS,'') AS AREA_OF_FOCUS, ISNULL(RESTRICTIONS,'') AS RESTRICTIONS,
	ISNULL(dbo.HospitalList(PROVID),'') As 'Hospital Affiliation'
	FROM EZWEB.dbo.CHCNWEB_SPECIALISTS


END
GO
