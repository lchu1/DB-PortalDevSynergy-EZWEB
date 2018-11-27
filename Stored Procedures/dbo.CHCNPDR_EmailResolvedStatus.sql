SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- =============================================
-- SK 01/26/2017
-- Description:	Notification email for resolved disputes
-- Closed Date = previous date, Event Type = 'DETERM NOTE'
-- =============================================
CREATE PROCEDURE [dbo].[CHCNPDR_EmailResolvedStatus]
	
AS
BEGIN
	
	SET NOCOUNT ON;
	
	DECLARE @CaseNo VARCHAR(25) = ''
	DECLARE @SubmitDate VARCHAR(25) = ''
	DECLARE @EmailSubject VARCHAR(50) = ''
	DECLARE @EmailBody VARCHAR(MAX) = ''
	DECLARE @UserEmail VARCHAR(256) = ''	
	DECLARE @CNT INT = 0
	DECLARE @ROWID INT = 0	
	DECLARE @YEAR CHAR(4) = DATEPART(YEAR,GETDATE())	

	IF OBJECT_ID('tempdb..#tmp_pdrCase') IS NOT NULL DROP TABLE #tmp_pdrCase
	CREATE TABLE #tmp_pdrCase (ID INT IDENTITY(1,1), CASENO VARCHAR(40) NULL, POSTDT DATETIME NULL, STATUS VARCHAR(50) NULL, UPDATEDT DATETIME NULL, USERID INT NULL, EMAIL VARCHAR(256) NULL)
		
	INSERT INTO #tmp_pdrCase (CASENO, POSTDT, STATUS, UPDATEDT, USERID, EMAIL)
	SELECT cpm.EZCAP_CaseNo, cpm.EZCAP_PostDt, cmv.STATUS, cmv.LASTCHANGEDATE, u.UserID, CAST(u.Email AS VARCHAR(256))
	FROM [CHCNPDR_Master] cpm WITH (NOLOCK) INNER JOIN EZCAP65TEST.EZCAPDB.dbo.CASE_MASTERS_V cmv WITH (NOLOCK) 
			ON cpm.EZCAP_CaseNo = cmv.CASENO AND cpm.EZCAP_CaseNo IS NOT NULL
		INNER JOIN Portal_DNN7.DBO.Users u WITH (NOLOCK) ON cpm.UserID = u.UserID 	
		INNER JOIN Portal_DNN7.dbo.UserProfile up ON u.UserID = up.UserID AND up.PropertyDefinitionID 
			= (SELECT PropertyDefinitionID FROM [Portal_DNN7].[dbo].[ProfilePropertyDefinition] WHERE PropertyName = 'DisputeNotifyResolve' AND PortalID = 0)
	WHERE EXISTS (SELECT * FROM EZCAP65TEST.EZCAPDB.dbo.CHCNEDI_PDRIMAGES_VS WITH (NOLOCK) WHERE CASENO = cmv.CASENO AND Description IN ('RL','RESOLUTION LETTER'))
		AND CAST(cmv.CLOSEDT AS DATE) = CAST(DATEADD(DAY,-1,GETDATE()) AS DATE) 		
		AND up.PropertyValue = 'True'
		AND cmv.CASENO NOT IN (SELECT CASENO FROM CHCNPDR_EmailNotificationLog)
	GROUP BY cpm.EZCAP_CaseNo, cpm.EZCAP_PostDt, cmv.STATUS, cmv.LASTCHANGEDATE, u.UserID, u.Email
	ORDER BY cpm.EZCAP_PostDt
	
	SELECT @CNT = COUNT(*) FROM #tmp_pdrCase

	--LOOP THROUGH ##tmp_pdrCase
	WHILE @CNT > @ROWID
		BEGIN
			SET @ROWID = @ROWID + 1
			SELECT @CaseNo = CASENO, @SubmitDate = PostDt, @UserEmail = EMAIL FROM #tmp_pdrCase WHERE ID = @ROWID		
			 
			SET @EmailSubject = 'Dispute Resolution Notification'
			--SET @EmailBody = 'PDR NO ' + @CaseNo + ' submitted on ' + @SubmitDate + ' is now resolved.'
