SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [dbo].[CHCNPortal3_AddUserSecurityQuestionAnswer]

@UserId      int,
@SecurityQuestionID int,
@SecurityAnswer varchar(200)

AS 

INSERT INTO [Portal_DNN7].[dbo].[CHCNPortal_UserSecurityAnswers]
(UserID, SecurityQuestionID, SecurityAnswer) Values (@UserID, @SecurityQuestionID, @SecurityAnswer)







GO
