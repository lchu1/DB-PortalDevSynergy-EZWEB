SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





CREATE PROCEDURE [dbo].[CHCNAuthReq_GetNewAuthRequestID]

as

declare @GenDate int, @CurrentNumber int, @RequestID varchar(38), @UserID int

BEGIN

 select @UserID = '10000'

 SELECT @GenDate = 0, @CurrentNumber = 0  
 SELECT @GenDate = CONVERT(INT, CONVERT(VARCHAR, GETDATE(), 112))  
 
 IF EXISTS(SELECT CurrentNumber FROM AutoNumberGen WHERE UserID = @UserID AND GenDate = @GenDate)  
	BEGIN  
		SELECT @CurrentNumber = CurrentNumber + 1  
		FROM AutoNumberGen   
		WHERE UserID = @UserID AND GenDate = @GenDate 
  
		UPDATE AutoNumberGen SET CurrentNumber = @CurrentNumber   
		WHERE UserID = @UserID AND GenDate = @GenDate 
  
	END  
 
	ELSE  
	
	BEGIN  
		INSERT INTO AutoNumberGen(GenDate, UserID, CurrentNumber)  
		VALUES(@GenDate, @UserID, 1)  
		SET @CurrentNumber = 1  
	END   
 
	SELECT RequestID = CONVERT(VARCHAR(8), @GenDate)+REPLICATE('0', 5-LEN(CONVERT(VARCHAR, @UserID)))+CONVERT(VARCHAR, @UserID)+REPLICATE('0', 5-LEN(CONVERT(VARCHAR, @CurrentNumber)))+CONVERT(VARCHAR, @CurrentNumber)  
END  

RETURN





GO