--			SET @EmailBody = '<head><link href=''https://fonts.googleapis.com/css?family=Roboto:500,300,700'' rel=''stylesheet'' type=''text/css''></head><html><body style="margin: 0; padding: 0; background: #efefef;"> <table cellpadding=0 cellspacing=0 style="width: 100%;"><tr><td style="padding: 12px 2%;"><table cellpadding=0 cellspacing=0 style="margin: 0 auto; background: #fff; width: 900px;"><tr><td style="padding: 2% 0;"><img src="https://portal.chcnetwork.org/Portals/_Default/Skins/Connect/Images/chcn-logos-02.png" width="400" style="width: 50%; max-width: 400px"></td><td align="right"><img src="https://portal.chcnetwork.org/Portals/_Default/Skins/Connect/Images/chcn_connect_logo.png" width="300" style="width: 50%; max-width: 300px; float: right"></td></tr></table><table cellpadding=0 cellspacing=0 style="margin: 0 auto; background: #fff; width: 900px;"><tr><td><img src="https://portal.chcnetwork.org/Portals/_Default/Skins/Connect/Images/Banner.png" width="900" style="width: 100%; display: block"></td></tr></table><table cellpadding=0 cellspacing=0 style="margin: 0 auto; background: #fff; width: 900px;"><tr><td style="padding: 4%;"><div><h1 style="font-family: ''Roboto'', sans-serif; font-weight: 300; font-size: 44px">New Dispute Receipt</h1><p style="font-family: ''Roboto'', sans-serif; font-weight: 300">Community Health Center Network has reviewed your claim appeal and made a determination.The dispute is now closed and the resolution letter mailed. You can view a copy of the resolutionletter online via Connect under the Dispute App. </p> <p style="font-family: ''Roboto'', sans-serif; font-weight: 300">Thank you, <br>CHCN PDR Team </p> <br></div></td></tr></table><table cellpadding=0 cellspacing=0 style="margin: 0 auto; background: #203535; width: 900px;"><tr><td style="padding: 4%;"><div><p style="font-family: ''Roboto'', sans-serif; color:#fff; font-size: 14px; font-weight: 300">Community Health Center Network<br>101 Callan Avenue, Suite 300<br>San Leandro, CA 94577<br>M-F 9:00am to 5:00pm</p><p style="padding: 2% 0; border-top: solid 1px #fff; font-family: ''Roboto'', sans-serif; color:#fff; font-size: 14px; font-weight: 300">Copyright [CHCN:CopyrightYear] by Community Health Center Network</p></div></td></tr></table> </td></tr></table>
--</body>
--</html>'
			SET @EmailBody = '<head> <link href=''https://fonts.googleapis.com/css?family=Roboto:500,300,700'' rel=''stylesheet'' type=''text/css''> </head> <html> <body style="margin: 0; padding: 0; background: #efefef;"> <table cellpadding=0 cellspacing=0 style="width: 100%;"><tr><td style="padding: 12px 2%;"> <table cellpadding=0 cellspacing=0 style="margin: 0 auto; background: #fff; width: 900px;"><tr> <td style="padding: 2% 0;"><img src="https://portal.chcnetwork.org/Portals/9/Images/CHCN_LOGO_HORIZONTAL_RGB.png" width="400" style="width: 50%; max-width: 400px"></td> <td align="right"><img src="https://portal.chcnetwork.org/Portals/_Default/Skins/Connect/Images/chcn_connect_logo.png" width="300" style="width: 50%; max-width: 300px; float: right"></td> </tr></table> <table cellpadding=0 cellspacing=0 style="margin: 0 auto; background: #fff; width: 900px;"><tr> <td><img src="https://portal.chcnetwork.org/Portals/_Default/Skins/Connect/Images/Banner.png" width="900" style="width: 100%; display: block"></td> </tr></table> <table cellpadding=0 cellspacing=0 style="margin: 0 auto; background: #fff; width: 900px;"><tr><td style="padding: 4%;"> <div> <h1 style="font-family: ''Roboto'', sans-serif; font-weight: 300; font-size: 44px">Dispute Resolution Notification</h1> <p style="font-family: ''Roboto'', sans-serif; font-weight: 300"> Community Health Center Network has reviewed your claim dispute and made a determination on PDR# '+ @CaseNo +'. The dispute is now closed and the resolution letter mailed. You can view a copy of the resolution letter online via Connect under the Dispute App. </p> <p style="font-family: ''Roboto'', sans-serif; font-weight: 300"> Thank you, <br> CHCN PDR Team </p> <br> </div> </td></tr></table> <table cellpadding=0 cellspacing=0 style="margin: 0 auto; background: #203535; width: 900px;"><tr><td style="padding: 4%;"> <div> <p style="font-family: ''Roboto'', sans-serif; color:#fff; font-size: 14px; font-weight: 300"> Community Health Center Network <br> 101 Callan Avenue, Suite 300 <br> San Leandro, CA 94577 <br> M-F 9:00am to 5:00pm </p> <p style="padding: 2% 0; border-top: solid 1px #fff; font-family: ''Roboto'', sans-serif; color:#fff; font-size: 14px; font-weight: 300"> Copyright ' + @YEAR + ' by Community Health Center Network </p> </div> </td></tr></table> </td></tr></table> </body> </html>'

			EXEC [MASTER].[DBO].[CHCNEDI_SendEmail] @to=@UserEmail ,@SUBJECT=@EmailSubject, @body=@EmailBody, @body_format='HTML'
					
			INSERT INTO CHCNPDR_EmailNotificationLog (CASENO, PostDt, UserID, Email, StatusChangeDt, EmailSentDt, PDRStatus)
			SELECT CASENO, POSTDT, USERID, EMAIL, UPDATEDT, GETDATE(), STATUS FROM #tmp_pdrCase WHERE ID = @ROWID			
						
		END			
END






GO
