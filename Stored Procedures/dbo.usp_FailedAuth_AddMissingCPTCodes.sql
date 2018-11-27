SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [dbo].[usp_FailedAuth_AddMissingCPTCodes]

@REQUESTID VARCHAR (30),
@IN_AUTHNO VARCHAR (30) ,
@RESULTS VARCHAR(7000) OUTPUT

AS

BEGIN

DECLARE @IN_MEMB_KEYID VARCHAR(50)
DECLARE @IN_REQPROV VARCHAR (25)
DECLARE @IN_REQDATE VARCHAR(25)
DECLARE @IN_AUTHDATE VARCHAR(12)
DECLARE @IN_EXPRDATE VARCHAR(12)= ''
DECLARE @IN_AUTHPCP VARCHAR (25)
DECLARE @IN_PLACESVC VARCHAR (25)
DECLARE @IN_FAXTONUMBER VARCHAR(12)
DECLARE @IN_REQPHONENUMBER VARCHAR(17)
DECLARE @IN_REFTOPROVFAX VARCHAR(12)
DECLARE @IN_REQNAME VARCHAR(50)
DECLARE @IN_AUTHPCP_KEYID VARCHAR(50)
DECLARE @IN_STATUS VARCHAR(8)
DECLARE @IN_PRIORITY VARCHAR(8)
DECLARE @IN_REQPROV_KEYID VARCHAR(50)
DECLARE @IN_MEMBID VARCHAR (25)
DECLARE @IN_MEMBNAME VARCHAR (80)
DECLARE @IN_NOTES VARCHAR(MAX)
DECLARE @IN_SPECCODE VARCHAR(50)
DECLARE @IN_HPAUTHNO VARCHAR(25) 
DECLARE @IN_ONSETDT DATETIME
DECLARE @IN_AUTHUNITS SMALLINT
DECLARE @IN_CERTTYPE INT
DECLARE @IN_UNLISTEDPROV VARCHAR(50)
DECLARE @IN_ESTDOB DATETIME
DECLARE @in_HPCODE varchar(10)
DECLARE @in_OPT varchar(25)
DECLARE @in_COMPANY_ID varchar(10)
DECLARE @in_AuthDetails varchar(max)
DECLARE @in_CreatedBy int
DECLARE @in_DiagCode1 int
DECLARE @in_DiagCode2 int
DECLARE @in_DiagCode3 int
DECLARE @in_DiagCode4 int
DECLARE @in_DiagCode5 int
DECLARE @in_DiagCode6 int
DECLARE @in_DiagCode7 int
DECLARE @in_DiagCode8 int
DECLARE @in_DiagCode9 int
DECLARE @in_DiagCode10 int
DECLARE @in_DiagCode11 int
DECLARE @in_DiagCode12 int
DECLARE @in_SVCTYPE int
DECLARE @NUM int
DECLARE @SQL varchar(2000)
DECLARE @ID int
DECLARE @CREATEDBY int
DECLARE @CREATEDDATE datetime
DECLARE @LASTCHANGEBY int 
DECLARE @LASTCHANGEDATE datetime
DECLARE @FolderID int
DECLARE @FileID int
DECLARE @FilePathID int
DECLARE @FILENAME VARCHAR(200)
DECLARE @FILEPATH VARCHAR(500)
DECLARE @CONTENTTYPE VARCHAR(100)
DECLARE @ATTACHMENT VARBINARY(MAX)
DECLARE @FILEDESCR VARCHAR(500)
DECLARE @FolderName varchar(50)
DECLARE @Count int
DECLARE @in_REQDUNITS smallInt
DECLARE @PostAuthResult int
DECLARE @CMD VARCHAR(500)
DECLARE @BATCHID INT
DECLARE @IN_STATUSZNOTES VARCHAR(MAX)
DECLARE @SEQUENCE INT
DECLARE @NOTES VARCHAR(MAX)
DECLARE @SUBJECT VARCHAR(200)
-- ADDED 01/03/2015, CTA 
DECLARE @FINRESPSET INT 
DECLARE @LOB VARCHAR(10)
DECLARE @OU_PLACESVC VARCHAR (25)
DECLARE @AUTHPCP_SPECCODE VARCHAR(50)
DECLARE @AUTHPCP_CONTRACT VARCHAR(50)
DECLARE @AUTHPCP_CLASS VARCHAR(50)
DECLARE @REQPROV_CONTRACT VARCHAR(50)
DECLARE @REQPROV_CLASS VARCHAR(50)
DECLARE @VENDORID VARCHAR(50)
--ADDED 01/06/2015 FOR POS 21 PROCESSING
DECLARE @in_FACPROVID VARCHAR (25)
DECLARE @in_SVCFACID_KEYID 	VARCHAR(50)
DECLARE @IN_REQCAT INT
DECLARE @OU_P7 VARCHAR(3) =''
DECLARE @ISDUP BIT = 0
DECLARE @FLAG BIT = 0
-- ADDED 01/29/2015, CTA
DECLARE @DIAGCODE VARCHAR(10) = ''
--ADDED for UDF15 on EZCAP (SK.9/12/2016)
DECLARE @AuthPCP_CompanyID VARCHAR(200)

------------
DECLARE @IN_ACCT				VARCHAR (10) = '',
		@IN_SUBACCT				VARCHAR (10) = '',
		@IN_PSTATUS				INT = NULL,		
		@IN_CASENO				VARCHAR (25) = '',		
		@IN_LOS					INT = NULL,
		@IN_CONTRVAL			DECIMAL(15,3) = NULL,
		@IN_WITHHOLD			DECIMAL(15,3) = NULL,
		@IN_COPAY				DECIMAL(15,3) = NULL,
		@IN_COINSURANCE			DECIMAL(15,3) = NULL,
		@IN_NET					DECIMAL(15,3) = NULL,
		@IN_EDIREF				VARCHAR (10) = '',
		@IN_XPDATE				DATETIME = NULL,
		@IN_XPSTATUS			VARCHAR (3) = '',
		@IN_XPTRAN				VARCHAR (3) = '',
		@IN_OUTLOADDT			DATETIME = NULL,			
		@IN_ISUNITLIMIT			BIT = 1, -- set to 1 by default for CHCN, CTA, 12/11/2014.
		@IN_ISDOLLARLIMIT		BIT = 0,
		@IN_AUTOSTATUS			VARCHAR (3) = '',
		@IN_P1 					VARCHAR (3) = '',
		@IN_P2 					VARCHAR (3) = '',
		@IN_P3 					VARCHAR (3) = '',
		@IN_P4 					VARCHAR (3) = '',
		@IN_P5 					VARCHAR (3) = '',
		@IN_P6 					VARCHAR (3) = '',
		@IN_P7 					VARCHAR (3) = '',
		@IN_P8 					VARCHAR (3) = '',
		@IN_P9 					VARCHAR (3) = '',
		@IN_P10					VARCHAR (3) = '',
		@IN_HOSPBILL			BIT = 0,
		@IN_COB					BIT = 0,	
		@IN_VENDOR				VARCHAR (25) = '',
		@IN_ACCIDDT				DATETIME = NULL,
		@IN_LMPDT				DATETIME = NULL,
		@IN_EDI_AUTH_ID			VARCHAR (40) = '',
		@IN_ASPCODE				INT = NULL,
		@IN_SUGGESTED_STATUS	VARCHAR (3) = '',
		@IN_GENERATED_BY		VARCHAR (10) = '',	
		@IN_BMSETWINRULE		INT = NULL,		
		@IN_ModifiedBy			INT = 0	,
		@IN_ModifiedDate		BIGINT = 0,	
		@IN_P11 				VARCHAR (3) = '',
		@IN_P12 				VARCHAR (3) = '',	
		@IN_P13 				VARCHAR (3) = '',
		@IN_P14 				VARCHAR (3) = '',
		@IN_P15 				VARCHAR (3) = '',	
		@IN_WFQueued			BIT = NULL,	
		@IN_AdjudicationID		INT = 0,
		@IN_PriceStatus			SMALLINT=2,	
		@IN_IsEZNET				BIT=0,		
		@IN_IsHPGlobal			BIT = 1,
		@IN_IsUnitLimitDetail	BIT = 0,
		@IN_IsDollarLimitDetail	BIT = 0,		
		@IN_Request_Type		CHAR(1) = 'A',		
		@IN_AuthSource			TINYINT = 0		
