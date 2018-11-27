SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE PROCEDURE [dbo].[CHCNAuthReq_GetAllDUP]
@MEMBKEYID varchar(max),
@REFPROVID varchar(25),
@ACTIONDT Datetime,
@EXPRDATE Datetime,
@PROCCODE VARCHAR(20),
@MODIF VARCHAR(3),
@DIAGCODE VARCHAR(10)

as
	
BEGIN
	SET @MEMBKEYID = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(@MEMBKEYID,CHAR(9),''),CHAR(10),''),CHAR(13),'')))
	SET @REFPROVID = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(@REFPROVID,CHAR(9),''),CHAR(10),''),CHAR(13),'')))
	SET @PROCCODE = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(@PROCCODE,CHAR(9),''),CHAR(10),''),CHAR(13),'')))	
	SET @MODIF = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(@MODIF,CHAR(9),''),CHAR(10),''),CHAR(13),'')))	
	SET @DIAGCODE = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(@DIAGCODE,CHAR(9),''),CHAR(10),''),CHAR(13),'')))	
		
	IF @MODIF='-1' SET @MODIF=''
	
	SELECT am.authno, am.membname, am.authdate, am.exprdate, ad.proccode, ad.modif, ad.qty, am.REQPROV, ad.DiagCode, am.FACPROVID
	FROM (([EZCAP65TEST].[EZCAPDB].[dbo].[AUTH_MASTERS] AM WITH(NOLOCK) left join  
			[EZCAP65TEST].[EZCAPDB].[dbo].[AUTH_DETAILS] AD WITH(NOLOCK) on am.authno=ad.authno) left join 
			[EZCAP65TEST].[EZCAPDB].[dbo].[AUTH_DIAGS_V] ADG WITH(NOLOCK) on am.authno=ADG.authno) 
	WHERE 	(AM.MEMB_KEYID = @MEMBKEYID) and (AM.REQPROV = @REFPROVID) and
			(LTRIM(RTRIM(ad.proccode)) = @PROCCODE) and 
			@MODIF = CASE WHEN (AD.MODIF IS NULL) Then '' ELSE LTRIM(RTRIM(AD.MODIF)) END
			and
			(LTRIM(RTRIM(ADG.DIAGCODE)) = @DIAGCODE) and ADG.DIAGREFNO <=3
			and
			(	((am.exprdate is null) and (@EXPRDATE is null)) OR
				((am.exprdate is null) and (@EXPRDATE is not null) and (@EXPRDATE >= am.authdate)) OR
				((am.exprdate is not null) and (@EXPRDATE is null) and (@ACTIONDT <= am.ExprDate)) OR
				((am.exprdate is not null) and (@EXPRDATE is not null) and (@EXPRDATE >= am.authdate) and (@EXPRDATE <= am.exprdate)) OR
				((am.exprdate is not null) and (@EXPRDATE is not null) and (@ACTIONDT <= am.authdate) and (@EXPRDATE >= am.exprdate)) OR
				((am.exprdate is not null) and (@EXPRDATE is not null) and (@ACTIONDT >= am.authdate) and (@ACTIONDT <= am.exprdate)))
END



GO
