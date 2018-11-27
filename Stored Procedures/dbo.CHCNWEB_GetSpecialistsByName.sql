SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--Updated by SK.11/18/2015
--Added Speciality Column, Used Real-Time data from EZCAP
--Rolled back to original due to the design issue that the static table ID being used for other SP call --SK.12/28/2015
CREATE          PROCEDURE [dbo].[CHCNWEB_GetSpecialistsByName]

@LASTNM varchar(25),
@CITY varchar(50)

as

SELECT --DISTINCT        
	--RANK() OVER (ORDER BY LASTNAME,FIRSTNAME, MEDICAL_GROUP, CITY, CODE, DESCR) AS ID, --Getting dynamic ID because of local table being replaced with EZCAP table
	ID, LASTNAME, FIRSTNAME, MEDICAL_GROUP, CITY, CODE AS SPECCODE, DESCR AS SPEC_DESCR --Added two columns: SPECCODE, SPEC_DESCR
FROM    CHCNWEB_SPECIALISTS_VS 
WHERE    ((LASTNAME = @LASTNM) OR (LASTNAME LIKE @LASTNM + '%')) AND
((CITY = @CITY) or (CITY LIKE @CITY + '%') OR (@CITY IS NULL))
GROUP BY ID, LASTNAME, FIRSTNAME, MEDICAL_GROUP, CITY, CODE, DESCR --Changed to GROUP BY from DISTINCT for performance improvement  SK.4/4/2016
ORDER BY LASTNAME ASC

--SELECT DISTINCT 
       
--	ID, LASTNAME, FIRSTNAME, MEDICAL_GROUP, CITY
--FROM    CHCNWEB_SPECIALISTS_VS
--WHERE    ((LASTNAME = @LASTNM) OR (LASTNAME LIKE @LASTNM + '%')) AND
--((CITY = @CITY) or (CITY LIKE @CITY + '%') OR (@CITY IS NULL))
--ORDER BY LASTNAME ASC























GO
