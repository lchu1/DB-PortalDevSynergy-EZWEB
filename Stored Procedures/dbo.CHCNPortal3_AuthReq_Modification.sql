SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





/* =============================================
-- Sarah Kang, 06/26/2015
-- DESCRIPTION:	Submits a modification of a prior-authorization
-- CONDITION: - AUTH Current Status: No decision yet (Requeted(N,M,7,Z),Approved /w 1,V,P, Not in (cancelled(6),denied(3),deferred(4),CCS(c))
-- QUESTION: Multiple Attachments handling? Save in temp table - CHCNAuthReq_Attachments_Temp
Table: CHCNAuthReq_Modification,
	   CHCNAuthReq_Attachments_Temp
Parameters: AuthNo, UserID, AuthDetail(XML), AuthDiags(XML), ServiceDate, RenderingProvId, Notes, Attachement
AuthDetail(XML):
	<DocumentElement>
		<AuthDetails>
			<TYPE>D</TYPE><TBLROWID>2</TBLROWID><PROCCODE>222</PROCCODE><QTY>1</QTY><MODIF></MODIF>
		</AuthDetails>
		<AuthDetails>
			<TYPE>A</TYPE><TBLROWID>1</TBLROWID><PROCCODE>111</PROCCODE><QTY>1</QTY><MODIF></MODIF>
		</AuthDetails>		
	</DocumentElement>
	--Type = Delete, Modify or Add
	--TblRowID = TBLROWID from Claim_Details or next sequential number if Type = Add
	--Modif = Modifier Code
AuthDiags(XML):
	<DocumentElement>
		<AuthDiags>
			<TYPE>D</TYPE><DXCODE>888</DXCODE>
		</AuthDiags>
		<AuthDiags>
			<TYPE>A</TYPE><DXCODE>999</DXCODE>
		</AuthDiags>
	</DocumentElement>
-- =============================================*/
CREATE PROCEDURE [dbo].[CHCNPortal3_AuthReq_Modification]
--Parameters: AuthNo, UserID, AuthDetail(XML), AuthDiags(XML), ServiceDate, RenderingProvId, Notes, Attachement
	
	@AuthNo VARCHAR(25),
	@UserID VARCHAR(5),
	@AuthDetail VARCHAR(MAX) = '',
	@AuthDiags VARCHAR(MAX) = '',
	@ServiceDate DATETIME = NULL,
	@RenderingProvId VARCHAR(20) = '',
	@Notes VARCHAR(MAX) = '',	--[EZCAPDB].[dbo].[CSM_NOTES]
	@Attachment VARCHAR(1) = 'N', 	--Y or N
	@RetValue VARCHAR(200) = '' OUTPUT