-----------------

	DECLARE @AuditLog VARCHAR(MAX) = ''		
	DECLARE @IN_DOS VARCHAR(20) = ''
	DECLARE @AUTHCNT INT = 0

BEGIN TRY

	SET @IN_ONSETDT = NULL
	SET @IN_AUTHUNITS = NULL
	SET @IN_CERTTYPE = NULL
		
    SELECT  @IN_REQPHONENUMBER = A.AUTHPCP_OfficeContactPhone ,
            @IN_FAXTONUMBER = A.AUTHPCP_OfficeContactFax ,
            @IN_REQNAME = A.AUTHPCP_OfficeContactName ,                                   
            @REQPROV_CLASS = RP.CLASS ,
            @REQPROV_CONTRACT = RP.CONTRACT ,
            @AUTHPCP_CLASS = AP.CLASS ,
            @AUTHPCP_CONTRACT = AP.CONTRACT ,
            @AUTHPCP_SPECCODE = [AS].SPECCODE ,
            @VENDORID = V.VENDOR ,
            @IN_UNLISTEDPROV = A.AUTHPCP_UnlistedName ,
            @IN_REFTOPROVFAX = A.RefToProvFax            
    FROM    [EZWEB].[dbo].[CHCNAuthReq_Master] A             
	        LEFT JOIN [EZCAP65TEST].[EZCAPDB].[dbo].[PROV_COMPANY_V] RP ON A.RefToProv_KeyID = RP.PROV_KEYID
            LEFT JOIN [EZCAP65TEST].[EZCAPDB].[dbo].[PROV_COMPANY_V] AP ON A.RefToProv_KeyID = AP.PROV_KEYID
            LEFT JOIN [EZCAP65TEST].[EZCAPDB].[dbo].[PROV_SPECINFO_V] [AS] ON A.RefToProv_KeyID = [AS].PROV_KEYID
                                                              AND [AS].[TYPE] = 'PRIMARY'
            LEFT JOIN [EZCAP65TEST].[EZCAPDB].[dbo].[PROV_VENDINFO_V] V ON A.RefToProv_KeyID = V.PROV_KEYID
    WHERE   A.RequestID = @REQUESTID;
	
	SELECT @in_CreatedBy = '10209' 
		
	SELECT  @in_HPCODE = HPCODE ,
				@in_OPT = OPT ,
				@IN_AUTHPCP_KEYID = AUTHPCP_KEYID ,
				@IN_MEMB_KEYID = MEMB_KEYID ,
				@IN_REQPROV_KEYID = REQPROV_KEYID ,
				@IN_SPECCODE = REQSPEC ,
				@IN_REQPROV = REQPROV ,
				@in_FACPROVID = FACPROVID ,
				@in_SVCFACID_KEYID = SVCFACID_KEYID ,
				@IN_AUTHDATE = CONVERT(VARCHAR(10), AUTHDATE, 101) ,
				@IN_EXPRDATE = CONVERT(VARCHAR(10), EXPRDATE, 101) ,
				@in_COMPANY_ID = COMPANY_ID ,
				@IN_AUTHPCP = AUTHPCP ,
				@IN_MEMBID = MEMBID ,
				@IN_MEMBNAME = MEMBNAME ,
				@OU_PLACESVC = PLACESVC ,
				@IN_REQDATE = m.REQDATE ,
				@IN_STATUS = m.STATUS ,
				@IN_PRIORITY = m.PRIORITY ,
				@IN_REQCAT = m.REQCAT ,
				@IN_ACCT = m.ACCT ,
				@IN_SUBACCT = m.SUBACCT ,
				@IN_CERTTYPE = m.CERTTYPE ,
				@in_SVCTYPE = m.SVCTYPE ,
				@IN_PSTATUS = m.PSTATUS ,
				@IN_CASENO = m.CASENO ,
				@IN_HPAUTHNO = m.HPAUTHNO ,
				@IN_LOS = m.LOS ,
				@IN_CONTRVAL = m.CONTRVAL ,
				@IN_WITHHOLD = m.WITHHOLD ,
				@IN_COPAY = m.COPAY ,
				@IN_COINSURANCE = m.COINSURANCE ,
				@IN_NET = m.NET ,
				@IN_EDIREF = m.EDIREF ,
				@IN_XPDATE = m.XPDATE ,
				@IN_XPSTATUS = m.XPSTATUS ,
				@IN_XPTRAN = m.XPTRAN ,
				@IN_OUTLOADDT = m.OUTLOADDT ,
				@IN_AUTHUNITS = m.AUTHUNITS ,
				@IN_ISUNITLIMIT = m.ISUNITLIMIT ,
				@IN_ISDOLLARLIMIT = m.ISDOLLARLIMIT ,
				@IN_AUTOSTATUS = m.AUTOSTATUS ,
				@IN_P1 = m.P1 ,
				@IN_P2 = m.P2 ,
				@IN_P3 = m.P3 ,
				@IN_P4 = m.P4 ,
				@IN_P5 = m.P5 ,
				@IN_P6 = m.P6 ,
				@IN_P7 = m.P7 ,
				@IN_P8 = m.P8 ,
				@IN_P9 = m.P9 ,
				@IN_P10 = m.P10 ,
				@IN_HOSPBILL = m.HOSPBILL ,
				@IN_COB = m.COB ,
				@IN_VENDOR = m.VENDOR ,
				@IN_ACCIDDT = m.ACCIDDT ,
				@IN_LMPDT = m.LMPDT ,
				@IN_ESTDOB = m.ESTDOB ,
				@IN_ONSETDT = m.ONSETDT ,
				@IN_EDI_AUTH_ID = m.EDI_AUTH_ID ,
				@IN_ASPCODE = m.ASPCODE ,
				@IN_SUGGESTED_STATUS = m.SUGGESTED_STATUS ,
				@IN_GENERATED_BY = m.GENERATED_BY ,
				@IN_BMSETWINRULE = m.BMSETWINRULE ,
				@IN_ModifiedBy = m.LASTCHANGEBY ,
				@IN_ModifiedDate = REPLACE(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR, m.LASTCHANGEDATE, 121),
																   '-', ''), ':', ''),
												   '.', ''), ' ', '') ,
				@IN_P11 = m.P11 ,
				@IN_P12 = m.P12 ,
				@IN_P13 = m.P13 ,
				@IN_P14 = m.P14 ,
				@IN_P15 = m.P15 ,
				@IN_WFQueued = m.WF_QUEUED ,
				@IN_AdjudicationID = m.ADJUDICATION_ID ,
				@IN_PriceStatus = m.PRICESTATUS ,
				@IN_IsEZNET = m.IsEZNET ,
				@IN_IsHPGlobal = m.ISHPGLOBAL ,
				@IN_IsUnitLimitDetail = m.ISUNITLIMITDETAIL ,
				@IN_IsDollarLimitDetail = m.ISDOLLARLIMITDETAIL ,
				@in_REQDUNITS = m.REQDUNITS ,
				@IN_Request_Type = m.REQUEST_TYPE ,
				@IN_AuthSource = m.AUTH_SOURCE
		FROM    EZCAP65TEST.EZCAPDB.dbo.AUTH_MASTERS m
		WHERE   m.AUTHNO = @IN_AUTHNO;		

	SET @IN_PLACESVC = (SELECT CODE FROM [EZCAP65TEST].[EZCAPDB].dbo.COMMON_CODES_V WHERE CATEGORY_NAME='PLACESVC' AND  COMMON_ID = @OU_PLACESVC AND CURRHIST='C') 	

	PRINT 'DX PROCESSING'
	-- Fill @in_Diag fields from AUTH_DIAGS_TEMP table
	CREATE TABLE #authtemp_icd (ID int IDENTITY(1,1),DX_Common_ID int)
	--INSERT INTO #authtemp_icd (DX_Common_ID)
	--SELECT Common_ID FROM CHCNAUTHREQ_ICD_TEMP WHERE REQUESTID = @REQUESTID
		
	CREATE TABLE #authtemp_icdlist (DX1 int,DX2 int, DX3 int, DX4 int, DX5 int, DX6 int, DX7 int, DX8 int, DX9 int, DX10 int, DX11 int, DX12 int)

	INSERT INTO  #authtemp_icdlist (DX1 ,DX2 , DX3 , DX4 , DX5 , DX6 , DX7 , DX8 , DX9 , DX10 , DX11 , DX12 )
	VALUES(null,null,null,null,null,null,null,null,null,null,null,null)

	DECLARE @DCNT INT = 0;
	SET @ID = 1	
    SELECT  @DCNT = COUNT(*) FROM EZCAP65TEST.EZCAPDB.dbo.AUTH_DIAGS WHERE AUTHNO = @IN_AUTHNO;

	IF @DCNT > 0
	BEGIN		
		WHILE (@ID <= @DCNT)
			BEGIN
				SET @SQL = 'UPDATE #authtemp_icdlist SET DX'+CAST(@ID AS CHAR)+' = d' + CAST(@ID AS VARCHAR(2)) + '.DIAG  
								FROM EZCAP65TEST.EZCAPDB.DBO.AUTH_MASTERS m WITH (NOLOCK) LEFT OUTER JOIN 
									EZCAP65TEST.EZCAPDB.DBO.AUTH_DIAGS AS d1 WITH (NOLOCK) ON m.AUTHNO = d1.AUTHNO AND d1.DIAGREFNO = ''1'' LEFT OUTER JOIN
									EZCAP65TEST.EZCAPDB.DBO.AUTH_DIAGS AS d2 WITH (NOLOCK) ON m.AUTHNO = d2.AUTHNO AND d2.DIAGREFNO = ''2'' LEFT OUTER JOIN
									EZCAP65TEST.EZCAPDB.DBO.AUTH_DIAGS AS d3 WITH (NOLOCK) ON m.AUTHNO = d3.AUTHNO AND d3.DIAGREFNO = ''3'' LEFT OUTER JOIN
									EZCAP65TEST.EZCAPDB.DBO.AUTH_DIAGS AS d4 WITH (NOLOCK) ON m.AUTHNO = d4.AUTHNO AND d4.DIAGREFNO = ''4'' LEFT OUTER JOIN
									EZCAP65TEST.EZCAPDB.DBO.AUTH_DIAGS AS d5 WITH (NOLOCK) ON m.AUTHNO = d5.AUTHNO AND d5.DIAGREFNO = ''5'' LEFT OUTER JOIN
									EZCAP65TEST.EZCAPDB.DBO.AUTH_DIAGS AS d6 WITH (NOLOCK) ON m.AUTHNO = d6.AUTHNO AND d6.DIAGREFNO = ''6'' LEFT OUTER JOIN
									EZCAP65TEST.EZCAPDB.DBO.AUTH_DIAGS AS d7 WITH (NOLOCK) ON m.AUTHNO = d7.AUTHNO AND d7.DIAGREFNO = ''7'' LEFT OUTER JOIN
									EZCAP65TEST.EZCAPDB.DBO.AUTH_DIAGS AS d8 WITH (NOLOCK) ON m.AUTHNO = d8.AUTHNO AND d8.DIAGREFNO = ''8'' LEFT OUTER JOIN
									EZCAP65TEST.EZCAPDB.DBO.AUTH_DIAGS AS d9 WITH (NOLOCK) ON m.AUTHNO = d9.AUTHNO AND d9.DIAGREFNO = ''9'' LEFT OUTER JOIN
									EZCAP65TEST.EZCAPDB.DBO.AUTH_DIAGS AS d10 WITH (NOLOCK) ON m.AUTHNO = d10.AUTHNO AND d10.DIAGREFNO = ''10'' LEFT OUTER JOIN
									EZCAP65TEST.EZCAPDB.DBO.AUTH_DIAGS AS d11 WITH (NOLOCK) ON m.AUTHNO = d11.AUTHNO AND d11.DIAGREFNO = ''11'' LEFT OUTER JOIN
									EZCAP65TEST.EZCAPDB.DBO.AUTH_DIAGS AS d12 WITH (NOLOCK) ON m.AUTHNO = d12.AUTHNO AND d12.DIAGREFNO = ''12'' 
								WHERE m.AUTHNO = ''' + @IN_AUTHNO + ''''
