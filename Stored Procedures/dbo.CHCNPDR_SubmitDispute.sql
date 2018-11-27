SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- ==================================================
--SK.11/30/2016 Modified from SPROC - EDIAPP.CHCNEDI.dbo.CHCNPDR_Case_Submit 
--SK.6/2/2017 Updated for weekend submission to be Monday submission PRIOR-1039 
--SK.8/16/2017 Updated for after 5pm M-F sumission to set the receive date to following business day PRIOR-1078
-- ===================================================
CREATE PROCEDURE [dbo].[CHCNPDR_SubmitDispute]  
	
	@RequestID  VARCHAR(30),
	@PDRNo VARCHAR(25) OUTPUT,
	@RetValue VARCHAR(200) OUTPUT
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @in_MembID VARCHAR(40)
	DECLARE @in_MembName VARCHAR(100)
	DECLARE @in_MembKeyID   VARCHAR(50)  
	DECLARE @in_AdmitProvID   VARCHAR(25) 
	DECLARE @in_AdmitProvKeyID  VARCHAR(50) 
	DECLARE @in_CasePriority INT
	DECLARE @in_CaseStatus INT
	DECLARE @IN_DATE VARCHAR(10)
	DECLARE @IN_UDF VARCHAR(500)
	DECLARE @IN_EVENTUDF VARCHAR(MAX)		
	DECLARE @BILLED DECIMAL (15,2)
	DECLARE @PROVCLAIM VARCHAR(25)
	DECLARE @DATEFROM DATETIME
	DECLARE @DATETO DATETIME
	DECLARE @VENDORNM VARCHAR(40)
	DECLARE @PROCCODE VARCHAR(15)	
	DECLARE @OPT VARCHAR(25) -- ADDED 09/12/2012 TO FILTER OUT AACC MEMBERS, CTA		

	DECLARE @CASEID VARCHAR(40)
	DECLARE @ClaimNo VARCHAR(40)
	DECLARE @ManagerID  VARCHAR(10)  	
	DECLARE @CaseType   VARCHAR(25)	= 'NC' --Created by Jose for "CONNECT"
	DECLARE @Dispute VARCHAR(1) = 'Y'
	DECLARE @AddlInfo VARCHAR(1) = 'N'
	DECLARE @ContactName  VARCHAR(200)
	DECLARE @ContactPhone  VARCHAR(100)
	DECLARE @Address   VARCHAR(500)	
	DECLARE @CaseNo VARCHAR(20) = '' 
	DECLARE @CloseDt VARCHAR(8)
	DECLARE @Notes_DisputeReason VARCHAR(MAX)
	DECLARE @ID INT = 0, @CNT INT = 0

	DECLARE @FolderName varchar(50)
	DECLARE @FolderID int
	DECLARE @FileName VARCHAR(200)
	DECLARE @ContentType VARCHAR(100)
	DECLARE @BINARYFILE VARBINARY(MAX)
	DECLARE @FILEDESCR VARCHAR(500)

	DECLARE @ClaimCnt INT = 0
	DECLARE @EVENTUDF_NO VARCHAR(2) = '1'
	DECLARE @ErrorNo INT = 0
	DECLARE @ClaimNoStr VARCHAR(500) = ''

	DECLARE @ONSET_DATE VARCHAR(10)

	BEGIN TRY	
	
	SELECT @ClaimNo = ClaimNo FROM CHCNPDR_Master WHERE RequestID = @RequestID
	SELECT @ClaimCnt = COUNT(*) FROM CHCNPDR_ClaimMulti WHERE RequestID = @RequestID

	IF NULLIF(@ClaimNo,'') IS NULL OR @ClaimCnt = 0
		BEGIN
			SET @RetValue = 'No Claim Selection Found'
			RETURN			
		END

	SELECT @in_MembID = P.MEMBID, @in_MembName = P.MembName, @in_MembKeyID=P.Memb_KeyID,@in_AdmitProvID = P.ProvID, @in_AdmitProvKeyID = P.Prov_KeyID, 
		@BILLED=P.BILLED,@PROVCLAIM=P.PROVCLAIM,
			@DATEFROM=P.DATEFROM, @DATETO=P.DATETO, @VENDORNM =V.VENDORNM, @OPT=P.OPT	 
	FROM [EZCAP65TEST].[EZCAPDB].DBO.CLAIM_PMASTERS P (NOLOCK)  LEFT JOIN [EZCAP65TEST].[ECD].DBO.VEND_MASTERS V (NOLOCK) ON P.VENDOR = V.VENDORID
	WHERE P.CLAIMNO=@ClaimNo

	SELECT @PROCCODE = (select MIN(LTRIM(RTRIM(PROCCODE)))FROM [EZCAP65TEST].[EZCAPDB].DBO.CLAIM_DETAILS D (NOLOCK) WHERE D.CLAIMNO = @ClaimNo GROUP BY D.CLAIMNO)

	SELECT @ContactName = ISNULL(Submitter_ProvName,''), @ContactPhone = [Submitter_Phone], 
		@Address = Submitter_Street +CHAR(13)+CHAR(10)+ [Submitter_City] + ', ' + [Submitter_State] + ' ' + [Submitter_Zip],
		@Notes_DisputeReason = [DisputeReason]
	FROM CHCNPDR_Master WHERE RequestID = @RequestID

	IF NULLIF(@ContactPhone,'') IS NULL OR NULLIF(LTRIM(RTRIM(@Address)),'') IS NULL OR NULLIF(@Notes_DisputeReason,'') IS NULL 
		BEGIN
			SET @RetValue = 'No Address Info Found'
			RETURN			
		END

	SELECT @PROCCODE = (SELECT MIN(LTRIM(RTRIM(PROCCODE)))FROM [EZCAP65TEST].[EZCAPDB].DBO.CLAIM_DETAILS D (NOLOCK) WHERE D.CLAIMNO = @ClaimNo GROUP BY D.CLAIMNO)
	SELECT @in_CasePriority = COMMON_ID from [EZCAP65TEST].[EZCAPDB].DBO.common_codes_v where CODE='H' AND CATEGORY_NAME = 'CASEPRIORITIES'
	SELECT @in_CaseStatus = COMMON_ID from [EZCAP65TEST].[EZCAPDB].DBO.common_codes_v where CODE='O' AND CATEGORY_NAME = 'CASESTATUS'
	SET @IN_DATE = CONVERT(VARCHAR,GETDATE(),101)

	--Handling weekend
	DECLARE @CUR_DATE DATETIME = GETDATE()
	IF DATEPART(WEEKDAY, @CUR_DATE) = 1 --Sunday
		BEGIN
			SET @ONSET_DATE = CONVERT(VARCHAR,DATEADD(DAY,1,@CUR_DATE),101) 		
		END
    ELSE IF DATEPART(WEEKDAY, @CUR_DATE) = 7 --Saturday
		BEGIN
			SET @ONSET_DATE = CONVERT(VARCHAR,DATEADD(DAY,2,@CUR_DATE),101) 		
		END
	--Hour check and if after 5 pm, then set the following business day [PRIOR-1078]
	ELSE IF DATEPART(WEEKDAY, @CUR_DATE) = 6 AND DATEPART(HOUR, @CUR_DATE) >= 17 --Friday after 5 PM
		BEGIN
			SET @ONSET_DATE = CONVERT(VARCHAR,DATEADD(DAY,3,@CUR_DATE),101) 		
		END
	ELSE IF DATEPART(HOUR, @CUR_DATE) >= 17 --Monday - Thursday
		BEGIN
			SET @ONSET_DATE = CONVERT(VARCHAR,DATEADD(DAY,1,@CUR_DATE),101) 		
		END
	ELSE 
		BEGIN
			SET @ONSET_DATE = CONVERT(VARCHAR,@CUR_DATE,101) 		
		END


	SELECT @ManagerID = (SELECT CASEMANAGER_ID FROM [EZCAP65TEST].[EZCAPDB].DBO.CASE_MANAGERS WHERE MANAGERID = 'CC')

	--SELECT @IN_UDF = '1±'+@Dispute+'±2±'+@AddlInfo+'±3±N±4±'+@ContactName+'±5±'+@ContactPhone+'±6±'+@IN_DATE
	SELECT @IN_UDF = '1±'+@Dispute+'±2±'+@AddlInfo+'±3±N±±±±±±'
	--SELECT @IN_EVENTUDF = @EVENTUDF_NO + '±ADDRESS±±'+@IN_DATE+'±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±'+@Address+'±I'			
	SELECT @IN_EVENTUDF = @EVENTUDF_NO + '±ADDRESS±±'+@IN_DATE+'±±±±±±±±±±±±5±'+@ContactName+'±6±'+@ContactPhone+'±±±±±±±±±±±±±±±±±±±±±±±±±±±±±'+@Address+'±I'			

	-- POST CASE TO EZCAP AND RETURN CASE NUMBER
	EXEC [EZCAP65TEST].[EZCAPDB].DBO.CHCNEDI_PostPDRCase @in_CaseNo='',@in_DMLType='I',@in_ECDServer='EZCAP65TEST',@in_MembID=@in_MembID,
	@in_ManagerID=@ManagerID,@in_FirstDate=@IN_DATE, --Added @in_FirstDate 1/23/2017
	@in_CompanyID='CHCNCHC',@in_AdmitProvID=default,@in_AdmitProvKeyID=default,
	@in_CasePriority=@in_CasePriority,@in_CaseStatus=@in_CaseStatus,@in_CaseType=@CaseType, 
	@in_AttProvid=@in_AdmitProvID,@in_AttProvKeyid=@in_AdmitProvKeyID,
	@in_MembKeyID=@in_MembKeyID,@in_HospitalKeyID=NULL,@in_HospitalID=NULL,@in_MembName=@in_MembName,
	@in_OpenDate=@IN_DATE,@in_isUrgent=0,@in_isChronic=0,@in_RecLOS=0,@in_Surgery=0,
	@in_OnsetDate=@ONSET_DATE,@in_CloseDate=NULL,
	@in_isHospitalized=0,@in_CaseUDFValues=@IN_UDF,@in_CaseEventUDFValues=@IN_EVENTUDF,@in_Sep='±',@in_CreatedBy=1,@in_ModifiedBy=1, @Claimno=@ClaimNo, 
	@Filename='',@ou_CaseNo = @CaseNo OUTPUT, @ou_ErrorNo=@ErrorNo OUTPUT, @ou_IntRetValue=@RetValue OUTPUT

	PRINT @CASENO
	PRINT @RetValue

	IF @ErrorNo <> 0 
		BEGIN
			SET @RetValue = 'EZCAP Case Creation Error: ' + @RetValue
			RETURN
		END

	SET @PDRNo = @CASENO

	UPDATE dbo.CHCNPDR_Master 
	SET EZCAP_CaseNo = @CASENO, EZCAP_PostDt = GETDATE(), LastChangeBy = 1, LastChangeDate = GETDATE(),
		Claim_ProcCode = @PROCCODE, Claim_DateFrom = @DATEFROM, Claim_DateTo = @DATETO, Claim_MembName = @in_MembName,
		Claim_OPT = @OPT, Claim_VendorNM = @VENDORNM, Claim_Prov = @PROVCLAIM, Claim_Billed = @BILLED
	WHERE RequestID = @RequestID

	--Additional Event for Dispute Reason Note
	SET @EVENTUDF_NO = CAST(CAST(@EVENTUDF_NO AS INT) + 1 AS VARCHAR(2))
	SELECT @IN_EVENTUDF = @EVENTUDF_NO + '±CONNECT NOTE±±'+@IN_DATE+'±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±'+@Notes_DisputeReason+'±I' 			
	EXEC [EZCAP65TEST].[EZCAPDB].dbo.usp_UpdateCaseEventsInfo @in_CaseNo = @CASENO, @in_CreatedBy = 1, @in_CaseEventUDFValues = @IN_EVENTUDF, @ou_IntRetValue = @RetValue OUTPUT  
	PRINT @RetValue