AS
BEGIN
	
	SET NOCOUNT ON;
	
	DECLARE @docHandle INT
	DECLARE @NotesStr VARCHAR(MAX) = ''
	DECLARE @AuthDetailStr VARCHAR(MAX) = 'AUTHDETAIL'
	DECLARE @AuthDiagStr VARCHAR(MAX) = 'AUTHDIAG'
	
	DECLARE @ID INT = 0
	DECLARE @CNT INT = 0
	DECLARE @ROWID INT = 0
	
	DECLARE @CSINO VARCHAR(25)
	DECLARE @PRIORITY INT
	DECLARE @CONTACT INT
	DECLARE @MODTYPE INT
	DECLARE @STATUS INT
	DECLARE @SUBTYPE INT
	DECLARE @ACTION INT
	DECLARE @OPENDATE DATETIME
	DECLARE @CLOSEDATE DATETIME
	DECLARE @ACTIONDML VARCHAR(MAX)
	DECLARE @CSIOUT VARCHAR(20)	
	DECLARE @LN VARCHAR(50)
	DECLARE @FN VARCHAR(25)
	DECLARE @PHONE VARCHAR(10)
	DECLARE @FAX VARCHAR(10)
	DECLARE @EMAIL VARCHAR(50)	
	DECLARE @PROVID VARCHAR(40)
	DECLARE @INTIME VARCHAR(24)
	DECLARE @ERRORNO INT
	DECLARE @RETURNVAL VARCHAR(250)
	DECLARE @MODIFDATE BIGINT
	DECLARE @TOTALTIME VARCHAR(25)
	DECLARE @EZCAP_USERID INT = 10209 --SK Changed from 10000 10/13/2016

	DECLARE @FolderName varchar(50)
	DECLARE @FolderID int
	DECLARE @FileName VARCHAR(200)
	DECLARE @ContentType VARCHAR(100)
	DECLARE @BINARYFILE VARBINARY(MAX)
	DECLARE @FILEDESCR VARCHAR(500)
	
	BEGIN TRY
	
	IF LEN(@AuthDetail) = 0 AND LEN(@AuthDiags) = 0 AND @ServiceDate IS NULL AND LEN(@RenderingProvId) = 0 AND LEN(@NotesStr) = 0 
		BEGIN
			SET @RetValue = 'No change was submitted'
			RETURN
		END		
	ELSE
		BEGIN
		
			--1. Insert to CHCNAuthReq_Modification table
			INSERT INTO CHCNAuthReq_Modification (UserID, AuthNo, AuthDetail, AuthDiags, ServiceStartDate, RendProvID, Notes, Attachment, EnterDate)
			VALUES (@UserID, @AuthNo, @AuthDetail, @AuthDiags, @ServiceDate, @RenderingProvId, @Notes, CASE WHEN NULLIF(@Attachment,'') IS NULL THEN 'N' ELSE @Attachment END, GETDATE())
			SELECT @ROWID = IDENT_CURRENT('CHCNAuthReq_Modification')
					
			--2. Parse XML and generate Note of Change - save into Notes_EZCAPMOD	
			/*  Modification NOTE FORMAT -- <TYPE>D</TYPE><TBLROWID>2</TBLROWID><PROCCODE>222</PROCCODE><QTY>1</QTY><MODIF></MODIF>
				AUTHDETAIL1 - Type: , Sequence: , ServiceCode: , Qty: , Modifier: , AUTHDETAIL2 - , AUTHDETAIL3 - 
				AUTHDIAG1 - , AUTHDIAG2 - , AUTHDIAGS3 -  
				, SERVICE DATE:
				, RENDPROVID: 		
			*/

			--Parse AuthDetails XML
			IF LEN(@AuthDetail) > 0 
				BEGIN
					EXEC dbo.sp_xml_preparedocument @docHandle OUTPUT, @AuthDetail
					
					CREATE TABLE #temp_AuthDetailXML (ID INT IDENTITY(1,1), [TYPE] CHAR(1), TBLROWID INT, PROCCODE VARCHAR(10), QTY INT, MODIF VARCHAR(2))
					
					INSERT INTO #temp_AuthDetailXML ([TYPE], TBLROWID, PROCCODE, QTY, MODIF)
					SELECT [TYPE], TBLROWID, PROCCODE, QTY, MODIF
					FROM OPENXML (@docHandle, '/DocumentElement/AuthDetails',3)
						WITH ([TYPE] CHAR(1), TBLROWID INT, PROCCODE VARCHAR(10), QTY INT, MODIF VARCHAR(2))	
					
					--LOOP			
					SELECT @CNT = COUNT(*) FROM #temp_AuthDetailXML
					SELECT @ID = MIN(ID) FROM #temp_AuthDetailXML		
					
					WHILE @CNT >= @ID
						BEGIN				
							--SELECT @NotesStr = @NotesStr + @AuthDetailStr + CAST(ID AS VARCHAR(2)) + ' - Type: ' + [TYPE] + ', Sequence: ' + CAST(TBLROWID AS VARCHAR(2)) + ', ServiceCode: ' + PROCCODE + ', Qty: ' + CAST(QTY AS VARCHAR(2)) + ', Modifier: ' + MODIF + ', '
							--SELECT @NotesStr = @NotesStr + 'Service Code ' + [TYPE] + ', Sequence: ' + CAST(TBLROWID AS VARCHAR(2)) + ', Code: ' + PROCCODE + ', Qty: ' + CAST(QTY AS VARCHAR(2)) + ', Modifier: ' + MODIF + ', '
							--SELECT @NotesStr = @NotesStr + 'Service Code ' + CASE WHEN [TYPE] = 'A' THEN 'Add' WHEN [TYPE] = 'D' THEN 'Delete' ELSE 'Add' END + ', Sequence: ' + CAST(TBLROWID AS VARCHAR(2)) + ', Code: ' + PROCCODE + ', Qty: ' + CAST(QTY AS VARCHAR(2)) + ', Modifier: ' + MODIF + ', '
							SELECT @NotesStr = @NotesStr + 'Service Code ' + CASE WHEN [TYPE] = 'A' THEN 'Add' WHEN [TYPE] = 'D' THEN 'Delete' ELSE 'Add' END + ', Code: ' + PROCCODE + ', Qty: ' + CAST(QTY AS VARCHAR(2)) + ', Modifier: ' + MODIF + ', '
							FROM #temp_AuthDetailXML WHERE ID = @ID				
							
							SET @ID = (SELECT MIN(ID) FROM #temp_AuthDetailXML WHERE ID > @ID)
						END			
					
					EXEC dbo.sp_xml_removedocument @docHandle	
					DROP TABLE #temp_AuthDetailXML	
				END
			
			--Parse AuthDiags XML
			IF LEN(@AuthDiags) > 0 
				BEGIN
					--CREATE TABLE #temp_AuthDiagXML (ID INT IDENTITY(1,1), DXCODE VARCHAR(10))
					CREATE TABLE #temp_AuthDiagXML (ID INT IDENTITY(1,1), [TYPE] CHAR(1), DXCODE VARCHAR(10))
			
					EXEC dbo.sp_xml_preparedocument @docHandle OUTPUT, @AuthDiags
					
					--INSERT INTO #temp_AuthDiagXML (DXCODE)
					--SELECT DXCODE
					--FROM OPENXML (@docHandle, '/DocumentElement/AuthDiags',3)
					--	WITH (DXCODE VARCHAR(10))
					INSERT INTO #temp_AuthDiagXML ([TYPE], DXCODE)
					SELECT [TYPE], DXCODE
					FROM OPENXML (@docHandle, '/DocumentElement/AuthDiags',3)
						WITH ([TYPE] CHAR(1), DXCODE VARCHAR(10))
					
					--LOOP			
					SELECT @CNT = COUNT(*) FROM #temp_AuthDiagXML
					SELECT @ID = MIN(ID) FROM #temp_AuthDiagXML		
					
					WHILE @CNT >= @ID
						BEGIN				
							--SELECT @NotesStr = @NotesStr + @AuthDiagStr + CAST(ID AS VARCHAR(2)) + ' - ' + DXCODE + ', '
							--SELECT @NotesStr = @NotesStr + 'Dx Code Add' + CAST(ID AS VARCHAR(2)) + ' - ' + DXCODE + ', '
							SELECT @NotesStr = @NotesStr + 'Dx Code ' + CASE WHEN [TYPE] = 'A' THEN 'Add' WHEN [TYPE] = 'D' THEN 'Delete' ELSE 'Add' END + CAST(ID AS VARCHAR(2)) + ' - ' + DXCODE + ', '
							FROM #temp_AuthDiagXML WHERE ID = @ID					
							
							SET @ID = (SELECT MIN(ID) FROM #temp_AuthDiagXML WHERE ID > @ID)
						END
						
					EXEC dbo.sp_xml_removedocument @docHandle	
					DROP TABLE #temp_AuthDiagXML
				END 	
			
			IF LEN(@ServiceDate) > 0
				BEGIN
					SET @NotesStr = @NotesStr + 'Service date (Auth Action Date): ' + CONVERT(VARCHAR(10),@ServiceDate,101) + ', '
				END
			IF LEN(@RenderingProvId) > 0
				BEGIN
					SET @NotesStr = @NotesStr + 'Requested Provider Change, PROVID: ' + @RenderingProvId 
				END
			
			IF LEN(@NotesStr) > 0
				BEGIN
					SET @NotesStr = CASE WHEN SUBSTRING(RTRIM(@NotesStr), LEN(RTRIM(@NotesStr)), 1) = ',' THEN SUBSTRING(RTRIM(@NotesStr), 1, LEN(RTRIM(@NotesStr))-1) ELSE @NotesStr END
					
					--Save Note string into Table Notes_EZCAPMOD
					UPDATE CHCNAuthReq_Modification SET Notes_EZCAPMOD = @NotesStr WHERE RowID = @ROWID

				END	
			

			
			--3. Create EZCAP CSM incident - AuthNo, Note of Change, Note from User, Attachment	
			SELECT  @LN= p.LASTNAME, @FN = p.FIRSTNAME, @PROVID = m.AUTHPCP, @PHONE = a.PHONE, @FAX = a.FAX, @EMAIL = a.EMAIL1 
			FROM [EZCAP65TEST].[EZCAPDB].[DBO].[AUTH_MASTERS_V] m LEFT JOIN [EZCAP65TEST].[EZCAPDB].[DBO].[PROV_COMPANY_V] p ON m.AUTHPCP_KEYID = p.PROV_KEYID
				LEFT JOIN [EZCAP65TEST].[EZCAPDB].[DBO].[PROV_ADDINFO_V] a ON m.AUTHPCP_KEYID = p.PROV_KEYID
			WHERE m.AUTHNO = @AuthNo
			
			EXEC [EZCAP65TEST].[EZCAPDB].[dbo].[usp_AutoIncidentNumber] @inUserID=@EZCAP_USERID,@ouRetValue=@CSIOUT output,@inModuleIndicator='5',@ouCSINo=@CSINO output,@ouOpenDate=@OPENDATE output
			--select @CSIOUT AS CISOUT, @CSINO AS CSINO
			
			IF NULLIF(@CSIOUT,'') IS NULL --No Exception
				BEGIN
					--Process next process - Notes, Attachment
					SELECT @PRIORITY = COMMON_ID FROM [EZCAP65TEST].EZCAPDB.dbo.COMMON_CODES_V WHERE CODE='1' AND CATEGORY_NAME='CSMPRIORITY' AND CURRHIST='C'
					SELECT @CONTACT = COMMON_ID FROM [EZCAP65TEST].EZCAPDB.dbo.COMMON_CODES_V WHERE CODE='F' AND CATEGORY_NAME='CSMCONTACTTYPES' AND CURRHIST='C'	
					SELECT @MODTYPE = COMMON_ID FROM [EZCAP65TEST].EZCAPDB.dbo.COMMON_CODES_V WHERE CODE='MOD' AND CATEGORY_NAME='CSMTYPES' AND CURRHIST='C'
					SELECT @STATUS = COMMON_ID FROM [EZCAP65TEST].EZCAPDB.dbo.COMMON_CODES_V WHERE CODE='O' AND CATEGORY_NAME='CSMSTATUS' AND CURRHIST='C'
					SELECT @SUBTYPE = COMMON_ID FROM [EZCAP65TEST].EZCAPDB.dbo.COMMON_CODES_V WHERE CODE='VA' AND CATEGORY_NAME='CSMSUBTYPES' AND CURRHIST='C'
					SELECT @ACTION = COMMON_ID FROM [EZCAP65TEST].EZCAPDB.dbo.COMMON_CODES_V WHERE CODE='RI' AND CATEGORY_NAME='CSMACTION' AND CURRHIST='C'
					SET @OPENDATE = CONVERT(VARCHAR,GETDATE(),120)
					SET @ACTIONDML = @CSINO+'±±1±MANAGER±'+CONVERT(VARCHAR, GETDATE(),101)+'±±±±AUTHS0±0±'+CAST(@ACTION AS CHAR)+'±'+CAST(@STATUS AS CHAR)+'±False±I' 

					EXEC [EZCAP65TEST].[EZCAPDB].[dbo].[usp_CSMIncidents_CRUDOperations_IU] @inDMLType='I',@inCSINO=@CSINO,@inCUSTHPCODE='',@inREFCLAIMNO='',@inREFCASENO='',@inREFPROVID='',@inREFMEMBID='',@inCUSTSubScriberID='',@in_CustVendorID='',@inINCTYPE=@MODTYPE,@inCONTACT=@CONTACT,@inCUSTCATEGORY='PROVIDER',@inPRIORITY=@PRIORITY,@inCUSTPROVID=@PROVID,@inCUSTOTHER='',@inPHONE=@PHONE,@inFAXNUM=@FAX,@inREFCATEGORY='AUTHORIZATION',@inOPENDATE=@OPENDATE,@inSECURITY=0,@inCUSTMEMBID='',@inSUBTYPE=@SUBTYPE,@inSTATUS=@STATUS,@inCOMPANY_ID='CHCNCHC',@inLASTNAME=@LN, @inFIRSTNAME=@FN,@inEMAIL='',@inREFAUTHNO=@AUTHNO,@inDESCRIPTION='OPEN', @inActionDML=@ACTIONDML,@inCustnotes='',@inRefnotes='',@inRelationShip=0,@inMobile='(   )    -    ',@inExt=0,@inRefOther='',@inUserID=10014,@inTime=@INTIME,@in_IsHPGlobal=0,@inECDServer='EZCAP65TEST',@in_UdfValues='1±±0§2±±0',@ouErrorNo=@ERRORNO output,@ouRetValue=@RETURNVAL output,@ouTotalTime=@TOTALTIME output,@ouModifiedDate=@MODIFDATE output,@ouCSINo=@CSINO output,@ou_ClosedDate=@CloseDate output
					--select @ERRORNO AS ERRORNO, @RETURNVAL AS RETURNVAL, @CSINO AS CSINO
					
					--IF no error found...
					IF @ERRORNO = 0
						BEGIN
							UPDATE CHCNAuthReq_Modification SET EZCAP_CSINO = @CSINO WHERE RowID = @ROWID
							SET @RetValue = @RETURNVAL
							
							--Add Notes to CSM incident	
							IF LEN(@NotesStr) > 0
								BEGIN
									INSERT INTO [EZCAP65TEST].[EZCAPDB].[dbo].[CSM_NOTES](CSINO, SEQUENCE, NOTES, SUBJECT, SECURED_YN, NOTSHARED_YN, CREATEBY, CREATEDATE, LASTCHANGEBY, LASTCHANGEDATE)
									SELECT @CSINO, ISNULL(MAX(SEQUENCE)+1, 1), @NotesStr, 'MOD', 0,0, @EZCAP_USERID, GETDATE(), @EZCAP_USERID, GETDATE()
									FROM [EZCAP65TEST].[EZCAPDB].[dbo].[CSM_NOTES] WHERE CSINO = @CSINO	
								END	

							IF LEN(@Notes) > 0
								BEGIN
									INSERT INTO [EZCAP65TEST].[EZCAPDB].[dbo].[CSM_NOTES](CSINO, SEQUENCE, NOTES, SUBJECT, SECURED_YN, NOTSHARED_YN, CREATEBY, CREATEDATE, LASTCHANGEBY, LASTCHANGEDATE)
									SELECT @CSINO, ISNULL(MAX(SEQUENCE)+1, 1), @Notes, 'Portal User Note', 0,0, @EZCAP_USERID, GETDATE(), @EZCAP_USERID, GETDATE()
									FROM [EZCAP65TEST].[EZCAPDB].[dbo].[CSM_NOTES] WHERE CSINO = @CSINO	
								END
								
							--File Attachment to CSM incident
							SET @CNT = 0
							--SELECT @CNT = COUNT(*) FROM CHCNAuthReq_Mod_Attachments_Temp WHERE MOD_REQID = @ROWID
							SELECT @CNT = COUNT(*) FROM CHCNAuthReq_Attachments_Temp WHERE REQUESTID = @AuthNo AND Msg_Flag IS NULL
							
							IF @CNT > 0
								BEGIN
									CREATE TABLE #temp_AuthModAttachments (ID INT IDENTITY(1,1), [FILENAME] VARCHAR(200), CONTENTTYPE VARCHAR(100), ATTACHMENT VARBINARY(MAX), DESCR VARCHAR(500))
									INSERT INTO #temp_AuthModAttachments ([FILENAME], CONTENTTYPE, ATTACHMENT, DESCR)
									SELECT REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR,GETDATE(),120),'-',''),' ',''),':','')+'_'+LTRIM(RTRIM([FILENAME])), CONTENTTYPE, ATTACHMENT, DESCR
									--FROM CHCNAuthReq_Mod_Attachments_Temp WHERE MOD_REQID = @ROWID 
									FROM CHCNAuthReq_Attachments_Temp WHERE REQUESTID = @AuthNo AND Msg_Flag IS NULL
									ORDER BY ID ASC	

									SET @ID = (SELECT MIN(ID) FROM #temp_AuthModAttachments)
									
									SET @FolderName = 'CHCNCHC'+@CSINO
									
									declare @p10 varchar(250)
									EXEC [EZCAP65TEST].[ECD].[dbo].[usp_CreateFolder_CRUDOperations] @inDMLType='I',@inFolderName=@FolderName,@inDescription='',@inParentID='',@inIsPublic=0,@inIsSystemDefined=1,@inCREATEBY=1,@inModifiedBy=1,@in_IsEZNET=0,@ou_intRetValue=@p10 output,@ou_FolderID=@FolderID output
													
									WHILE @CNT >= @ID
										BEGIN
											--
											SELECT @FileName = [FILENAME], @ContentType = CONTENTTYPE, @BINARYFILE = ATTACHMENT, @FILEDESCR = ISNULL(NULLIF(DESCR,''),'WEB ATTACHMENT')  
											FROM #temp_AuthModAttachments WHERE ID = @ID
										
											declare @p12 varchar(300)=NULL, @p13 varchar(250)=NULL, @p14 bigint=NULL, @p15 int=NULL, @p16 int=NULL, @p17 datetime=NULL, @p18 varchar(25)=NULL, @p19 int=NULL
											EXEC [EZCAP65TEST].[ECD].[dbo].[usp_FileInformation_CRUDOperations] @inDMLType='I',@inPhysicalFileName=@FileName,@inDescription=@FILEDESCR,@inFolderID=@FolderID,@inReferenceID=@ROWID,@inFileStatue=0,@inCREATEBY=1,@inModuleID=9,@inContenttype=@ContentType,@inImageClaim=@BINARYFILE, @inCompany_ID='CHCNCHC',@ou_intRetValue=@p12 output,@ou_FileName=@p13 output,@ou_ModifiedDate=@p14 output,@ou_FileID=@p15 output,@ou_ErrorNo=@p16 output,@ou_CreatedDate=@p17 output,@ou_Version=@p18 output,@ou_HistoryId=@p19 output,@in_IsEZNET=0
											--select @p12, @p13, @p14, @p15, @p16, @p17, @p18, @p19	
										
											SET @ID = (SELECT MIN(ID) FROM #temp_AuthModAttachments WHERE ID > @ID)
										END
									
									--Added to remove attachment records from temp table (SK.9/22/2015)
									DELETE FROM CHCNAuthReq_Attachments_Temp WHERE REQUESTID = @AuthNo AND Msg_Flag IS NULL
								END						
						END
					ELSE
						BEGIN
							SET @RetValue = @RETURNVAL
						END
				END 	
			ELSE 
				BEGIN
					SET @RetValue = @CSIOUT
				END				
		END
		
	END TRY
	BEGIN CATCH
		--SELECT ERROR_NUMBER(),ERROR_SEVERITY(),ERROR_STATE(),ERROR_PROCEDURE() 
		SET @RetValue = 'Error Line: ' + CAST(ERROR_LINE() AS VARCHAR(50)) + ', Error Message: ' + ERROR_MESSAGE();
	END CATCH
	
END





GO
