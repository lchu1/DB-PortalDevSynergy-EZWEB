SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- Added code to strip out hyphens from COMPANYID comparison SK.5/17/2016
CREATE    PROCEDURE [dbo].[CHCNWEB_GetMemberAuthsMulti]

@CompanyIDList varchar (150),
@MemberID nvarchar(20)

AS

SET @CompanyIDList = REPLACE(@CompanyIDList,'-','') 

SELECT DISTINCT 
                      AUTHNUMBER = CASE WHEN STATUSCODE NOT IN ('1','2') THEN 'NONE' ELSE AUTHNO END, 
                      AUTHNO, COMPANY_ID, MEMBNAME, STATUS, 
                      CONVERT(char(10),REQDATE, 101) As REQDATE, 
	 	      CONVERT(char(10),AUTHDATE,101) AS AUTHDATE, 
	 	      CONVERT(char(10),EXPRDATE,101) AS EXPRDATE,  
		      REQPROV, RQPROVID, RENDPROV, MEMBID, 
                      LASTNM, FIRSTNM, BIRTH, PATID, 
                      CLINIC, PCP
FROM         CHCNWEB_AUTHS
WHERE  ((CHARINDEX(REPLACE(CLINIC,'-',''), @COMPANYIDLIST)>0) OR (CHARINDEX(REPLACE(COMPANY_ID,'-',''),  @COMPANYIDLIST)>0)) AND MEMBID = @MEMBERID
	
	
ORDER BY REQDATE DESC















GO
