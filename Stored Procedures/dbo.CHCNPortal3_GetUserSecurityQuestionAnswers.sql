SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [dbo].[CHCNPortal3_GetUserSecurityQuestionAnswers]

@UserId      int
AS 

SELECT *
FROM [Portal_DNN7].[dbo].[CHCNPortal_UserSecurityAnswers]
WHERE UserID=@UserID






GO
