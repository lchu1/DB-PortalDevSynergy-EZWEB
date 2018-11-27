SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





--Created on SK.7/12/2016 
--Read UM notes from EZCAP and if note is created or updated, insert to log table
--Updated to get messages from log table to display the enter date of each message SK.7/18/2016

CREATE PROCEDURE [dbo].[CHCNPortal3_GetUMMessages] 
	@AUTHNO VARCHAR(25),
	@USERID NVARCHAR(5),
	@RetValue VARCHAR(200) = '' OUTPUT
AS
BEGIN
	
	SET NOCOUNT ON;
	
	DECLARE @CHCNMsgLeng INT
	DECLARE @CHCNNotes VARCHAR(MAX)
	DECLARE @EnterDate DATETIME
	DECLARE @CHCNUser INT
	DECLARE @MsgLeng INT
	DECLARE @MessageID INT

	BEGIN TRY
	--BEGIN TRAN

/*
		--Get Message
		SELECT @CHCNNotes = ISNULL(NOTES,''), @CHCNMsgLeng = LEN(LTRIM(RTRIM(ISNULL(NOTES,'')))), @CHCNUser = CREATEBY 
		FROM EZCAP65TEST.EZCAPDB.dbo.AUTH_NOTES_V WITH (NOLOCK) WHERE AUTHNO = @AUTHNO AND SUBJECT = 'PC' 	

		--Check if there exists a new lines of message by UM
		SELECT TOP 1 @MsgLeng = ISNULL(MSG_LENG,0), @MessageID = MessageID, @EnterDate = EnterDate FROM CHCNPORTAL3_MESSAGE_LOG WHERE AuthNo = @AUTHNO ORDER BY MessageID DESC
	    
		IF @CHCNMsgLeng <> @MsgLeng --Insert log
			BEGIN
				INSERT INTO CHCNPORTAL3_MESSAGE_LOG (AuthNo, CHCNUserID, UserID, Messages, Msg_Leng, EnterDate, IsRead)	
				SELECT @AUTHNO, @CHCNUser, @USERID, @CHCNNotes, @CHCNMsgLeng, GETDATE(), 1
				COMMIT TRAN		
			END	
		ELSE
			BEGIN --Flag as Read
				UPDATE CHCNPORTAL3_MESSAGE_LOG
				SET IsRead = 1, ReadDate = GETDATE()
				WHERE MessageID = @MessageID
				COMMIT TRAN
			END
	    
		--OUTPUT
		SELECT @CHCNNotes AS NOTES, @EnterDate AS ENTER_DATE, @CHCNUser AS CHCNUserID
*/
		
		IF EXISTS (SELECT * FROM CHCNPORTAL3_MESSAGE_LOG WHERE AuthNo = @AUTHNO AND ISNULL(IsRead,0) = 0)
			BEGIN
				UPDATE CHCNPORTAL3_MESSAGE_LOG
				SET IsRead = 1, ReadDate = GETDATE()
				WHERE ISNULL(IsRead,0) = 0 AND AuthNo = @AUTHNO
				
				--COMMIT TRAN
			END

		--Get Message for OUTPUT
		SELECT MessageID, Messages AS NOTES, EnterDate AS ENTER_DATE, 
			CASE WHEN UserID IS NULL THEN CHCNUserID ELSE UserID END AS CHCNUserID, ISNULL(CHCNUserName,'') AS CHCNUserName  
		FROM CHCNPORTAL3_MESSAGE_LOG WHERE AuthNo = @AUTHNO ORDER BY MessageID DESC --SK.10/5/2016 descending order
		
		
		    
    END TRY
	BEGIN CATCH
		--SELECT ERROR_NUMBER(),ERROR_SEVERITY(),ERROR_STATE(),ERROR_PROCEDURE() 
		SET @RetValue = 'Error Line: ' + CAST(ERROR_LINE() AS VARCHAR(50)) + ', Error Message: ' + ERROR_MESSAGE();
		--IF (@@TRANCOUNT > 0)
		--	ROLLBACK TRAN				
	END CATCH	
    
END




GO
