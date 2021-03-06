SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE      PROCEDURE [dbo].[CHCNWEB_GetSpecialistsBySpec]

@SPECCODE varchar(10),
@GROUP varchar (100)

as

--SELECT DISTINCT 
--       	ID, LASTNAME, FIRSTNAME, MEDICAL_GROUP, CITY
--FROM    CHCNWEB_SPECIALISTS_VS
--WHERE    (CODE = @SPECCODE) AND ((MEDICAL_GROUP = @GROUP) OR (@GROUP is null))
--ORDER BY LASTNAME ASC


SELECT --DISTINCT 
       	--RANK() OVER (ORDER BY LASTNAME,FIRSTNAME, MEDICAL_GROUP, CITY, CODE, DESCR) AS ID, --Getting dynamic ID because of local table being replaced with EZCAP table
       	ID, CASE WHEN RESTRICTIONS LIKE 'closed to new%' THEN '[Closed to NPs]--' + LASTNAME ELSE LASTNAME END AS LASTNAME,
		FIRSTNAME, MEDICAL_GROUP, CITY, CODE AS SPECCODE, DESCR AS SPEC_DESCR --Added two columns: SPECCODE, SPEC_DESCR 
FROM    CHCNWEB_SPECIALISTS_VS 
WHERE    (CODE = @SPECCODE) AND ((MEDICAL_GROUP = @GROUP) OR (@GROUP is null))
GROUP BY ID, LASTNAME, FIRSTNAME, MEDICAL_GROUP, CITY, CODE, DESCR, RESTRICTIONS --Changed to GROUP BY from DISTINCT for performance improvement SK.4/4/2016
ORDER BY LASTNAME ASC
GO