print @SQL
				--#authtemp_icd i where ID='+CAST(@ID AS CHAR)
				EXEC (@SQL)

				SET @ID = @ID + 1
			END		
	END

	--SET @id = 1
	--SELECT @NUM = COUNT(*)+@ID FROM CHCNAUTHREQ_ICD_TEMP WHERE REQUESTID = @REQUESTID
	--	WHILE (@id <= @num)
	--		BEGIN
	--			SET @SQL = 'update #authtemp_icdlist set DX'+CAST(@ID AS CHAR)+' = i.DX_Common_ID from #authtemp_icd i where ID='+CAST(@ID-@DCNT AS CHAR)
	--			EXEC (@SQL)

	--			SET @id = @id+1
	--		END

	SELECT @in_DiagCode1 = (SELECT ISNULL(DX1, '') FROM #authtemp_icdlist)
	SELECT @in_DiagCode2 = (SELECT ISNULL(DX2, '') FROM #authtemp_icdlist)
	SELECT @in_DiagCode3 = (SELECT ISNULL(DX3, '') FROM #authtemp_icdlist)
	SELECT @in_DiagCode4 = (SELECT ISNULL(DX4, '') FROM #authtemp_icdlist)
	SELECT @in_DiagCode5 = (SELECT ISNULL(DX5, '') FROM #authtemp_icdlist)
	SELECT @in_DiagCode6 = (SELECT ISNULL(DX6, '') FROM #authtemp_icdlist)
	SELECT @in_DiagCode7 = (SELECT ISNULL(DX7, '') FROM #authtemp_icdlist)
	SELECT @in_DiagCode8 = (SELECT ISNULL(DX8, '') FROM #authtemp_icdlist)
	SELECT @in_DiagCode9 = (SELECT ISNULL(DX9, '') FROM #authtemp_icdlist)
	SELECT @in_DiagCode10 = (SELECT ISNULL(DX10, '') FROM #authtemp_icdlist)
	SELECT @in_DiagCode11 = (SELECT ISNULL(DX11, '') FROM #authtemp_icdlist)
	SELECT @in_DiagCode12 = (SELECT ISNULL(DX12, '') FROM #authtemp_icdlist)
	print 'Finished setting DiagCode 1-12'
	--SET PRIMARY DIAG CODE VALUE, CTA 01/29/2015
	SET @DIAGCODE = (SELECT NULLIF(DIAGCODE,'') FROM [EZCAP65TEST].[EZCAPDB].[dbo].[DIAG_CODES_V] WHERE COMMON_ID = @in_DiagCode1)

	-- GET FINANCIAL RESP AND FEESET INFO - ADDED 01/03/2015
	EXEC [EZCAP65TEST].[EZCAPDB].[dbo].[usp_Price_CheckLineOfBuss] @ReqProv_KeyId=@IN_REQPROV_KEYID, @ECDServerName='EZCAP65TEST',@Memb_KeyId=@IN_MEMB_KEYID, @nAuthExist=1,@Hpcode=@in_HPCODE, @Opt=@in_OPT, @Emp='',@sSPECCODE=@IN_SPECCODE,@in_ISHPGlobal=1,@dFROM_DATE=@IN_AUTHDATE,@dTO_DATE=@IN_EXPRDATE, @OU_MEMBLOB = @LOB OUTPUT

	SELECT @FINRESPSET = FINRESSET  FROM [EZCAP65TEST].[EZCAPDB].[dbo].[BM_OPT_MASTER_V]  WHERE OPT = @in_OPT AND CURRHIST='C'

	--Create @in_AuthDetails as xml
	--set @id = 1
	set @in_AuthDetails = ''
	-- IF POS=21 CHECK FOR H-121 SERVICE CODE IN CPT RECORDS. IF NOT EXISTS, ADD RECORD  
	SELECT @NUM = COUNT(*) from CHCNAUTHREQ_CPT_TEMP where REQUESTID = @REQUESTID AND PHCODE='H'AND LTRIM(RTRIM(ProcCode)) = '121'

	IF @NUM > 0
		BEGIN
			SET @FLAG =1
		END

	SELECT @NUM = CASE WHEN @IN_PLACESVC='21' AND @FLAG=0 THEN COUNT(*)+1 ELSE COUNT(*) END from CHCNAUTHREQ_CPT_TEMP where REQUESTID = @REQUESTID
	print 'Start Auth Details'
	print 'Detail Count: '+ CAST(@num AS VARCHAR)

	IF @NUM > 0
		BEGIN

			CREATE TABLE #AUTHTEMP_CPT ([ID] [INT] IDENTITY(1,1),[COMMON_ID] [INT],[PHCODE] [VARCHAR](50),[PROCCODE] [VARCHAR](25),[PROCDESC] [VARCHAR](100),[QTY] [INT], [MODIF] [VARCHAR](2),[FINANCIALRESP] INT, [PENDED] BIT, [P0] VARCHAR(3),[P1] VARCHAR(3),[P2] VARCHAR(3),[P3] VARCHAR(3),[P4] VARCHAR(3),[P5] VARCHAR(3),[P6] VARCHAR(3),[P7] VARCHAR(3),[P8] VARCHAR(3),[P9] VARCHAR(3),[P10] VARCHAR(3),[P11] VARCHAR(3),[P12] VARCHAR(3),[P13] VARCHAR(3),[P14] VARCHAR(3),[P15] VARCHAR(3),[P16] VARCHAR(3),[BMMASTERID] INT, [FEESETID] INT, [FEESCHEDS_ID] INT, [FEESET_PERCENT] DECIMAL (6,2), [EXCFEESET] INT, [EXCFEESET_PERCENT] DECIMAL(6,2), [CONTRACT_CODE] VARCHAR(1), [MODIFSET] INT, [FINRESPSET] INT, [FEESETASSIGNID] INT, [CAPITATED] DECIMAL(1,0), [PRICEBASIS] VARCHAR(5), [PAYACTION] VARCHAR(50))
			
			INSERT INTO #AUTHTEMP_CPT (COMMON_ID, PHCODE, PROCCODE, PROCDESC, QTY, MODIF, FINRESPSET, CONTRACT_CODE ) 
			SELECT COMMON_ID, PHCODE, LTRIM(RTRIM(PROCCODE)), PROCDESC, QTY, MODIF,@FINRESPSET, @REQPROV_CONTRACT  
			FROM CHCNAUTHREQ_CPT_TEMP
			WHERE REQUESTID = @REQUESTID
			
			-- INSERT H-121 WHEN POS=21 AND H-121 NOT SUBMITTED BY USER
			IF @IN_PLACESVC = '21' AND @FLAG=0
			BEGIN
				DECLARE @121 INT,@121DESC VARCHAR(100)
				SELECT @121 = COMMON_ID, @121DESC = SVCDESC  FROM [EZCAP65TEST].[EZCAPDB].[DBO].[SERVICE_CODES_V] 
				WHERE LTRIM(RTRIM(SVCCODE)) = '121' AND PHCODE = 'H' AND CURRHIST = 'C'
					
				INSERT INTO #AUTHTEMP_CPT (COMMON_ID, PHCODE, PROCCODE, PROCDESC, QTY, MODIF,  FINRESPSET, CONTRACT_CODE) 
				VALUES(@121, 'H', '121', @121DESC, '1','', @FINRESPSET , @REQPROV_CONTRACT)
			END
			-- SELECT * FROM #AUTHTEMP_CPT
			CREATE TABLE #AUTHTEMP_CPT_XML (ID INT IDENTITY(1,1),CPTRECORD VARCHAR(MAX))
			
			SET @ID = (SELECT MIN(ID) FROM #AUTHTEMP_CPT)

			WHILE @ID <= @NUM
				BEGIN
					DECLARE @PROCCODE VARCHAR(25), @PHCODE VARCHAR(50), @OU_MASTERID INT = '', @LOB_HMO BIT='', @LOB_PPO BIT = '', @LOB_POS BIT =''
					
					SELECT @LOB_HMO=CASE WHEN @LOB= 'HMO' THEN 1 ELSE 0 END, @LOB_PPO= CASE WHEN @LOB = 'PPO' THEN 1 ELSE 0 END, @LOB_POS= CASE WHEN @LOB ='POS' THEN 1 ELSE 0 END

					
					SELECT @PROCCODE = LTRIM(RTRIM(PROCCODE)), @PHCODE = PHCODE FROM #authtemp_cpt WHERE ID = @ID
					
					-- ADDED 01/03/2015, CTA
					EXEC [EZCAP65TEST].[EZCAPDB].[dbo].[CHCNEDI_BM_MainGetAdvancedRules] @strParProcCode=@PROCCODE,@strParDiagCode='',@strParPosCode=@IN_PLACESVC,@strModif='',@nQty=1,@strProvID=@IN_REQPROV,@strSpec=@IN_SPECCODE,@strSpecStatus='A',@strProvClass=@REQPROV_CLASS ,@strProvContract=@REQPROV_CONTRACT,@strAuthProv=@IN_AUTHPCP,@strAuthSpec=@AUTHPCP_SPECCODE,@strAuthProvClass=@AUTHPCP_CLASS,@strAuthProvContract='C',@strAuthSpecStatus='A',@nDifference=0,@strHpCode=@in_HPCODE,@strPHCode=@PHCODE,@strClaimNo='',@nTblRow=1,@dtDateOfService=@in_AUTHDATE,@dtDateOfService2=@in_EXPRDATE,@strMemb_KeyID=@IN_MEMB_KEYID,@strAuthNo='',@strClaimAuth='A',@strOpt=@IN_OPT,@strEmpGrp='',@HMO = @LOB_HMO, @PPO= @LOB_PPO, @POS= @LOB_POS, @IN_NETWORK=1,@OUT_NETWORK=0,@in_ISHPGlobal=1,@nOpID=10014,@ECDServerName='EZCAP65TEST',@ID='', @OU_MASTERID=@OU_MASTERID OUTPUT
					
					PRINT 'MASTERID: ' + CAST(@OU_MASTERID AS VARCHAR)
					UPDATE #authtemp_cpt SET BMMASTERID = @OU_MASTERID WHERE ID = @ID
					
					-- GET FEE SET INFO
					DECLARE @FEESET_ID INT, @FEESET_PERCENT DECIMAL(15,2),@FEESET_DESCR VARCHAR(255), @EXTFEESET_ID INT = '',@EXTFEESET_PERCENT DECIMAL(15,2),@EXTFEESET_DESCR VARCHAR(255), 
				  @MODSET INT, @FEESBY_ASSIGNS_ID INT = '', @BASIS VARCHAR(2),@RATE1 DECIMAL(15,4), @RATE2 DECIMAL(15,4),@RATE3 DECIMAL(15,4),@RATE4 DECIMAL(15,4), @DAYS1 DECIMAL(5,0), @DAYS2 DECIMAL(5,0), 
				  @DAYS3 DECIMAL(5,0), @PERCENT DECIMAL(6,4), @PROFPERCENT DECIMAL(6,4), @TECHPERCENT DECIMAL(6,4), @CAPITATED DECIMAl(1,0), @ENDPROC VARCHAR(15), @TODATE DATETIME, @USUALBILL DECIMAL(12, 2),@USEUSUALBILL DECIMAL(1,0), @MAXAMT DECIMAL(15,2), @OVERRIDE_MODIF DECIMAL(1,0), @SCHEME_NAME VARCHAR(50), @SCHEME_TYPE VARCHAR(25), @PENDCLAIM BIT, @FEESCHEDS_ID INT, @ISEXTFEESCHED BIT, @OU_ISPENDED BIT, @OU_PHCode VARCHAR(1) = ''  
					-- GET FEESET INFO
					exec [EZCAP65TEST].[EZCAPDB].[DBO].[CHCNEDI_GetFeeSetInfo] @in_CompanyId='CHCNCHC',@in_Prov_KeyId=@IN_REQPROV_KEYID,@in_VendorId=@VENDORID,@in_Memb_KeyID=@IN_MEMB_KEYID,@in_HPCode=@IN_HPCODE,@in_OPT=@IN_OPT,@in_EmpGrp='',@in_LOB=@LOB,@in_ISHPGlobal=1,@in_FromServiceDate=@IN_AUTHDATE,@in_PHCode=@PHCODE,@in_ProcCode=@PROCCODE,@in_PServiceCode=@PROCCODE,@in_HServiceCode='',@in_DiagCode='',@in_POS=@IN_PLACESVC,@in_ModIF='',@in_ModIF2='',@in_AuthExists='Y',@in_Spec=@IN_SPECCODE,@in_ProvContract=@REQPROV_CONTRACT,@in_ProvClass=@REQPROV_CLASS,@in_CLAIMTYPE='AUTH', @FEESET_ID=@FEESET_ID OUTPUT, @FEESET_PERCENT =@FEESET_PERCENT OUTPUT,@FEESET_DESCR =@FEESET_DESCR OUTPUT, @EXTFEESET_ID= @EXTFEESET_ID OUTPUT, @EXTFEESET_PERCENT = @EXTFEESET_PERCENT OUTPUT, @EXTFEESET_DESCR = @EXTFEESET_DESCR OUTPUT, @MODSET = @MODSET OUTPUT,  @FEESBY_ASSIGNS_ID = @FEESBY_ASSIGNS_ID OUTPUT, @BASIS = @BASIS OUTPUT, @RATE1 = @RATE1 OUTPUT, @RATE2= @RATE2 OUTPUT,@RATE3= @RATE3 OUTPUT, @RATE4= @RATE4 OUTPUT, @DAYS1= @DAYS1 OUTPUT, @DAYS2 = @DAYS2 OUTPUT, @DAYS3 = @DAYS3 OUTPUT, @PERCENT = @PERCENT OUTPUT, @PROFPERCENT = @PROFPERCENT OUTPUT, @TECHPERCENT = @TECHPERCENT OUTPUT,  @CAPITATED= @CAPITATED OUTPUT,@ENDPROC = @ENDPROC OUTPUT,@TODATE = @TODATE OUTPUT, @USUALBILL=@USEUSUALBILL OUTPUT, @USEUSUALBILL = @USEUSUALBILL OUTPUT, @MAXAMT = @MAXAMT OUTPUT,
				  @OVERRIDE_MODIF = @OVERRIDE_MODIF OUTPUT,@SCHEME_NAME = @SCHEME_NAME OUTPUT, @SCHEME_TYPE = @SCHEME_TYPE OUTPUT,@PENDCLAIM = @PENDCLAIM OUTPUT, @FEESCHEDS_ID = @FEESCHEDS_ID OUTPUT, 
				  @ISEXTFEESCHED = @ISEXTFEESCHED OUTPUT, @OU_ISPENDED = @OU_ISPENDED OUTPUT, @OU_PHCode = @OU_PHCode OUTPUT 
				  
					UPDATE #authtemp_cpt
					SET PENDED = ISNULL(@OU_ISPENDED,''),CAPITATED = ISNULL(@CAPITATED,'0'), FEESETID = @FEESET_ID, FEESCHEDS_ID = ISNULL(@FEESCHEDS_ID,''), FEESET_PERCENT = ISNULL(@FEESET_PERCENT,'0.00'), EXCFEESET = @EXTFEESET_ID, EXCFEESET_PERCENT = ISNULL(@EXTFEESET_PERCENT,'0.00'),  MODIFSET=@MODSET, PRICEBASIS=ISNULL(@BASIS,'0'), FEESETASSIGNID =  @FEESBY_ASSIGNS_ID
					WHERE ID = @ID
			
					
					-- GET FINANCIALRESP INFO
					-- ADD DEFAULT VALUES, CTA, 01/21/2014
					DECLARE @OU_FINANCIALRESPID INT, @OU_PAYACTION VARCHAR(50)
					DECLARE @DEFAULT INT 
					
					SELECT @DEFAULT=COMMON_ID FROM [EZCAP65TEST].[EZCAPDB].[DBO].[COMMON_CODES_V] WHERE CATEGORY_NAME = 'FINRESP' AND CODE='EZ-CAP'
									
					EXEC [EZCAP65TEST].[EZCAPDB].[dbo].[CHCNEDI_GetFinancialResp] @PHCode=@PHCODE,@Proc=@PROCCODE,@RespSetCode=@FINRESPSET,@SvcDate=@IN_AUTHDATE,@Place=@IN_PLACESVC,@BenfitRule=@OU_MASTERID, @DiagCode='',@Modif='',@IsBenefitRule=0,@Memb_KeyID=@IN_MEMB_KEYID,@Prov_KeyID=@IN_REQPROV_KEYID,@strSpec=@IN_SPECCODE, @PAYACTION= @OU_PAYACTION output,@FINANCIALRESPID= @OU_FINANCIALRESPID output 
			
					PRINT 'FINANCE RESP ID: ' + CAST(@OU_FINANCIALRESPID AS CHAR) 		  
					
					UPDATE #authtemp_cpt
					SET FINANCIALRESP = CASE WHEN NULLIF(@OU_FINANCIALRESPID,'') IS NULL THEN @DEFAULT ELSE @OU_FINANCIALRESPID END, 
					PAYACTION = CASE WHEN NULLIF(@OU_PAYACTION,'' ) IS NULL THEN 1 ELSE @OU_PAYACTION END
					WHERE ID = @ID
					
					-- CHECK FOR DUP AND PEND CODES
					PRINT 'CHECKING FOR DUPS AND PEND CODES'
					DECLARE @OU_PendCode0 Varchar(3), @OU_PendCode1 VARCHAR(3), @OU_PendCode2 VARCHAR(3),@OU_PendCode3 VARCHAR(3), @OU_PendCode4 VARCHAR(3),@OU_PendCode5 VARCHAR(3),@OU_PendCode6 VARCHAR(3), 
		@OU_PendCode7 VARCHAR(3),@OU_PendCode8 VARCHAR(3),@OU_PendCode9 VARCHAR(3),@OU_PendCode10 VARCHAR(3),@OU_PendCode11 VARCHAR(3),@OU_PendCode12 VARCHAR(3),@OU_PendCode13 VARCHAR(3),@OU_PendCode14 VARCHAR(3),@OU_PendCode15 VARCHAR(3), @OU_PendCode16 VARCHAR(3)
					EXEC [EZCAP65TEST].[EZCAPDB].[dbo].[CHCNEDI_Auth_Preprice_DetailValidation] @in_ECDServer='EZCAP65TEST',@in_AuthNo='',@in_Prov_KeyId=@IN_REQPROV_KEYID,@in_ModifierCode='',@in_Memb_KeyID=@IN_MEMB_KEYID,@in_HpCode=@IN_HPCODE,@in_Opt=@in_OPT,@in_Emp='',@in_IsHPGlobal=1,@in_SpecCode=@IN_SPECCODE,@in_AuthActionDate=@IN_AUTHDATE,@in_AuthRequested=@IN_REQDATE,@in_Request_Type='A',@in_AuthExprDate=@IN_EXPRDATE,@in_Diag='',@in_PH=@PHCODE,@in_ServiceCode=@PROCCODE,@in_ServiceCodeID=0,@in_TBLROWID=0,@in_AdjustCodeIDs='',@OU_PendCode0 = @OU_PendCode0 OUTPUT, @OU_PendCode1 = @OU_PendCode1 OUTPUT, @OU_PendCode2 = @OU_PendCode2 OUTPUT, @OU_PendCode3 = @OU_PendCode3 OUTPUT, @OU_PendCode4 = @OU_PendCode4 OUTPUT, @OU_PendCode5 = @OU_PendCode5 OUTPUT, @OU_PendCode6 = @OU_PendCode6 OUTPUT, @OU_PendCode7 = @OU_PendCode7 OUTPUT, @OU_PendCode8 = @OU_PendCode8 OUTPUT, @OU_PendCode9 = @OU_PendCode9 OUTPUT, @OU_PendCode10 = @OU_PendCode10 OUTPUT, @OU_PendCode11 = @OU_PendCode11 OUTPUT, @OU_PendCode12 = @OU_PendCode12 OUTPUT, @OU_PendCode13 = @OU_PendCode13 OUTPUT, @OU_PendCode14 = @OU_PendCode14 OUTPUT, @OU_PendCode15 = @OU_PendCode15 OUTPUT, @OU_PendCode16 = @OU_PendCode16 OUTPUT
			
					-- APPLY STATUS 8 IF ANY PENDCODES RETURNED
					IF NULLIF(@OU_PendCode0,'') IS NOT NULL OR NULLIF(@OU_PendCode1,'') IS NOT NULL OR	NULLIF(@OU_PendCode2,'') IS NOT NULL OR NULLIF(@OU_PendCode3,'') IS NOT NULL OR	NULLIF(@OU_PendCode4,'') IS NOT NULL OR NULLIF(@OU_PendCode5,'') IS NOT NULL OR	NULLIF(@OU_PendCode6,'') IS NOT NULL OR NULLIF(@OU_PendCode7,'') IS NOT NULL OR NULLIF(@OU_PendCode8,'') IS NOT NULL OR NULLIF(@OU_PendCode9,'') IS NOT NULL OR	NULLIF(@OU_PendCode10,'') IS NOT NULL OR NULLIF(@OU_PendCode11,'') IS NOT NULL OR NULLIF(@OU_PendCode12,'') IS NOT NULL OR NULLIF(@OU_PendCode13,'') IS NOT NULL OR	NULLIF(@OU_PendCode14,'') IS NOT NULL OR NULLIF(@OU_PendCode15,'') IS NOT NULL OR NULLIF(@OU_PendCode16,'') IS NOT NULL
						BEGIN
							SET @IN_STATUS = (SELECT COMMON_ID FROM [EZCAP65TEST].[EZCAPDB].dbo.COMMON_CODES_V WHERE CATEGORY_NAME='AUTHSTATUS' AND  CODE = '8' AND CURRHIST='C')
						END		
		 			
 					UPDATE #authtemp_cpt
					SET P0 = @OU_PendCode0,P1 = @OU_PendCode1,P2 = @OU_PendCode2,P3 = @OU_PendCode3,P4 = @OU_PendCode4,P5 = @OU_PendCode5,P6 = @OU_PendCode6,P7 = @OU_PendCode7,P8 = @OU_PendCode8,P9 = @OU_PendCode9,P10 = @OU_PendCode10,P11 = @OU_PendCode11,P12 = @OU_PendCode12,P13 = @OU_PendCode13,P14 = @OU_PendCode14,P15 = @OU_PendCode15,P16 = @OU_PendCode16
					WHERE ID = @ID		
					
					-- SET DUP FLAG IF PEND CODE 16=DUP
					IF  @OU_PendCode16 = 'DUP'
						BEGIN
							SET @ISDUP = 1
							PRINT 'ISDUP: YES' 
						END
				
				insert into #authtemp_cpt_xml (CPTRecord)
				-- UPDATE @IN_DIAGCODE1 TO @DIAGCODE, CTA, 01/29/2015
                SELECT DISTINCT
                        '<Authdetails><ADJCODE>0</ADJCODE><ADJCODEWH>0</ADJCODEWH><NURSEHOME>0</NURSEHOME><FINANCIALRESP>'
                        + CAST(FINANCIALRESP AS VARCHAR) + '</FINANCIALRESP>'
                        + CASE WHEN NULLIF(MODIF, '-1') IS NULL THEN ''
                               ELSE '<MODIF>' + MODIF + '</MODIF>'
                          END + '<PHCODE>' + PHCODE + ' - '
                        + CAST(PROCCODE AS VARCHAR) + '</PHCODE><PROCCODE>'
                        + CAST(PROCCODE AS VARCHAR) + '</PROCCODE><PENDED>'
                        + CASE WHEN NULLIF(PENDED, '') IS NULL THEN '0'
                               ELSE CAST(PENDED AS VARCHAR)
                          END + '</PENDED><BENTYPE>0</BENTYPE><DESCRIPTION>'
                        + REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(PROCDESC,
                                                              '&', '+'), '''',
                                                          ''''''), '<', '&lt;'),
                                          '>', '&gt;'), '/', ';')
                        + '</DESCRIPTION><CONTRVAL>0.00</CONTRVAL><WITHHOLD>0.00</WITHHOLD><COPAY>0.00</COPAY><COINSURANCE>0.00</COINSURANCE><NET>0.00</NET><BATCH>0</BATCH><PAYACTION>'
                        + CASE WHEN NULLIF(PAYACTION, '') IS NULL THEN '0'
                               ELSE '1'
                          END + '</PAYACTION><QTY>' + CAST(QTY AS VARCHAR)
                        + '</QTY><DIAGREFNUM>1</DIAGREFNUM>'
                        + CASE WHEN NULLIF(P0, '') IS NULL THEN '<P0/>'
                               ELSE '<P0>' + P0 + '</P0>'
                          END + CASE WHEN NULLIF(P1, '') IS NULL THEN '<P1/>'
                                     ELSE '<P1>' + P1 + '</P1>'
                                END
                        + CASE WHEN NULLIF(P2, '') IS NULL THEN '<P2/>'
                               ELSE '<P2>' + P2 + '</P2>'
                          END + CASE WHEN NULLIF(P3, '') IS NULL THEN '<P3/>'
                                     ELSE '<P3>' + P3 + '</P3>'
                                END
                        + +CASE WHEN NULLIF(P4, '') IS NULL THEN '<P4/>'
                                ELSE '<P4>' + P4 + '</P4>'
                           END + CASE WHEN NULLIF(P5, '') IS NULL THEN '<P5/>'
                                      ELSE '<P5>' + P5 + '</P5>'
                                 END
                        + CASE WHEN NULLIF(P6, '') IS NULL THEN '<P6/>'
                               ELSE '<P6>' + P6 + '</P6>'
                          END + CASE WHEN NULLIF(P7, '') IS NULL THEN '<P7/>'
                                     ELSE '<P7>' + P7 + '</P7>'
                                END + '<DIAGCODE>' + @DIAGCODE
                        + '</DIAGCODE><COVERED>0.00</COVERED><NOTCOVERED>0</NOTCOVERED><DEDUCTIBLE>0.00</DEDUCTIBLE><SEQUENCE>'
                        + CAST(@ID AS VARCHAR)
                        + '</SEQUENCE><OOP>0</OOP><CAPITATED>'
                        + CASE WHEN CAPITATED IS NULL THEN ''
                               ELSE CAST(CAPITATED AS VARCHAR)
                          END
                        + '</CAPITATED><COVEREDYN>1</COVEREDYN><COUNTUTILIZ>0</COUNTUTILIZ><ADJUST>0.00</ADJUST><ALLOWED>0.00</ALLOWED><USUALCHARGE>0.00</USUALCHARGE><DISCAT/>'
                        + CASE WHEN NULLIF(P8, '') IS NULL THEN '<P8/>'
                               ELSE '<P8>' + P8 + '</P8>'
                          END + CASE WHEN NULLIF(P9, '') IS NULL THEN '<P9/>'
                                     ELSE '<P9>' + P9 + '</P9>'
                                END
                        + '<ADMITDATE>0001-01-01T00:00:00-08:00</ADMITDATE><DSCHDATE>0001-01-01T00:00:00-08:00</DSCHDATE><ADMTYPE/><ADMSOURCE/><PATSTATUS/><BMMASTERID>'
                        + CAST(BMMASTERID AS VARCHAR)
                        + '</BMMASTERID><BM_LEVEL>0</BM_LEVEL>'
                        + CASE WHEN NULLIF(P10, '') IS NULL THEN '<P10/>'
                               ELSE '<P10>' + P10 + '</P10>'
                          END
                        + '<NETWORK>0</NETWORK><BM_DETAILID_L4>0</BM_DETAILID_L4><DEDUCTIBLE_L2>0.00</DEDUCTIBLE_L2><OOP_L2>0</OOP_L2><DEDUCTIBLE_L4>0.00</DEDUCTIBLE_L4><OOP_L4>0</OOP_L4><APPDEDTOMASTERDED_L2>0</APPDEDTOMASTERDED_L2><APPDEDTOMASTEROOP_L2>0</APPDEDTOMASTEROOP_L2><APPDEDTOMASTERDED_L4>0</APPDEDTOMASTERDED_L4><APPDEDTOMASTEROOP_L4>0</APPDEDTOMASTEROOP_L4><L2DedExists>0</L2DedExists><L4DedExists>0</L4DedExists><DeductibleAdvRule/><StatusFlag>I</StatusFlag><ADJUSTDESC/><chckCapitated>false</chckCapitated><chckCovered>true</chckCovered><chckApplypayments>false</chckApplypayments><AspGroupID>0</AspGroupID><PROCCODE_ID>'
                        + CAST(COMMON_ID AS VARCHAR) + '</PROCCODE_ID>'
                        + CASE WHEN NULLIF(P11, '') IS NULL THEN '<P11/>'
                               ELSE '<P11>' + P11 + '</P11>'
                          END
                        + CASE WHEN NULLIF(P12, '') IS NULL THEN '<P12/>'
                               ELSE '<P12>' + P12 + '</P12>'
                          END
                        + CASE WHEN NULLIF(P13, '') IS NULL THEN '<P13/>'
                               ELSE '<P13>' + P13 + '</P13>'
                          END
                        + CASE WHEN NULLIF(P14, '') IS NULL THEN '<P14/>'
                               ELSE '<P14>' + P14 + '</P14>'
                          END
                        + CASE WHEN NULLIF(P15, '') IS NULL THEN '<P15/>'
                               ELSE '<P15>' + P15 + '</P15>'
                          END
                        + CASE WHEN NULLIF(P16, '') IS NULL THEN '<P16/>'
                               ELSE '<P16>' + P16 + '</P16>'
                          END + '<AUTHDATE>' + @IN_AUTHDATE
                        + '</AUTHDATE><EXPRDATE>' + @IN_EXPRDATE
                        + '</EXPRDATE><REQDQTY>0</REQDQTY><SVCCODELONGDESC>'
                        + REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(PROCDESC,
                                                              '&', '+'), '''',
                                                          ''''''), '<', '&lt;'),
                                          '>', '&gt;'), '/', ';')
                        + '</SVCCODELONGDESC><FEESETID>'
                        + ISNULL(CAST(FEESETID AS VARCHAR), '')
                        + '</FEESETID><ISEXTFEESET>False</ISEXTFEESET><FEESCHEDS_ID>'
                        + CASE WHEN FEESCHEDS_ID IS NULL THEN ''
                               ELSE CAST(FEESCHEDS_ID AS VARCHAR)
                          END + '</FEESCHEDS_ID><FEESET>'
                        + ISNULL(CAST(FEESETID AS VARCHAR), '')
                        + '</FEESET><FEESET_PERCENT>'
                        + ISNULL(CAST(FEESET_PERCENT AS VARCHAR), '')
                        + '</FEESET_PERCENT><EXCFEESET>'
                        + ISNULL(CAST(EXCFEESET AS VARCHAR), '')
                        + '</EXCFEESET><EXCFEESET_PERCENT>'
                        + ISNULL(CAST(EXCFEESET_PERCENT AS VARCHAR), '')
                        + '</EXCFEESET_PERCENT><PRICEBASIS>'
                        + CASE WHEN NULLIF(PRICEBASIS, '') IS NULL THEN ''
                               ELSE CAST(PRICEBASIS AS VARCHAR)
                          END
                        + '</PRICEBASIS><RVU>0</RVU><CLAIM_TIMEUNITS>0</CLAIM_TIMEUNITS><ALLOWEDAMOUNT>0</ALLOWEDAMOUNT><ISSERVICEIN_FEESET>True</ISSERVICEIN_FEESET><ISSERVICEIN_EXCFEESET>False</ISSERVICEIN_EXCFEESET><ISMODIFOVERRIDE>False</ISMODIFOVERRIDE><ISPENDCLAIM>False</ISPENDCLAIM><ISPROVALLOWAMTUSED>False</ISPROVALLOWAMTUSED><WITHHOLDSET/><WITHHOLD_PERCENT>0</WITHHOLD_PERCENT><WITHHOLD_VALUE>0.00</WITHHOLD_VALUE><CONTRACTCODE>'
                        + @REQPROV_CONTRACT
                        + '</CONTRACTCODE><ISHMOIN>True</ISHMOIN><MODIFSET>'
                        + ISNULL(CAST(MODIFSET AS VARCHAR), '')
                        + '</MODIFSET><BMLEVEL>0-0</BMLEVEL><BMRULEID>0</BMRULEID><HPOPTION>CHCN+'
                        + @in_OPT + '</HPOPTION><FINRESPSET>'
                        + ISNULL(CAST(FINRESPSET AS VARCHAR), '')
                        + '</FINRESPSET><ISCOVERED>True</ISCOVERED><ISCOPAY>False</ISCOPAY><COINSURANCE_PERCENT>NONE</COINSURANCE_PERCENT><ISAPPLYPAYMENTS>False</ISAPPLYPAYMENTS><ISHOSPADMN>False</ISHOSPADMN><COPAYAMT>0</COPAYAMT><DUMMYCLAIMNO>QUICKENTRY</DUMMYCLAIMNO><FEESETASSIGNID>'
                        + ISNULL(CAST(FEESETASSIGNID AS VARCHAR), '')
                        + '</FEESETASSIGNID></Authdetails>'			
				from #authtemp_cpt
				where ID=@id
						
				select @in_AuthDetails = @in_AuthDetails+CPTRecord
				from #authtemp_cpt_xml
				where id=@id
				order by id
						
				PRINT @IN_AUTHDETAILS
				
				SET @id = (SELECT MIN(id) FROM #authtemp_cpt WHERE ID > @id)
			END
				
			set @in_AuthDetails = '<DocumentElement>'+@in_AuthDetails+'</DocumentElement>'
			
			print 'AUTH DETAILS:' +@in_AuthDetails
				
			-- Drop temp tables
			drop table #authtemp_icd
			DROP TABLE [#authtemp_icdlist]
			drop table #authtemp_cpt
			DROP TABLE #authtemp_cpt_xml
		END		

		
		--set @IN_REQDATE = GETDATE() for testing only
        EXEC @PostAuthResult = [EZCAP65TEST].[EZCAPDB].dbo.CHCNEDI_AuthMaster_CRUDOperations @in_DMLType = 'U',
        @in_AUTHNO = @in_AUTHNO, @in_HPCODE = @in_HPCODE, @in_OPT = @in_OPT,
        @in_AUTHDETAILS = @in_AUTHDETAILS,
        @in_AUTHPCP_KEYID = @in_AUTHPCP_KEYID, @in_MEMB_KEYID = @in_MEMB_KEYID,
        @in_CreatedBy = @in_CreatedBy, @in_REQPROV_KEYID = @in_REQPROV_KEYID,
        @in_REQSPEC = @IN_SPECCODE, @in_REQPROV = @in_REQPROV,
        @in_FACPROVID = @in_FACPROVID, @in_SVCFACID_KEYID = @in_SVCFACID_KEYID,
        @in_AUTHDATE = @in_AUTHDATE, @in_EXPRDATE = @in_EXPRDATE,
        @in_COMPANY_ID = @in_COMPANY_ID, @in_AUTHPCP = @in_AUTHPCP,
        @in_MEMBID = @in_MEMBID, @in_MEMBNAME = @in_MEMBNAME,
        @in_PLACESVC = @OU_PLACESVC, @in_REQDATE = @in_REQDATE,
        @in_DiagCode1 = @in_DiagCode1, @in_DiagCode2 = @in_DiagCode2,
        @in_DiagCode3 = @in_DiagCode3, @in_DiagCode4 = @in_DiagCode4,
        @in_DiagCode5 = @in_DiagCode5, @in_DiagCode6 = @in_DiagCode6,
        @in_DiagCode7 = @in_DiagCode7, @in_DiagCode8 = @in_DiagCode8,
        @in_DiagCode9 = @in_DiagCode9, @in_DiagCode10 = @in_DiagCode10,
        @in_DiagCode11 = @in_DiagCode11, @in_DiagCode12 = @in_DiagCode12,
        @in_CHCNEDI_RequestID = @REQUESTID, @in_BATCH = @BATCHID,
        @in_FaxToNumber = @in_FaxToNumber, @in_Notes = @in_Notes,
        @in_UnlistedProv = @in_UnlistedProv,
        @in_ReqPhoneNumber = @in_ReqPhoneNumber, @in_ReqName = @in_ReqName,
        @isDUP = @isDUP, @in_STATUS = @in_STATUS, @in_PRIORITY = @in_PRIORITY,
        @in_ReqCat = @in_ReqCat, @in_ACCT = @in_ACCT,
        @in_SUBACCT = @in_SUBACCT, @in_CERTTYPE = @in_CERTTYPE,
        @in_SVCTYPE = @in_SVCTYPE, @in_PSTATUS = @in_PSTATUS,
        @in_CASENO = @in_CASENO, @in_HPAUTHNO = @in_HPAUTHNO,
        @in_LOS = @in_LOS, @in_CONTRVAL = @in_CONTRVAL,
        @in_WITHHOLD = @in_WITHHOLD, @in_COPAY = @in_COPAY,
        @in_COINSURANCE = @in_COINSURANCE, @in_NET = @in_NET,
        @in_EDIREF = @in_EDIREF, @in_XPDATE = @in_XPDATE,
        @in_XPSTATUS = @in_XPSTATUS, @in_XPTRAN = @in_XPTRAN,
        @in_OUTLOADDT = @in_OUTLOADDT, @in_AUTHUNITS = @in_AUTHUNITS,
        @in_ISUNITLIMIT = @in_ISUNITLIMIT,
        @in_ISDOLLARLIMIT = @in_ISDOLLARLIMIT, @in_AUTOSTATUS = @in_AUTOSTATUS,
        @in_P1 = @in_P1, @in_P2 = @in_P2, @in_P3 = @in_P3, @in_P4 = @in_P4,
        @in_P5 = @in_P5, @in_P6 = @in_P6, @in_P7 = @in_P7, @in_P8 = @in_P8,
        @in_P9 = @in_P9, @in_P10 = @in_P10, @in_HOSPBILL = @in_HOSPBILL,
        @in_COB = @in_COB, @in_VENDOR = @in_VENDOR, @in_ACCIDDT = @in_ACCIDDT,
        @in_LMPDT = @in_LMPDT, @in_ESTDOB = @in_ESTDOB,
        @in_ONSETDT = @in_ONSETDT, @in_EDI_AUTH_ID = @in_EDI_AUTH_ID,
        @in_ASPCODE = @in_ASPCODE, @in_SUGGESTED_STATUS = @in_SUGGESTED_STATUS,
        @in_GENERATED_BY = @in_GENERATED_BY,
        @in_BMSETWINRULE = @in_BMSETWINRULE, @in_ModifiedBy = @in_CreatedBy, --SK.12/15/2015 Changed from @in_ModifiedBy due to the change made on CHCNEDI_AuthMaster_CRUDOperations for MDREVIEW process
        @in_ModifiedDate = @in_ModifiedDate, @in_P11 = @in_P11,
        @in_P12 = @in_P12, @in_P13 = @in_P13, @in_P14 = @in_P14,
        @in_P15 = @in_P15, @in_WFQueued = @in_WFQueued,
        @in_AdjudicationID = @in_AdjudicationID,
        @in_PriceStatus = @in_PriceStatus, @in_IsEZNET = @in_IsEZNET,
        @in_IsHPGlobal = @in_IsHPGlobal,
        @in_IsUnitLimitDetail = @in_IsUnitLimitDetail,
        @in_IsDollarLimitDetail = @in_IsDollarLimitDetail,
        @in_ReqdUnits = @in_ReqdUnits, @in_Request_Type = @in_Request_Type,
        @in_AuthSource = @in_AuthSource, @in_ECDServer = 'EZCAP65TEST',
        @AuditLog = @AuditLog, @in_EnbleAudit = 1,
        @in_RefToProvFax = @in_RefToProvFax, @ou_IntRetValue = @RESULTS OUTPUT; ;
		PRINT 'Finished Post Auth' + @RESULTS


		
END TRY
BEGIN CATCH
SET @RESULTS = '<br />There was an error submitting your authorization request. Please forward the following message to IT for review.'
SET @RESULTS = @RESULTS + '<BR /><BR />ERROR: ' + ERROR_PROCEDURE() +  ' line No:' + + CAST(ERROR_LINE() AS VARCHAR(50)) + '<br />' + ERROR_MESSAGE()END CATCH
END



GO