PRINT '@EVENTUDF_NO (Connect Note) - ' + @EVENTUDF_NO
PRINT '@RetValue - ' + @RetValue
PRINT '@CASENO - ' + @CaseNo
PRINT '@IN_EVENTUDF - ' + @IN_EVENTUDF
	--Multiple claims or detail line#
	
	IF @ClaimCnt > 0 
		BEGIN
			DECLARE @ClaimSeq VARCHAR(1000) 
			DECLARE @Claim_EventUDF VARCHAR(1000) = ''

			CREATE TABLE #Claims (ID INT IDENTITY(1,1), CLAIMNO VARCHAR(25))					

			INSERT INTO #Claims(CLAIMNO)
			SELECT DISTINCT CLAIMNO FROM CHCNPDR_ClaimMulti WHERE RequestID = @RequestID ORDER BY ClaimNo

			SELECT @CNT = 0, @ID = 0
			SELECT @CNT = COUNT(*) FROM #Claims 

			--LOOP each ClaimNo
			WHILE @CNT > @ID
				BEGIN
					SELECT @ClaimNo = '', @IN_EVENTUDF = '', @ClaimSeq = ''
					SELECT TOP 1 @ClaimNo = CLAIMNO, @ID = ID FROM #Claims WHERE ID > @ID ORDER BY ID
