SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- =============================================
-- SK.4/29/2016 
-- Enable 24 hour delay in local admin account activation email 
/* 
•Local Admin is created in DNN but set to unauthorized status; confirmation email is sent out to user email from DNN.
•SQL job which runs every hour checks the [EZWEB].[dbo].[CHCNPORTAL_LocalAdmin] table for user's EnterDate values.
•If the user's EnterDate is between 24 and 25 hours old (from the current date) and the user is not authorized (check against [Portal_DNN7].[dbo].[UserPortals]), then authorize the user.
•Send a welcome email to the user.
*/
-- Added logic to filter only Local Users SK.6/12/2017

-- =============================================
CREATE PROCEDURE [dbo].[CHCNPortal3_ActivateLocalAdmin_Send24HDelayEmail]	
	
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @UserID INT = 0
	DECLARE @CNT INT = 0
	DECLARE @ID INT = 0
	DECLARE @EmailSubject VARCHAR(100) = 'Your Local Admin account for CHCN Connect is now active'
	DECLARE @EmailBody VARCHAR(MAX) = ''
	DECLARE @UserEmail VARCHAR(256) = ''
	DECLARE @LocalAdminRoleName VARCHAR(20) = N'Local Admin'
	DECLARE @YEAR CHAR(4) = DATEPART(YEAR,GETDATE())	
	
	IF OBJECT_ID('tempdb..#LocalAdmin') IS NOT NULL DROP TABLE #LocalAdmin
	CREATE TABLE #LocalAdmin (ID INT IDENTITY(1,1), UserID VARCHAR(5), Email VARCHAR(256) NULL)
	
	--INSERT INTO #LocalAdmin(UserID, Email)
	--SELECT la.UserID, CAST(u.Email AS VARCHAR(256))  
	--FROM CHCNPORTAL_LocalAdmin la 
	--	INNER JOIN Portal_DNN7.DBO.Users u ON la.UserID = u.UserID 
	--	INNER JOIN [Portal_DNN7].[dbo].[UserPortals] up ON la.UserID = up.UserId
	--WHERE ISNULL(up.Authorised,0) <> 1 AND ISNULL(la.IsActivated,0) <> 1
	--	AND (CONVERT(VARCHAR(10),ISNULL(la.EnterDate,'01/01/2016'),101) = CONVERT(VARCHAR(10),DATEADD(DAY,-1,GETDATE()),101)
	--		OR CONVERT(VARCHAR(10),ISNULL(la.EnterDate,'01/01/2016'),101) = CONVERT(VARCHAR(10),DATEADD(DAY,-2,GETDATE()),101))
	--	AND CURRENT_TIMESTAMP > DATEADD(HH,24,ISNULL(la.EnterDate,'01/01/2016'))
	--	--CURRENT_TIMESTAMP BETWEEN DATEADD(HH,24,ISNULL(la.EnterDate,'01/01/2016')) AND DATEADD(HH,25,ISNULL(la.EnterDate,'01/01/2016'))
	--GROUP BY la.UserID, u.Email ORDER BY la.UserID	
	
	INSERT INTO #LocalAdmin(UserID, Email)	
	SELECT u.UserID, CAST(u.Email AS VARCHAR(256))  
	FROM Portal_DNN7.dbo.Users u 
		INNER JOIN Portal_DNN7.dbo.UserPortals up ON u.UserID = up.UserId
		INNER JOIN Portal_DNN7.dbo.UserRoles ur ON u.UserID = ur.UserID AND ur.RoleID = (SELECT RoleID FROM [Portal_DNN7].[dbo].[Roles] WHERE RoleName= @LocalAdminRoleName)
	WHERE ISNULL(up.Authorised,0) <> 1 
		AND (CONVERT(VARCHAR(10),ISNULL(up.CreatedDate,'01/01/2016'),101) = CONVERT(VARCHAR(10),DATEADD(DAY,-1,GETDATE()),101)
			OR CONVERT(VARCHAR(10),ISNULL(up.CreatedDate,'01/01/2016'),101) = CONVERT(VARCHAR(10),DATEADD(DAY,-2,GETDATE()),101))
		AND CURRENT_TIMESTAMP > DATEADD(HH,24,ISNULL(up.CreatedDate ,'01/01/2016'))		
		AND u.UserID NOT IN (SELECT UserID FROM Portal_DNN7.dbo.UserProfile WHERE PropertyDefinitionID = 73 AND PropertyValue = '562629193')
	GROUP BY u.UserID, u.Email ORDER BY u.UserID	
	
	SELECT @CNT = COUNT(*) FROM #LocalAdmin	
		
	--Loop through Local Admin users 
	WHILE @CNT > @ID
		BEGIN
			SELECT @ID = MIN(ID), @UserID = UserID, @UserEmail = Email FROM #LocalAdmin WHERE ID > @ID GROUP BY UserID, Email
			
			--Activate Local Admin
			UPDATE [Portal_DNN7].[dbo].[UserPortals] SET Authorised = 1 WHERE UserId = @UserID	
			--UPDATE CHCNPORTAL_LocalAdmin SET IsActivated = 1, ActivatedDate = GETDATE() WHERE UserId = @UserID			
					
			--Send Email Notification
			SET @EmailBody = '<head><link href="https://fonts.googleapis.com/css?family=Roboto:500,300,700" rel="stylesheet" type="text/css"></head><html><body style="margin: 0; padding: 0; background: #efefef;"><table style="width: 100%;" cellspacing="0" cellpadding="0"><tbody><tr><td style="padding: 12px 2%;"><table cellpadding=0 cellspacing=0 style="margin: 0 auto; background: #fff; width: 900px;"><tr><td style="padding: 2% 0;"><img src="https://connect.chcnetwork.org/Portals/9/Images/CHCN_LOGO_HORIZONTAL_RGB.png" width="400" style="width: 50%; max-width: 400px"></td><td align="right"><img src="https://connect.chcnetwork.org/Portals/_Default/Skins/Connect/Images/chcn_connect_logo.png" width="300" style="width: 50%; max-width: 300px; float: right"></td></tr></table><table cellpadding=0 cellspacing=0 style="margin: 0 auto; background: #fff; width: 900px;"><tr><td><img src="https://connect.chcnetwork.org/Portals/_Default/Skins/Connect/Images/Banner.png" width="900" style="width: 100%; display: block"></td></tr></table><table style="margin: 0 auto; background: #fff; width: 900px;" cellspacing="0" cellpadding="0"><tbody><tr><td style="padding: 4%;"><div><h1 style="font-family: ''Roboto'', sans-serif; font-weight: 300; font-size: 44px;">Welcome to CHCN Connect.</h1><p style="font-family: ''Roboto'', sans-serif; font-weight: 300;">Welcome to CHCN Connect. <br><br>Your request for designation as the Local Administrator for you group has been approved. You can now log into Connect to take advantage of our new online authorization submission feature, add new users and manage existing user accounts. <br><br>Online authorization submission is a new feature in Connect therefore you will need to add access for this feature to all staff portal account''s that will submit authorizations to CHCN. <br><br>Be sure to check out our Resources section of Connect. There you will find links to our Connect Training, FAQ''s and information from our Provider Services and UM Departments. </p></div></td></tr></tbody></table><table style="margin: 0 auto; background: #203535; width: 900px;" cellspacing="0" cellpadding="0"><tbody><tr><td style="padding: 4%;"><div><p style="font-family: ''Roboto'', sans-serif; color: #fff; font-size: 14px; font-weight: 300;">Community Health Center Network <br /> 101 Callan Avenue, Suite 300 <br /> San Leandro, CA 94577 <br /> M-F 9:00am to 5:00pm</p><p style="padding: 2% 0; border-top: solid 1px #fff; font-family: ''Roboto'', sans-serif; color: #fff; font-size: 14px; font-weight: 300;">Copyright ' + @YEAR + ' by Community Health Center Network</p></div></td></tr></tbody></table></td></tr></tbody></table></body></html>'

			EXEC [MASTER].[DBO].[CHCNEDI_SendEmail] @to=@UserEmail ,@SUBJECT=@EmailSubject, @body=@EmailBody, @body_format='HTML'		
			
		END					
END

GO
