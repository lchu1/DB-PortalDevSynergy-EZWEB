SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




--ZIRA PRIOR 1108 - Additional colum NPINO SK.08/16/2017
--ZIRA PRIOR 1117 - Additional column RESTRICTIONS SK.10/16/2017

CREATE PROCEDURE [dbo].[CHCNWEB_GetSpecialistDetails]

@ID int

as


SELECT  DISTINCT DESCR, FULLNAME,STREET,CITY, ZIP, PHONE,
	FAX, MEDICAL_GROUP, --MEMOLINE3 , 
	dbo.LanguageList(dbo.GetProviderID(@ID)) As LanguageList,
	dbo.HospitalList(dbo.GetProviderID(@ID)) As HospitalList, CASE WHEN PANEL_INFO != 'no panel' THEN PANEL_INFO ELSE NULL END AS PANEL_INFO, AREA_OF_FOCUS, NPINO, RESTRICTIONS

FROM CHCNWEB_SPECIALISTS
WHERE ID = @ID



GO
