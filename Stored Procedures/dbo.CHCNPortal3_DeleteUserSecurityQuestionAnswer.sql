SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE PROCEDURE [dbo].[CHCNPortal3_DeleteUserSecurityQuestionAnswer]

@UserId      int,
@SecurityQuestionID int

AS 

DELETE FROM [Portal_DNN7].[dbo].[CHCNPortal_UserSecurityAnswers]
WHERE UserID=@UserID and SecurityQuestionID=@SecurityQuestionID









GO