PRINT '@ClaimNo - ' + @ClaimNo
					SELECT @ClaimSeq = COALESCE(@ClaimSeq + ', ', '') + CAST(Sequence AS VARCHAR(5))
					FROM dbo.CHCNPDR_ClaimMulti
					WHERE RequestID = @RequestID AND ClaimNo = @ClaimNo
PRINT '@ClaimSeq - ' + @ClaimSeq
					SET @Claim_EventUDF = @Claim_EventUDF + @ClaimNo + ' - ' + STUFF(REPLACE(ISNULL(@ClaimSeq,''),'0',''), 1, 1, '')
PRINT '@Claim_EventUDF - ' + @Claim_EventUDF

					SET @Claim_EventUDF = @Claim_EventUDF +CHAR(13)+CHAR(10)

					--ClaimNo string
					SET @ClaimNoStr = @ClaimNoStr + CASE WHEN LEN(@ClaimNoStr) > 0 THEN ',' ELSE '' END + @ClaimNo

--					SET @EVENTUDF_NO = CAST(@ID + CAST(@EVENTUDF_NO AS INT) AS VARCHAR(5))
--PRINT '@EVENTUDF_NO (DISPUTED CLAIM) - ' + @EVENTUDF_NO
--					--Claim Detail to Event UDF
--					SELECT @IN_EVENTUDF = @EVENTUDF_NO + '±DISPUTED CLAIM±±'+@IN_DATE+'±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±'+@Claim_EventUDF+'±I' 			
--					--EXEC [EZCAP65TEST].[EZCAPDB].dbo.usp_UpdateCaseEventsInfo @in_CaseNo = @CASENO, @in_CreatedBy = 1, @in_CaseEventUDFValues = @IN_EVENTUDF, @ou_IntRetValue = @RetValue OUTPUT  
--					EXEC [EZCAP65TEST].[EZCAPDB].dbo.CHCNEDI_PostPDRCase @in_DMLType = 'M', @in_CaseNo=@CASENO, @CLAIMNO=@ClaimNo, @in_CaseEventUDFValues=@IN_EVENTUDF, @in_CreatedBy = 1, @ou_ErrorNo=@ErrorNo OUTPUT, @ou_IntRetValue=@RetValue OUTPUT	
--					PRINT @RetValue
--					IF @ErrorNo <> 0 
--						BEGIN
--							SET @RetValue = 'EZCAP Claim Update Error: ' + @RetValue
--							RETURN
--						END 
				END	

			SET @EVENTUDF_NO = CAST(@ID + CAST(@EVENTUDF_NO AS INT) AS VARCHAR(5))
