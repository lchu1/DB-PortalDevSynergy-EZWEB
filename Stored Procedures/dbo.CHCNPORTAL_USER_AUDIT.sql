SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- =============================================
-- Author:	 Almas Barzhaxynov
-- Create date: 03/31/2017
-- Description:	SPROC for logging activation and deactivation of users
-- =============================================
CREATE PROCEDURE [dbo].[CHCNPORTAL_USER_AUDIT]

 @DATE DATETIME,
 @USERID VARCHAR(50),
 @STATUS VARCHAR(50),
 @CHANGED_BY_ID VARCHAR(50),
 @TYPE VARCHAR(50),
 @USERNAME VARCHAR(50),
 @CHANGED_BY_USERNAME VARCHAR(50)
 
 AS

 INSERT INTO [EZWEB].[dbo].[CHCNPORTAL_LOG_USER_AUDIT]
 ([DATE],
 [USERID],
 [STATUS],
 [CHANGED_BY_ID],
 [TYPE],
 [USERNAME],
 [CHANGED_BY_USERNAME])
     VALUES
           (@DATE,
		   @USERID,
		   @STATUS,
		   @CHANGED_BY_ID,
		   @TYPE,
		   @USERNAME,
		   @CHANGED_BY_USERNAME)

GO
