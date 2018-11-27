SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE  PROCEDURE [dbo].[CHCNAuthReq_DraftInsertToMaster]

@RequestID varchar(30), 
@UserID nvarchar(5),
@ServiceStartDate DateTime

as

BEGIN

SET @RequestID = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(@RequestID,CHAR(9),''),CHAR(10),''),CHAR(13),'')))	

IF (SELECT count(*) FROM CHCNAuthReq_Master WHERE RequestID=@RequestID) = 0 
INSERT INTO CHCNAuthReq_Master (RequestID, UserID, ServiceStartDate, LastAccessDate, LastModifiedDate, CreateDate) 
VALUES (@RequestID, @UserID, @ServiceStartDate, GetDate(), GetDate(), GetDate())

END






GO