PRINT '@EVENTUDF_NO (DISPUTED CLAIM) - ' + @EVENTUDF_NO
					--Claim Detail to Event UDF
					SELECT @IN_EVENTUDF = @EVENTUDF_NO + '±DISPUTED CLAIM±±'+@IN_DATE+'±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±'+@Claim_EventUDF+'±I' 			
					--EXEC [EZCAP65TEST].[EZCAPDB].dbo.usp_UpdateCaseEventsInfo @in_CaseNo = @CASENO, @in_CreatedBy = 1, @in_CaseEventUDFValues = @IN_EVENTUDF, @ou_IntRetValue = @RetValue OUTPUT  
					EXEC [EZCAP65TEST].[EZCAPDB].dbo.CHCNEDI_PostPDRCase @in_DMLType = 'M', @in_CaseNo=@CASENO, @ClaimMulti=@ClaimNoStr, @in_CaseEventUDFValues=@IN_EVENTUDF, @in_CreatedBy = 1, @ou_ErrorNo=@ErrorNo OUTPUT, @ou_IntRetValue=@RetValue OUTPUT	
					PRINT @RetValue
					IF @ErrorNo <> 0 
						BEGIN
							SET @RetValue = 'EZCAP Claim Update Error: ' + @RetValue
							RETURN
						END 
		END
	

	--Attachement to Case Management module
	SET @CNT = 0
	--SELECT @CNT = COUNT(*) FROM CHCNAuthReq_Mod_Attachments_Temp WHERE MOD_REQID = @ROWID
	SELECT @CNT = COUNT(*) FROM CHCNPDR_Attachments_Temp WHERE RequestID = @RequestID
							
	IF @CNT > 0
		BEGIN
			CREATE TABLE #temp_Attachments (ID INT IDENTITY(1,1), [FILENAME] VARCHAR(200), CONTENTTYPE VARCHAR(100), ATTACHMENT VARBINARY(MAX), DESCR VARCHAR(500))
			INSERT INTO #temp_Attachments ([FILENAME], CONTENTTYPE, ATTACHMENT, DESCR)
			SELECT REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR,GETDATE(),120),'-',''),' ',''),':','')+'_'+LTRIM(RTRIM([FILENAME])), CONTENTTYPE, ATTACHMENT, DESCR
			FROM CHCNPDR_Attachments_Temp WHERE REQUESTID = @RequestID 
			ORDER BY ID ASC	

			SET @ID = (SELECT MIN(ID) FROM #temp_Attachments)
									
			SET @FolderName = 'CHCNCHC'+@CaseNo
									
			declare @p10 varchar(250)
			EXEC [EZCAP65TEST].[ECD].[dbo].[usp_CreateFolder_CRUDOperations] @inDMLType='I',@inFolderName=@FolderName,@inDescription='',@inParentID='',@inIsPublic=0,@inIsSystemDefined=1,@inCREATEBY=1,@inModifiedBy=1,@in_IsEZNET=0,@ou_intRetValue=@p10 output,@ou_FolderID=@FolderID output
													
			WHILE @CNT >= @ID
				BEGIN
					--
					SELECT @FileName = [FILENAME], @ContentType = CONTENTTYPE, @BINARYFILE = ATTACHMENT, @FILEDESCR = ISNULL(NULLIF(DESCR,''),'WEB ATTACHMENT')  
					FROM #temp_Attachments WHERE ID = @ID
										
					declare @p12 varchar(300)=NULL, @p13 varchar(250)=NULL, @p14 bigint=NULL, @p15 int=NULL, @p16 int=NULL, @p17 datetime=NULL, @p18 varchar(25)=NULL, @p19 int=NULL
					EXEC [EZCAP65TEST].[ECD].[dbo].[usp_FileInformation_CRUDOperations] @inDMLType='I',@inPhysicalFileName=@FileName,@inDescription=@FILEDESCR,@inFolderID=@FolderID,@inReferenceID=@RequestID,@inFileStatue=0,@inCREATEBY=1,@inModuleID=9,@inContenttype=@ContentType,@inImageClaim=@BINARYFILE, @inCompany_ID='CHCNCHC',@ou_intRetValue=@p12 output,@ou_FileName=@p13 output,@ou_ModifiedDate=@p14 output,@ou_FileID=@p15 output,@ou_ErrorNo=@p16 output,@ou_CreatedDate=@p17 output,@ou_Version=@p18 output,@ou_HistoryId=@p19 output,@in_IsEZNET=0
					--select @p12, @p13, @p14, @p15, @p16, @p17, @p18, @p19	
										
					SET @ID = (SELECT MIN(ID) FROM #temp_Attachments WHERE ID > @ID)
				END
									
			--Added to remove attachment records from temp table (SK.9/22/2015)
			--DELETE FROM CHCNPDR_Attachments_Temp WHERE REQUESTID = @RequestID 
		END			

	UPDATE dbo.CHCNPDR_Master SET DraftMode = 0, LastChangeBy = 1, LastChangeDate = GETDATE() WHERE RequestID = @RequestID
	

	END TRY
	BEGIN CATCH
		--SELECT ERROR_NUMBER(),ERROR_SEVERITY(),ERROR_STATE(),ERROR_PROCEDURE() 
		SET @RetValue = 'Error Line: ' + CAST(ERROR_LINE() AS VARCHAR(50)) + ', Error Message: ' + ERROR_MESSAGE();
	END CATCH

END


GO
