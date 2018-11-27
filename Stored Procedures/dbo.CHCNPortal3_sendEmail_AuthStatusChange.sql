SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- =============================================
-- SK 12/03/2015
-- Description:	Run script at 8, 12, and 4 PM every day to send out email notification for status of Auth (Approved - 1, V or Denied - 3)
-- =============================================
CREATE PROCEDURE [dbo].[CHCNPortal3_sendEmail_AuthStatusChange]
	
AS
BEGIN
	
	SET NOCOUNT ON;
	
	DECLARE @AuthNo VARCHAR(25) = ''
	DECLARE @SubmitDate VARCHAR(25) = ''
	DECLARE @EmailSubject VARCHAR(50) = ''
	DECLARE @EmailBody VARCHAR(MAX) = ''
	DECLARE @UserEmail VARCHAR(256) = ''
	DECLARE @StartTime DATETIME
	DECLARE @EndTime DATETIME
	DECLARE @CNT INT = 0
	DECLARE @ROWID INT = 0
	
	
	--Check current hour and get the last 4 hours of Auth status change. If current hour is 8 AM, get the last 16 hours of Auth status change
	
	IF CONVERT(VARCHAR(2),GETDATE(), 108) IN (8)
		BEGIN
			SET @StartTime = DATEADD(HH, -16, GETDATE())
			SET @EndTime = GETDATE()
		END
	ELSE IF CONVERT(VARCHAR(2),GETDATE(), 108) IN (12,16)
		BEGIN
			SET @StartTime = DATEADD(HH, -4, GETDATE())
			SET @EndTime = GETDATE()
		END		
	
	IF OBJECT_ID('tempdb..#tmp_auditTB') IS NOT NULL DROP TABLE #tmp_auditTB
	CREATE TABLE #tmp_auditTB (ID INT IDENTITY(1,1), AUTHNO VARCHAR(40) NULL, POSTDT DATETIME NULL, USERID INT NULL, EMAIL VARCHAR(256) NULL, UPDATEDT DATETIME NULL)
		
	INSERT INTO #tmp_auditTB (AUTHNO, POSTDT, USERID, EMAIL, UPDATEDT)
	SELECT arm.EZCAP_AuthNo, arm.PostDt, u.UserID, CAST(u.Email AS VARCHAR(256)), MIN(aam.TIMESTAMP_CHANGED) AS StatusChangeDt
	FROM [CHCNAuthReq_Master] arm WITH (NOLOCK) INNER JOIN EZCAP65TEST.EZCAPDB.DBO.AUDIT_AUTH_MASTER aam WITH (NOLOCK) ON arm.EZCAP_AuthNo = aam.CHANGE_REC_KEY AND arm.EZCAP_AuthNo IS NOT NULL
		INNER JOIN Portal_DNN7.DBO.Users u WITH (NOLOCK) ON arm.UserID = u.UserID 
		LEFT JOIN EZCAP65TEST.EZCAPDB.DBO.AUTH_NOTES_V an ON arm.EZCAP_AuthNo = an.AUTHNO
	WHERE aam.FIELD_NAME = 'STATUS' 
		AND ((aam.NEW_VALUE LIKE '[1V]' AND aam.TIMESTAMP_CHANGED BETWEEN @StartTime AND @EndTime)
			OR (aam.NEW_VALUE LIKE '[3]' AND  LTRIM(RTRIM(an.SUBJECT)) IN ('DNLR') AND an.CREATEDATE BETWEEN @StartTime AND @EndTime))
	GROUP BY arm.EZCAP_AuthNo, arm.PostDt, u.UserID, u.Email
	ORDER BY arm.PostDt
	
	SELECT @CNT = COUNT(*) FROM #tmp_auditTB

	--LOOP THROUGH #tmp_auditTB
	WHILE @CNT > @ROWID
		BEGIN
			SET @ROWID = @ROWID + 1
			SELECT @AuthNo = AUTHNO, @SubmitDate = PostDt, @UserEmail = EMAIL FROM #tmp_auditTB WHERE ID = @ROWID				
			
			IF EXISTS (SELECT * FROM EZCAP65TEST.EZCAPDB.DBO.AUTH_MASTERS_V WITH (NOLOCK) WHERE AUTHNO = @AuthNo AND STATUS IN ('1','V')
						AND AUTHNO NOT IN (SELECT AuthNo FROM CHCNAuthReq_EmailNotificationLog WHERE AuthStatus = 'APPROVED'))
				BEGIN 
					SET @EmailSubject = 'AUTH APPROVED'
					SET @EmailBody = 'Auth NO ' + @AuthNo + ' submitted on ' + @SubmitDate + ' is now approved.'
					EXEC [MASTER].[DBO].[CHCNEDI_SendEmail] @to=@UserEmail ,@SUBJECT=@EmailSubject, @body=@EmailBody, @body_format='TEXT'
					
					INSERT INTO CHCNAuthReq_EmailNotificationLog (AuthNo, PostDt, UserID, Email, StatusChangeDt, EmailSentDt, AuthStatus)
					SELECT AUTHNO, POSTDT, USERID, EMAIL, UPDATEDT, GETDATE(), 'APPROVED' FROM #tmp_auditTB WHERE ID = @ROWID					
					
				END
			ELSE IF EXISTS (SELECT * FROM EZCAP65TEST.EZCAPDB.DBO.AUTH_MASTERS_V WITH (NOLOCK) WHERE AUTHNO = @AuthNo AND STATUS IN ('3')
							 AND AUTHNO IN (SELECT AUTHNO FROM [EZCAP65TEST].[EZCAPDB].[DBO].[AUTH_NOTES] WITH (NOLOCK) WHERE LTRIM(RTRIM(SUBJECT)) IN ('DNLR'))
							 AND AUTHNO NOT IN (SELECT AuthNo FROM CHCNAuthReq_EmailNotificationLog WHERE AuthStatus = 'DENIED'))
				BEGIN 
					SET @EmailSubject = 'AUTH DENIED'
					SET @EmailBody = 'Auth NO ' + @AuthNo + ' submitted on ' + @SubmitDate + ' has been denied by CHCN. You can now check the denial reason on CHCN Connect at https://portal.chcnetwork.org.'
					--SET @EmailBody = 'Auth NO ' + @AuthNo + ' submitted on ' + @SubmitDate + ' has been denied. Please check the detail note of denial reason in Portal website.'
					EXEC [MASTER].[DBO].[CHCNEDI_SendEmail] @to=@UserEmail ,@SUBJECT=@EmailSubject, @body=@EmailBody, @body_format='TEXT'
					
					INSERT INTO CHCNAuthReq_EmailNotificationLog (AuthNo, PostDt, UserID, Email, StatusChangeDt, EmailSentDt, AuthStatus)
					SELECT AUTHNO, POSTDT, USERID, EMAIL, UPDATEDT, GETDATE(), 'DENIED' FROM #tmp_auditTB WHERE ID = @ROWID
				END						
			
			--EXEC [MASTER].[DBO].[CHCNEDI_SendEmail] @reply_to='itsupport@chcnetwork.org', @to=@UserEmail ,@SUBJECT=@EmailSubject, @body=@EmailBody, @body_format='TEXT', @file_attachments=null
			

		END			
END


GO
