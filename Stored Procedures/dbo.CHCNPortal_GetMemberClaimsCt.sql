SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO



CREATE PROCEDURE [dbo].[CHCNPortal_GetMemberClaimsCt]

-- UPDATED TO USE EZWEB.DBO.CHCNPORTAL_CLAIM_MASTER - REFRESHED NIGHTLY, CTA, 01/22/2014
-- Added code to strip out hyphens from COMPANYID comparison SK.5/17/2016
-- Added filertering for Alliance and Anthm, CTA, 06/17/2016 

@MEMBERID VARCHAR(20),
@COMPANYID VARCHAR(500)

AS

If @COMPANYID IS NULL AND @MEMBERID IS NULL  
	BEGIN
	RETURN
	END
ELSE

	BEGIN

	SET @COMPANYID = REPLACE(@COMPANYID,'-','') 

	IF @COMPANYID LIKE '%ALAMEDA%' -- Updated to use wildcard, CTA, 06/23/2013
		BEGIN
			SELECT     COUNT(CLAIMNO) AS COUNT, CONVERT(CHAR(10),MIN(DISTINCT DATERECD),101) AS FROMDATE
			FROM       DBO.CHCNPORTAL_CLAIM_MASTER
			WHERE     (MEMBID = @MEMBERID) AND (OPT LIKE 'AA%')
		END

	ELSE IF @COMPANYID LIKE '%ANTHEM%' -- Updated to use wildcard, CTA, 06/23/2013
		BEGIN
			SELECT     COUNT(CLAIMNO) AS COUNT, CONVERT(CHAR(10),MIN(DISTINCT DATERECD),101) AS FROMDATE
			FROM       DBO.CHCNPORTAL_CLAIM_MASTER
			WHERE     (MEMBID = @MEMBERID) AND (OPT LIKE 'BC%')
		END

	ELSE
		BEGIN
			SELECT     COUNT(CLAIMNO) AS COUNT, CONVERT(CHAR(10),MIN(DISTINCT DATERECD),101) AS FROMDATE
			FROM       DBO.CHCNPORTAL_CLAIM_MASTER
			WHERE     (MEMBID = @MEMBERID) AND (CHARINDEX(REPLACE(COMPANY_ID,'-',''),@COMPANYID)>0 OR CHARINDEX(REPLACE(VENDOR,'-',''),@COMPANYID)>0)
		END
	END
GO
