SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [dbo].[CHCNPortal3_UpdateUserSecurityAnswer]

@UserId      int,
@SecurityQuestionID int,
@SecurityAnswer varchar(200)

AS 

UPDATE [Portal_DNN7].[dbo].[CHCNPortal_UserSecurityAnswers]
SET SecurityAnswer=@SecurityAnswer
WHERE UserID=@UserID and @SecurityQuestionID=@SecurityQuestionID







GO
