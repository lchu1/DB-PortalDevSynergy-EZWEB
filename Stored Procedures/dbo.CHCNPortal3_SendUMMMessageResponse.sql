SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






--Created on SK.7/14/2016 
--Send provider message along the attachments to EZCAP for UM users
--Updated to exclude messaging length comparison. SK.7/18/2016

CREATE PROCEDURE [dbo].[CHCNPortal3_SendUMMMessageResponse] 
	@AUTHNO VARCHAR(25),
	@USERID NVARCHAR(5),
	@MESSAGE NVARCHAR(MAX),
	@RetValue VARCHAR(1000) = '' OUTPUT
AS
BEGIN
	
	SET NOCOUNT ON;
	
	DECLARE @CHCNUser INT
	DECLARE @LASTCHANGEBY INT = 10209 --Portal Connect UserID in EZCAP
	--DECLARE @PROVMsgLeng INT
	--DECLARE @MsgLeng INT
	DECLARE @ProvName VARCHAR(200)
	DECLARE @CHCNUserName VARCHAR(200)
	DECLARE @EmailSubject VARCHAR(200)
	DECLARE @EmailMessage VARCHAR(MAX)
	DECLARE @EmailTo VARCHAR(200)	
	DECLARE @AttCount INT = 0 
	DECLARE @MessageID INT = 0

	BEGIN TRY	

		/*
		SELECT @PROVMsgLeng = LEN(ISNULL(@MESSAGE,''))
		
		--Check if there exists a new lines of message by UM
		SELECT TOP 1 @MsgLeng = ISNULL(MSG_LENG,0), @CHCNUser = CHCNUserID 
		FROM CHCNPORTAL3_MESSAGE_LOG WHERE AuthNo = @AUTHNO ORDER BY MessageID DESC
	    
		IF @PROVMsgLeng <> @MsgLeng --Insert log
			BEGIN
				INSERT INTO CHCNPORTAL3_MESSAGE_LOG (AuthNo, CHCNUserID, UserID, Messages, Msg_Leng, EnterDate, IsRead)	
				SELECT @AUTHNO, @CHCNUser, @USERID, @MESSAGE, @PROVMsgLeng, GETDATE(), 1 				
			END	
			
		--Update EZCAP 	
	    UPDATE EZCAP65TEST.EZCAPDB.dbo.AUTH_NOTES
	    SET NOTES = NOTES + '~~' + ISNULL(@MESSAGE,'') , LASTCHANGEBY = @LASTCHANGEBY, LASTCHANGEDATE = GETDATE()
	    WHERE AUTHNO = @AUTHNO AND SUBJECT = 'PC'	    
	    
	    */  
	    
	    SELECT @AttCount = COUNT(*) FROM CHCNAuthReq_Attachments_Temp WHERE REQUESTID = @AUTHNO AND ISNULL(Msg_Flag,0) = 1	
	    
	    IF (NULLIF(@MESSAGE,'') IS NULL AND @AttCount = 0)
			SET @RetValue = 'No Message or Attachment to Send'
	    ELSE
			BEGIN
				IF NULLIF(@MESSAGE,'') IS NOT NULL    
					BEGIN
						INSERT INTO CHCNPORTAL3_MESSAGE_LOG (AuthNo, UserID, Messages, EnterDate, IsRead)	
						SELECT @AUTHNO, @USERID, @MESSAGE, GETDATE(), 1 				
						
						IF @@ERROR = 0
							SELECT @MessageID = MAX(MessageID) FROM CHCNPORTAL3_MESSAGE_LOG
						
						--Format Notes String in descending order (SK.10/5/2016)
						DECLARE @NOTES VARCHAR(MAX)
						SELECT @NOTES = CONCAT(@NOTES, CHAR(13)+CHAR(10)+CHAR(13)+CHAR(10),'From: '+CASE WHEN m.UserID IS NULL THEN  ISNULL(m.CHCNUserName,'CHCN') ELSE ISNULL(u.DisplayName,'') END+' - Date: '+ISNULL(CAST(EnterDate AS VARCHAR(20)),'')+CHAR(13)+CHAR(10)+' '+ISNULL(Messages,'')) 
							FROM CHCNPORTAL3_MESSAGE_LOG m LEFT JOIN Portal_DNN7.dbo.Users u ON m.UserID = u.UserID
							WHERE AuthNo = @AUTHNO ORDER BY MessageID DESC 
						--PRINT @NOTES

						--Update EZCAP 							
						UPDATE EZCAP65TEST.EZCAPDB.dbo.AUTH_NOTES
						SET NOTES = @NOTES, --NOTES + '~~' + ISNULL(@MESSAGE,'') , 
							LASTCHANGEBY = @LASTCHANGEBY, LASTCHANGEDATE = GETDATE()
						WHERE AUTHNO = @AUTHNO AND SUBJECT = 'PC'	
					END
				--Add Attachment to EZCAP			
				IF @AttCount > 0
					BEGIN
						DECLARE @ID INT
						DECLARE @FolderName varchar(50)
						DECLARE @FolderID int
						DECLARE @FileName VARCHAR(200)
						DECLARE @ContentType VARCHAR(100)
						DECLARE @BinaryFile VARBINARY(MAX)
						DECLARE @FileDescr VARCHAR(500)	
						DECLARE @FileReferenceID VARCHAR(25) = CAST(@MessageID AS VARCHAR(25))
					
						CREATE TABLE #temp_MsgAttachments (ID INT IDENTITY(1,1), [FILENAME] VARCHAR(200), CONTENTTYPE VARCHAR(100), ATTACHMENT VARBINARY(MAX), DESCR VARCHAR(500))
						INSERT INTO #temp_MsgAttachments ([FILENAME], CONTENTTYPE, ATTACHMENT, DESCR)
						SELECT REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR,GETDATE(),120),'-',''),' ',''),':','')+'_'+LTRIM(RTRIM([FILENAME])), CONTENTTYPE, ATTACHMENT, DESCR
						FROM CHCNAuthReq_Attachments_Temp WHERE REQUESTID = @AuthNo AND Msg_Flag = 1
						ORDER BY ID ASC	

						SET @ID = (SELECT MIN(ID) FROM #temp_MsgAttachments)
						
						SET @FolderName = 'CHCNCHC'+@AUTHNO
						
						declare @p10 varchar(250)
						EXEC [EZCAP65TEST].[ECD].[dbo].[usp_CreateFolder_CRUDOperations] @inDMLType='I',@inFolderName=@FolderName,@inDescription='',@inParentID='',@inIsPublic=0,@inIsSystemDefined=1,@inCREATEBY=1,@inModifiedBy=1,@in_IsEZNET=0,@ou_intRetValue=@p10 output,@ou_FolderID=@FolderID output
										
						WHILE @AttCount >= @ID
							BEGIN
								--
								SELECT @FileName = [FILENAME], @ContentType = CONTENTTYPE, @BinaryFile = ATTACHMENT, @FileDescr = ISNULL(NULLIF(DESCR,''),'CONNECT MESSAGE ATTACHMENT')--, @FileReferenceID = 'CONNECT PC MESSAGE'  
								FROM #temp_MsgAttachments WHERE ID = @ID
							
								DECLARE @p12 VARCHAR(300)=NULL, @p13 VARCHAR(250)=NULL, @p14 BIGINT=NULL, @p15 INT=NULL, @p16 INT=NULL, @p17 DATETIME=NULL, @p18 VARCHAR(25)=NULL, @p19 INT=NULL
								EXEC [EZCAP65TEST].[ECD].[dbo].[usp_FileInformation_CRUDOperations] @inDMLType='I',@inPhysicalFileName=@FileName,@inDescription=@FileDescr,@inFolderID=@FolderID,@inReferenceID=@FileReferenceID,@inFileStatue=0,@inCREATEBY=1,@inModuleID=9,@inContenttype=@ContentType,@inImageClaim=@BinaryFile, @inCompany_ID='CHCNCHC',@ou_intRetValue=@p12 OUTPUT,@ou_FileName=@p13 OUTPUT,@ou_ModifiedDate=@p14 OUTPUT,@ou_FileID=@p15 OUTPUT,@ou_ErrorNo=@p16 OUTPUT,@ou_CreatedDate=@p17 OUTPUT,@ou_Version=@p18 OUTPUT,@ou_HistoryId=@p19 OUTPUT,@in_IsEZNET=0
								--select @p12, @p13, @p14, @p15, @p16, @p17, @p18, @p19	
							
								SET @ID = (SELECT MIN(ID) FROM #temp_MsgAttachments WHERE ID > @ID)
							END
						
						--Remove attachments from temp table
						DELETE FROM CHCNAuthReq_Attachments_Temp WHERE REQUESTID = @AuthNo AND Msg_Flag = 1
					END	
					
				--Send Email to Provider								
				SELECT @EmailTo = 'umcod@chcnetwork.org;' + Email, @CHCNUserName = Users_Name FROM EZCAP65TEST.ECD.dbo.USERS 
				WHERE Users_ID = (SELECT TOP 1 CHCNUserID FROM CHCNPORTAL3_MESSAGE_LOG WHERE AuthNo = @AUTHNO AND CHCNUserID IS NOT NULL ORDER BY MessageID DESC)

				SELECT @ProvName = DisplayName FROM Portal_DNN7.dbo.Users WHERE UserID = @USERID
				
				SET @EmailSubject = ISNULL(@ProvName,'') + ' replied to your message - Auth # ' + @AUTHNO					
				
				--Need to get the HTML message string from Daniel
				SET @EmailMessage = '<head><link href="https://fonts.googleapis.com/css?family=Roboto:500,300,700" rel="stylesheet" type="text/css"></head><html><body style="margin: 0; padding: 0; background: #efefef;"><table style="width: 100%;" cellspacing="0" cellpadding="0"><tbody><tr><td style="padding: 12px 2%;"><table cellpadding=0 cellspacing=0 style="margin: 0 auto; background: #fff; width: 900px;"><tr><td style="padding: 2% 0;"><img src="https://portal.chcnetwork.org/Portals/9/Images/CHCN_LOGO_HORIZONTAL_RGB.png" width="400" style="width: 50%; max-width: 400px"></td><td align="right"><img src="https://portal.chcnetwork.org/Portals/_Default/Skins/Connect/Images/chcn_connect_logo.png" width="300" style="width: 50%; max-width: 300px; float: right"></td></tr></table><table cellpadding=0 cellspacing=0 style="margin: 0 auto; background: #fff; width: 900px;"><tr><td><img src="https://portal.chcnetwork.org/Portals/_Default/Skins/Connect/Images/Banner.png" width="900" style="width: 100%; display: block"></td></tr></table><table style="margin: 0 auto; background: #fff; width: 900px;" cellspacing="0" cellpadding="0"><tbody><tr><td style="padding: 4%;"><div><h1 style="font-family: ''Roboto'', sans-serif; font-weight: 300; font-size: 44px;">New Message Waiting For You</h1><p style="font-family: ''Roboto'', sans-serif; font-weight: 300;">Hi '+ ISNULL(@CHCNUserName,'') +',<br><br>I left you a new message in Auth # '+@AUTHNO+'. Please log in to EZ-CAP to view it.<br><br>'+ISNULL(@ProvName,'')+'</p></div></td></tr></tbody></table><table style="margin: 0 auto; background: #203535; width: 900px;" cellspacing="0" cellpadding="0"><tbody><tr><td style="padding: 4%;"><div><p style="font-family: ''Roboto'', sans-serif; color: #fff; font-size: 14px; font-weight: 300;">Community Health Center Network <br /> 101 Callan Avenue, Suite 300 <br /> San Leandro, CA 94577 <br /> M-F 9:00am to 5:00pm</p><p style="padding: 2% 0; border-top: solid 1px #fff; font-family: ''Roboto'', sans-serif; color: #fff; font-size: 14px; font-weight: 300;">Copyright 2016 by Community Health Center Network</p></div></td></tr></tbody></table></td></tr></tbody></table></body></html>'
--				SET @EmailMessage = 'New Message Waiting For you 
		
--Hi ' + @CHCNUserName + ',
--I left you a new message in Auth # ' + @AUTHNO + '. Please log in to EZ-CAP to view it.

--' +  @ProvName
			
				EXEC [master].[dbo].[CHCNEDI_SendEmail] @to = @EmailTo,@subject = @EmailSubject , @body = @EmailMessage, @body_format = 'html'			    	
		    	    
				SET @RetValue = 'Successfully Sent to EZCAP'
			END
    END TRY
	BEGIN CATCH
		--SELECT ERROR_NUMBER(),ERROR_SEVERITY(),ERROR_STATE(),ERROR_PROCEDURE() 
		SET @RetValue = 'Error Line: ' + CAST(ERROR_LINE() AS VARCHAR(50)) + ', Error Message: ' + ERROR_MESSAGE();
		--IF (@@TRANCOUNT > 0)
			--ROLLBACK TRAN				
	END CATCH	
    
END





GO
