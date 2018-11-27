SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE PROCEDURE [dbo].[CHCNAuthReq_DraftRetrieveByUserID]

@UserID  NVARCHAR(5)

AS

SELECT RequestID, LastModifiedDate
FROM  CHCNAuthReq_Master
WHERE UserID=@UserID and DraftMode = 1
ORDER BY LastModifiedDate



GO
