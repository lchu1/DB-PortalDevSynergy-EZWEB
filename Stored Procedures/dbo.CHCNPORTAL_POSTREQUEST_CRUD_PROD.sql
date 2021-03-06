SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





CREATE PROCEDURE [dbo].[CHCNPORTAL_POSTREQUEST_CRUD_PROD]

@REQUESTID VARCHAR (30),
@OU_AUTHNO VARCHAR (30) OUTPUT,
@RESULTS varchar(7000) OUTPUT


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
DECLARE @SQL varchar(500)
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

BEGIN TRY

	SET @IN_ONSETDT = NULL
	SET @IN_AUTHUNITS = NULL
	SET @IN_CERTTYPE = NULL

	-- MAP AUTH MASTER RECORDS
	-- UPDATE DATE FORMATS TO MM/DD/YYYY, CTA, 01/27/2015
	-- SET STATUS TO DEFAULT TO 7, CTA, 01/27/2015
	-- SET STATUS TO Z WHEN REFPROVID OR FACILITY = UNKNOWNNPI2, CTA, 01/30/2015
	SELECT @IN_STATUS = CASE WHEN A.AUTHPCP_ProvID = 'UNKNOWNNPI2' OR A.RefToProvID = 'UNKNOWNNPI2' OR A.Facility_ProvID ='UNKNOWNNPI2' THEN 'Z' WHEN A.REQUESTTYPE='U' THEN 'N' ELSE '7' END, @IN_PRIORITY = CASE A.REQUESTTYPE WHEN '7'  THEN '2' WHEN 'U' THEN '1' WHEN 'R' THEN '3' ELSE '0' END,@IN_MEMBNAME = A.MembName,  @in_MEMBID = A.MEMBID, @in_PLACESVC = A.PlaceSvc_Code,@in_ESTDOB = A.NEWBORNDOB,@in_MEMB_KEYID = A.MEMB_KEYID, @in_HPCODE = MC.HPCODE, @in_OPT = MC.OPT, @in_COMPANY_ID =MC.COMPANY_ID,  @IN_AUTHPCP = A.AUTHPCP_PROVID,@IN_AUTHPCP_KEYID=A.AUTHPCP_KEYID,  
	@IN_REQPROV = A.REFTOPROVID, @IN_REQPROV_KEYID = A.REFTOPROV_KEYID, @in_FACPROVID = A.FACILITY_PROVID, @in_SVCFACID_KEYID = A.FACILITY_PROV_KEYID,
	@IN_SPECCODE = A.RefToSpec,@IN_REQPHONENUMBER  = A.AUTHPCP_OfficeContactPhone, @IN_FAXTONUMBER = A.AUTHPCP_OfficeContactFAX, @IN_REQNAME = A.AUTHPCP_OfficeContactName, @IN_AUTHDATE = CONVERT(VARCHAR,A.ServiceStartDate,101),@IN_EXPRDATE = CONVERT(VARCHAR,A.ServiceEndDate,101) ,  @IN_NOTES = A.Notes_ForEZCAP, @IN_REQDATE =  GETDATE(),@REQPROV_CLASS = RP.CLASS,@REQPROV_CONTRACT = RP.CONTRACT, @AUTHPCP_CLASS = AP.CLASS,@AUTHPCP_CONTRACT = AP.CONTRACT,@AUTHPCP_SPECCODE = [AS].SPECCODE, @VENDORID=V.VENDOR, @IN_UNLISTEDPROV=A.AUTHPCP_UnlistedName
	,@IN_REFTOPROVFAX=A.RefToProvFax
	,@AuthPCP_CompanyID = A.AUTHPCP_Company
	FROM [EZWEB].[dbo].[CHCNAuthReq_Master] A LEFT JOIN [EZCAP65TEST].[EZCAPDB].[dbo].[MEMB_COMPANY_V] MC ON MC.MEMB_KEYID = A.MEMB_KEYID LEFT JOIN [EZCAP65TEST].[EZCAPDB].[dbo].[PROV_SPECINFO_V] PS ON A.REFTOPROV_KEYID = PS.PROV_KEYID AND PS.TYPE='PRIMARY' 
	-- ADDED 01/01/2015, CTA
	LEFT JOIN  [EZCAP65TEST].[EZCAPDB].[dbo].[PROV_COMPANY_V] RP ON A.RefToProv_KeyID = RP.PROV_KEYID LEFT JOIN  [EZCAP65TEST].[EZCAPDB].[dbo].[PROV_COMPANY_V] AP ON A.RefToProv_KeyID = AP.PROV_KEYID 
	LEFT JOIN [EZCAP65TEST].[EZCAPDB].[dbo].[PROV_SPECINFO_V] [AS] ON A.RefToProv_KeyID = [AS].PROV_KEYID AND [AS].[TYPE]='PRIMARY' LEFT JOIN  [EZCAP65TEST].[EZCAPDB].[dbo].[PROV_VENDINFO_V] V ON A.RefToProv_KeyID = V.PROV_KEYID
	WHERE A.RequestID =@REQUESTID

	-- SET DEFAULT AUTH EXPIRATION DATE
	SET @IN_EXPRDATE = CASE WHEN @in_OPT LIKE 'AACC' THEN '12/31/2014' ELSE @IN_EXPRDATE END

	SELECT @in_CreatedBy = '10209' 

	-- ASSIGN REQUEST CATEGORY FE WHEN POS=21,31,61
	SELECT @IN_REQCAT = CASE WHEN @IN_PLACESVC in ('21', '31', '61') THEN COMMON_ID ELSE '' END 
	FROM [EZCAP65TEST].[EZCAPDB].[DBO].[COMMON_CODES_V] WHERE CODE='FE' AND CATEGORY_NAME ='AUTHREQUESTCATG' AND CURRHIST='C'

	-- Added to set Request Category as 'DR' when found a service code beginning with 'J' --Jose, SK.6/15/2016
	IF @IN_REQCAT = '' AND EXISTS (SELECT * FROM CHCNAuthReq_CPT_Temp WHERE RequestID = @REQUESTID AND ProcCode LIKE 'J%')
		BEGIN
			SELECT @IN_REQCAT = COMMON_ID FROM [EZCAP65TEST].[EZCAPDB].[DBO].[COMMON_CODES_V] WHERE CODE='DR' AND CATEGORY_NAME ='AUTHREQUESTCATG' AND CURRHIST='C'
		END

	SET @OU_PLACESVC = (SELECT COMMON_ID FROM [EZCAP65TEST].[EZCAPDB].dbo.COMMON_CODES_V WHERE CATEGORY_NAME='PLACESVC' AND  CODE = @in_PLACESVC AND CURRHIST='C') 
	SET @IN_STATUS = (SELECT COMMON_ID FROM [EZCAP65TEST].[EZCAPDB].dbo.COMMON_CODES_V WHERE CATEGORY_NAME='AUTHSTATUS' AND  CODE = @IN_STATUS AND CURRHIST='C')
	SET @in_PRIORITY = (SELECT COMMON_ID FROM [EZCAP65TEST].[EZCAPDB].dbo.COMMON_CODES_V WHERE CATEGORY_NAME='AUTHPRIORITYSTATUS' AND  CODE= @in_PRIORITY AND CURRHIST='C') 
	--SET @in_REQDUNITS= CASE WHEN (SELECT sum(CAST(Qty as INT)) as expr1 FROM CHCNAUTHREQ_CPT_TEMP WHERE REQUESTID = @REQUESTID) = 0 THEN 1 ELSE (SELECT sum(CAST(Qty as INT)) as expr1 FROM CHCNAUTHREQ_CPT_TEMP WHERE REQUESTID = @REQUESTID) END

	--Request from CM - SW, Carla to remove automatic update of Auth/Req'd units SK.6/22/2016
	IF ISNULL(@IN_PLACESVC,'') <> '21'
		BEGIN	
			SET @in_REQDUNITS= CASE WHEN (SELECT sum(CAST(Qty as INT)) as expr1 FROM CHCNAUTHREQ_CPT_TEMP WHERE REQUESTID = @REQUESTID) = 0 THEN 1 
				ELSE (SELECT sum(CAST(Qty as INT)) as expr1 FROM CHCNAUTHREQ_CPT_TEMP WHERE REQUESTID = @REQUESTID) END
		END	

	IF @in_ESTDOB IS NOT NULL
		BEGIN
			SET @in_SVCTYPE = (SELECT COMMON_ID FROM [EZCAP65TEST].[EZCAPDB].[DBO].[COMMON_CODES_V] WHERE CODE='65' AND CATEGORY_NAME='SVCTYPECODES' AND CURRHIST='C')
		END
	ELSE
		BEGIN
			SET @in_SVCTYPE = NULL
		END
	PRINT 'DX PROCESSING'
	-- Fill @in_Diag fields from AUTH_DIAGS_TEMP table
	CREATE TABLE #authtemp_icd (ID int IDENTITY(1,1),DX_Common_ID int)
	INSERT INTO #authtemp_icd (DX_Common_ID)
	SELECT Common_ID
	FROM CHCNAUTHREQ_ICD_TEMP
	WHERE REQUESTID = @REQUESTID
		
	CREATE TABLE #authtemp_icdlist (DX1 int,DX2 int, DX3 int, DX4 int, DX5 int, DX6 int, DX7 int, DX8 int, DX9 int, DX10 int, DX11 int, DX12 int)

	INSERT INTO  #authtemp_icdlist (DX1 ,DX2 , DX3 , DX4 , DX5 , DX6 , DX7 , DX8 , DX9 , DX10 , DX11 , DX12 )
	VALUES(null,null,null,null,null,null,null,null,null,null,null,null)

	SET @id = 1
	SELECT @num = (SELECT count(*) FROM CHCNAUTHREQ_ICD_TEMP WHERE REQUESTID = @REQUESTID)
		WHILE (@id <= @num)
			BEGIN
				SET @sql = 'update #authtemp_icdlist set DX'+CAST(@id as char)+' = i.DX_Common_ID from #authtemp_icd i where ID='+CAST(@id as char)
				EXEC (@sql)

				SET @id = @id+1
			END

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
				select distinct '<Authdetails><ADJCODE>0</ADJCODE><ADJCODEWH>0</ADJCODEWH><NURSEHOME>0</NURSEHOME><FINANCIALRESP>'+CAST(FINANCIALRESP AS VARCHAR)+'</FINANCIALRESP>'+CASE WHEN NULLIF(Modif,'-1') IS NULL THEN '' ELSE '<MODIF>'+MODIF+'</MODIF>' END+'<PHCODE>'+PHCODE+' - '+Cast(ProcCode as varchar)+'</PHCODE><PROCCODE>'+Cast(ProcCode as varchar)+'</PROCCODE><PENDED>'+CASE WHEN NULLIF(PENDED,'') IS NULL THEN '0' ELSE CAST(PENDED AS VARCHAR) END+'</PENDED><BENTYPE>0</BENTYPE><DESCRIPTION>'+REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(ProcDesc,'&','+'),'''',''''''), '<', '&lt;'), '>', '&gt;'),'/',';') + '</DESCRIPTION><CONTRVAL>0.00</CONTRVAL><WITHHOLD>0.00</WITHHOLD><COPAY>0.00</COPAY><COINSURANCE>0.00</COINSURANCE><NET>0.00</NET><BATCH>0</BATCH><PAYACTION>'+CASE WHEN NULLIF(PAYACTION,'') IS NULL THEN '0' ELSE '1' END+'</PAYACTION><QTY>'+Cast(Qty as varchar)+'</QTY><DIAGREFNUM>1</DIAGREFNUM>'+CASE WHEN NULLIF(P0,'') IS NULL THEN  '<P0/>' ELSE '<P0>'+P0+'</P0>' END+CASE WHEN NULLIF(P1,'') IS NULL THEN  '<P1/>' ELSE '<P1>'+P1+'</P1>' END+CASE WHEN NULLIF(P2,'') IS NULL THEN  '<P2/>' ELSE '<P2>'+P2+'</P2>' END+CASE WHEN NULLIF(P3,'') IS NULL THEN  '<P3/>' ELSE '<P3>'+P3+'</P3>' END++CASE WHEN NULLIF(P4,'') IS NULL THEN  '<P4/>' ELSE '<P4>'+P4+'</P4>' END+CASE WHEN NULLIF(P5,'') IS NULL THEN  '<P5/>' ELSE '<P5>'+P5+'</P5>' END+CASE WHEN NULLIF(P6,'') IS NULL THEN  '<P6/>' ELSE '<P6>'+P6+'</P6>' END+CASE WHEN NULLIF(P7,'') IS NULL THEN  '<P7/>' ELSE '<P7>'+P7+'</P7>' END+'<DIAGCODE>'+@DIAGCODE +'</DIAGCODE><COVERED>0.00</COVERED><NOTCOVERED>0</NOTCOVERED><DEDUCTIBLE>0.00</DEDUCTIBLE><SEQUENCE>'+Cast(@ID as varchar)+'</SEQUENCE><OOP>0</OOP><CAPITATED>'+CASE WHEN CAPITATED IS NULL THEN '' ELSE CAST(CAPITATED AS VARCHAR) END +'</CAPITATED><COVEREDYN>1</COVEREDYN><COUNTUTILIZ>0</COUNTUTILIZ><ADJUST>0.00</ADJUST><ALLOWED>0.00</ALLOWED><USUALCHARGE>0.00</USUALCHARGE><DISCAT/>'+CASE WHEN NULLIF(P8,'') IS NULL THEN  '<P8/>' ELSE '<P8>'+P8+'</P8>' END+CASE WHEN NULLIF(P9,'') IS NULL THEN  '<P9/>' ELSE '<P9>'+P9+'</P9>' END+'<ADMITDATE>0001-01-01T00:00:00-08:00</ADMITDATE><DSCHDATE>0001-01-01T00:00:00-08:00</DSCHDATE><ADMTYPE/><ADMSOURCE/><PATSTATUS/><BMMASTERID>'+CAST(BMMASTERID AS VARCHAR)+'</BMMASTERID><BM_LEVEL>0</BM_LEVEL>'+CASE WHEN NULLIF(P10,'') IS NULL THEN  '<P10/>' ELSE '<P10>'+P10+'</P10>' END+'<NETWORK>0</NETWORK><BM_DETAILID_L4>0</BM_DETAILID_L4><DEDUCTIBLE_L2>0.00</DEDUCTIBLE_L2><OOP_L2>0</OOP_L2><DEDUCTIBLE_L4>0.00</DEDUCTIBLE_L4><OOP_L4>0</OOP_L4><APPDEDTOMASTERDED_L2>0</APPDEDTOMASTERDED_L2><APPDEDTOMASTEROOP_L2>0</APPDEDTOMASTEROOP_L2><APPDEDTOMASTERDED_L4>0</APPDEDTOMASTERDED_L4><APPDEDTOMASTEROOP_L4>0</APPDEDTOMASTEROOP_L4><L2DedExists>0</L2DedExists><L4DedExists>0</L4DedExists><DeductibleAdvRule/><StatusFlag>I</StatusFlag><ADJUSTDESC/><chckCapitated>false</chckCapitated><chckCovered>true</chckCovered><chckApplypayments>false</chckApplypayments><AspGroupID>0</AspGroupID><PROCCODE_ID>'+Cast(Common_ID as varchar)+'</PROCCODE_ID>'+CASE WHEN NULLIF(P11,'') IS NULL THEN  '<P11/>' ELSE '<P11>'+P11+'</P11>' END+CASE WHEN NULLIF(P12,'') IS NULL THEN  '<P12/>' ELSE '<P12>'+P12+'</P12>' END +CASE WHEN NULLIF(P13,'') IS NULL THEN  '<P13/>' ELSE '<P13>'+P13+'</P13>' END+CASE WHEN NULLIF(P14,'') IS NULL THEN  '<P14/>' ELSE '<P14>'+P14+'</P14>' END+CASE WHEN NULLIF(P15,'') IS NULL THEN  '<P15/>' ELSE '<P15>'+P15+'</P15>' END+CASE WHEN NULLIF(P16,'') IS NULL THEN  '<P16/>' ELSE '<P16>'+P16+'</P16>'END+'<AUTHDATE>'+@in_AUTHDATE+'</AUTHDATE><EXPRDATE>'+@in_EXPRDATE+'</EXPRDATE><REQDQTY>0</REQDQTY><SVCCODELONGDESC>'+REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(ProcDesc,'&','+'),'''',''''''), '<', '&lt;'), '>', '&gt;'),'/',';') +'</SVCCODELONGDESC><FEESETID>'+ISNULL(CAST(FEESETID AS VARCHAR),'')+'</FEESETID><ISEXTFEESET>False</ISEXTFEESET><FEESCHEDS_ID>'+CASE WHEN FEESCHEDS_ID IS NULL THEN '' ELSE CAST(FEESCHEDS_ID AS VARCHAR) END+'</FEESCHEDS_ID><FEESET>'+ISNULL(CAST(FEESETID AS VARCHAR),'')+'</FEESET><FEESET_PERCENT>'+ISNULL(CAST(FEESET_PERCENT AS VARCHAR),'')+'</FEESET_PERCENT><EXCFEESET>'+ISNULL(CAST(EXCFEESET AS VARCHAR),'')+'</EXCFEESET><EXCFEESET_PERCENT>'+ISNULL(CAST(EXCFEESET_PERCENT AS VARCHAR),'')+'</EXCFEESET_PERCENT><PRICEBASIS>'+CASE WHEN NULLIF(PRICEBASIS,'') IS NULL THEN '' ELSE CAST(PRICEBASIS AS VARCHAR) END+'</PRICEBASIS><RVU>0</RVU><CLAIM_TIMEUNITS>0</CLAIM_TIMEUNITS><ALLOWEDAMOUNT>0</ALLOWEDAMOUNT><ISSERVICEIN_FEESET>True</ISSERVICEIN_FEESET><ISSERVICEIN_EXCFEESET>False</ISSERVICEIN_EXCFEESET><ISMODIFOVERRIDE>False</ISMODIFOVERRIDE><ISPENDCLAIM>False</ISPENDCLAIM><ISPROVALLOWAMTUSED>False</ISPROVALLOWAMTUSED><WITHHOLDSET/><WITHHOLD_PERCENT>0</WITHHOLD_PERCENT><WITHHOLD_VALUE>0.00</WITHHOLD_VALUE><CONTRACTCODE>'+@REQPROV_CONTRACT+'</CONTRACTCODE><ISHMOIN>True</ISHMOIN><MODIFSET>'+ISNULL(CAST(MODIFSET AS VARCHAR),'')+'</MODIFSET><BMLEVEL>0-0</BMLEVEL><BMRULEID>0</BMRULEID><HPOPTION>CHCN+'+@IN_OPT+'</HPOPTION><FINRESPSET>'+ISNULL(CAST(FINRESPSET AS VARCHAR),'') +'</FINRESPSET><ISCOVERED>True</ISCOVERED><ISCOPAY>False</ISCOPAY><COINSURANCE_PERCENT>NONE</COINSURANCE_PERCENT><ISAPPLYPAYMENTS>False</ISAPPLYPAYMENTS><ISHOSPADMN>False</ISHOSPADMN><COPAYAMT>0</COPAYAMT><DUMMYCLAIMNO>QUICKENTRY</DUMMYCLAIMNO><FEESETASSIGNID>'+ISNULL(CAST(FEESETASSIGNID AS VARCHAR),'')+'</FEESETASSIGNID></Authdetails>'			
				from #authtemp_cpt
				where ID=@id
						
				select @in_AuthDetails = @in_AuthDetails+CPTRecord
				from #authtemp_cpt_xml
				where id=@id
				order by id
						
				PRINT @IN_AUTHDETAILS
				
				set @id = (select MIN(id) from #authtemp_cpt where ID > @id)
			End
				
			set @in_AuthDetails = '<DocumentElement>'+@in_AuthDetails+'</DocumentElement>'
			
			print 'AUTH DETAILS:' +@in_AuthDetails
				
			-- Drop temp tables
			drop table #authtemp_icd
			DROP TABLE [#authtemp_icdlist]
			drop table #authtemp_cpt
			drop table #authtemp_cpt_xml
		END
		-- call to [EZCAPDB].dbo.CHCNEDI_PostAuth and pass web data

		--set @IN_REQDATE = GETDATE() for testing only
		EXEC @PostAuthResult = [EZCAP65TEST].[EZCAPDB].[dbo].[CHCNEDI_AuthMaster_CRUDOperations_TEST] @in_CERTTYPE=@in_CERTTYPE, @in_DMLType='I',@in_HPCode = @in_HPCode,@in_OPT = @in_OPT, @IN_HPAUTHNO=@IN_HPAUTHNO, @in_AuthDetails=@in_AuthDetails, @in_AUTHPCP_KEYID = @in_AUTHPCP_KEYID, @in_MEMB_KEYID=@in_MEMB_KEYID, @in_STATUS = @in_STATUS, @in_PRIORITY = @in_PRIORITY, @in_CreatedBy=@in_CreatedBy,@in_REQPROV_KEYID = @in_REQPROV_KEYID,@in_REQSPEC=@IN_SPECCODE, @in_REQPROV=@in_REQPROV, @in_AUTHDATE = @in_AUTHDATE,@in_EXPRDATE = @in_EXPRDATE, @in_COMPANY_ID = @in_COMPANY_ID, @in_AUTHPCP = @in_AUTHPCP, @in_AUTHUNITS = @in_AUTHUNITS, @in_MEMBID = @in_MEMBID, @in_MEMBNAME=@in_MEMBNAME,@in_PLACESVC = @OU_PLACESVC,@in_REQDATE=@in_REQDATE, @in_DiagCode1 = @in_DiagCode1, @in_DiagCode2 = @in_DiagCode2, @in_DiagCode3 = @in_DiagCode3, @in_DiagCode4 = @in_DiagCode4, @in_DiagCode5 = @in_DiagCode5, @in_DiagCode6 = @in_DiagCode6,@in_DiagCode7 = @in_DiagCode7, @in_DiagCode8 = @in_DiagCode8, @in_DiagCode9 = @in_DiagCode9, @in_DiagCode10 = @in_DiagCode10, @in_DiagCode11 = @in_DiagCode11, @in_DiagCode12 = @in_DiagCode12, @in_CHCNEDI_RequestID = @REQUESTID,@IN_BATCH = @BATCHID, @in_FaxToNumber = @in_FaxToNumber , @in_Notes = @in_Notes, @in_UnlistedProv = @in_UnlistedProv, @in_ReqPhoneNumber = @in_ReqPhoneNumber, @in_RefToProvFax=@IN_REFTOPROVFAX, @in_ReqName = @IN_REQNAME, @in_REQDUNITS= @in_REQDUNITS, @in_ONSETDT=@in_ONSETDT, @in_SVCTYPE=@in_SVCTYPE, @in_ESTDOB=@in_ESTDOB,@in_ECDServer='EZCAP65TEST', @IN_REQCAT=@IN_REQCAT, @in_FACPROVID=@in_FACPROVID, @in_SVCFACID_KEYID=@in_SVCFACID_KEYID,@ISDUP=@ISDUP,@AuthPCP_CompanyID=@AuthPCP_CompanyID, @ou_IntRetValue=@RESULTS OUTPUT, @ou_AuthNo = @OU_AuthNo OUTPUT
		Print 'Finished Post Auth' + @RESULTS


		IF @PostAuthResult = 0
		BEGIN

			print 'NEW AUTHNO='+@OU_AuthNo
			PRINT @NUM
			SET @RESULTS = @RESULTS + '<BR />NEW AUTH REQUEST NO='+@ou_AuthNo + '<br />' 
			
			--INSERT ATTACHMENTS 
			SET @NUM = (SELECT COUNT(*) FROM CHCNAuthReq_Attachments_Temp WHERE REQUESTID = @REQUESTID)

			IF @OU_AUTHNO IS NOT NULL AND @NUM > 0

			BEGIN	
				--INSERT DATETIME STAMP INTO FILENAME TO PREVENT DUP NAMES, CTA, 01/23/2014
				CREATE TABLE #ATTACHMENTS (ID INT IDENTITY(1,1), REQUESTID VARCHAR(30), [FILENAME] VARCHAR(200), CONTENTTYPE VARCHAR(100), ATTACHMENT VARBINARY(MAX), DESCR VARCHAR(500))
				INSERT INTO #ATTACHMENTS (REQUESTID, [FILENAME], CONTENTTYPE, ATTACHMENT, DESCR)
				SELECT REQUESTID, REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR,GETDATE(),120),'-',''),' ',''),':','')+'_'+LTRIM(RTRIM([FILENAME])), CONTENTTYPE, ATTACHMENT, DESCR
				FROM CHCNAuthReq_Attachments_Temp
				WHERE REQUESTID=@REQUESTID 
				ORDER BY ID ASC
						
				SELECT @CREATEDBY = @in_CreatedBy, @CREATEDDATE = GetDate(), @LASTCHANGEBY=@in_CreatedBy, @LASTCHANGEDATE  =GetDate()

				SET @id = (SELECT MIN(ID) FROM #ATTACHMENTS)
				
				--INSERT FOLDERID INTO ECD DM_FOLDER, ONLY ONE RECORD FOR ALL ATTACHMENTS
				-- MAKE SURE FOLDERNAME DOESN'T EXIST
				SET @FolderName = 'CHCNCHC'+@OU_AuthNo
						
				Declare @P10 varchar(250)
				EXEC [EZCAP65TEST].[ECD].[dbo].[usp_CreateFolder_CRUDOperations] @inDMLType='I',@inFolderName=@FolderName,@inDescription='',@inParentID='',@inIsPublic=0,@inIsSystemDefined=1,@inCREATEBY=1,@inModifiedBy=1,@in_IsEZNET=0,@ou_intRetValue=@p10 output,@ou_FolderID=@FolderID output
					
				WHILE @ID <=@NUM
				BEGIN
					--
					SELECT @FILENAME =[FILENAME], @CONTENTTYPE=CONTENTTYPE,@ATTACHMENT= ATTACHMENT, @FILEDESCR = ISNULL(NULLIF(DESCR,''),'WEB ATTACHMENT') 
					FROM #ATTACHMENTS WHERE ID=@ID
				
					declare @p12 varchar(300)=NULL, @p13 varchar(250)=NULL, @p14 bigint=NULL, @p15 int=NULL, @p16 int=NULL, @p17 datetime=NULL, @p18 varchar(25)=NULL, @p19 int=NULL
					EXEC [EZCAP65TEST].[ECD].[dbo].[usp_FileInformation_CRUDOperations] @inDMLType='I',@inPhysicalFileName=@filename,@inDescription=@FILEDESCR,@inFolderID=@FolderID,@inReferenceID=@REQUESTID,@inFileStatue=0,@inCREATEBY=1,@inModuleID=3,@inContenttype=@CONTENTTYPE,@inImageClaim=@ATTACHMENT, @inCompany_ID='CHCNCHC',@ou_intRetValue=@p12 output,@ou_FileName=@p13 output,@ou_ModifiedDate=@p14 output,@ou_FileID=@p15 output,@ou_ErrorNo=@p16 output,@ou_CreatedDate=@p17 output,@ou_Version=@p18 output,@ou_HistoryId=@p19 output,@in_IsEZNET=0
			select @p12, @p13, @p14, @p15, @p16, @p17, @p18, @p19	
				
					SET @ID = (SELECT MIN(ID) FROM #ATTACHMENTS WHERE ID > @ID)
				
				END
			END
		END
END TRY
BEGIN CATCH
SET @RESULTS = '<br />There was an error submitting your authorization request. Please forward the following message to IT for review.'
SET @RESULTS = @RESULTS + '<BR /><BR />ERROR: ' + ERROR_PROCEDURE() +  ' line No:' + + CAST(ERROR_LINE() AS VARCHAR(50)) + '<br />' + ERROR_MESSAGE()END CATCH
END


GO
