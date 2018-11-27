SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






CREATE PROCEDURE [dbo].[CHCNAuthReq_GetDUPAUTHInfo]

@PROCCODE VARCHAR(20),
@MODIF VARCHAR(2),
@MEMBKEYID varchar(max),
@REFPROVID varchar(25),
@ACTIONDT Datetime,
@EXPRDATE Datetime

as

SET @PROCCODE = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(@PROCCODE,CHAR(9),''),CHAR(10),''),CHAR(13),'')))	
SET @MODIF = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(@MODIF,CHAR(9),''),CHAR(10),''),CHAR(13),'')))
SET @MEMBKEYID = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(@MEMBKEYID,CHAR(9),''),CHAR(10),''),CHAR(13),'')))	
SET @REFPROVID = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(@REFPROVID,CHAR(9),''),CHAR(10),''),CHAR(13),'')))	

IF @MODIF='-1' SET @MODIF=''
select am.authno, am.membname, am.authdate, am.exprdate, ad.proccode, ad.modif as modif, ad.qty, am.REQPROV, ad.DiagCode, am.FACPROVID, 
(SELECT CODE FROM [EZCAP65TEST].[EZCAPDB].dbo.COMMON_CODES_V WHERE CATEGORY_NAME='PLACESVC' AND COMMON_ID=am.PLACESVC) AS PLACESVC
		from [EZCAP65TEST].[EZCAPDB].[dbo].[AUTH_MASTERS_V] AM WITH(NOLOCK) left join  
			 [EZCAP65TEST].[EZCAPDB].[dbo].[AUTH_DETAILS_V] AD WITH(NOLOCK) on am.authno=ad.authno 
		where	(AM.MEMB_KEYID = @MEMBKEYID) and (AM.REQPROV = @REFPROVID) and
				(LTRIM(RTRIM(ad.proccode)) = @ProcCode) and 
				@MODIF = CASE WHEN (AD.MODIF IS NULL) Then '' ELSE LTRIM(RTRIM(AD.MODIF)) END
			and
			(	((am.exprdate is null) and (@EXPRDATE is null)) OR
				((am.exprdate is null) and (@EXPRDATE is not null) and (@EXPRDATE >= am.authdate)) OR
				((am.exprdate is not null) and (@EXPRDATE is null) and (@ACTIONDT <= am.ExprDate)) OR
				((am.exprdate is not null) and (@EXPRDATE is not null) and (@EXPRDATE >= am.authdate) and (@EXPRDATE <= am.exprdate)) OR
				((am.exprdate is not null) and (@EXPRDATE is not null) and (@ACTIONDT <= am.authdate) and (@EXPRDATE >= am.exprdate)) OR
				((am.exprdate is not null) and (@EXPRDATE is not null) and (@ACTIONDT >= am.authdate) and (@ACTIONDT <= am.exprdate)))
ORDER BY AUTHDATE




GO
