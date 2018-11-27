SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






CREATE PROCEDURE [dbo].[CHCNAuthReq_UpdateSubmitStatus]

@RequestID varchar(30),
@EZCAP_AuthNo varchar(30)

As

UPDATE dbo.CHCNAuthReq_CPT_Temp SET Submitted=1
WHERE REQUESTID = @RequestID

UPDATE dbo.CHCNAuthReq_ICD_Temp SET Submitted=1
WHERE REQUESTID = @RequestID

UPDATE dbo.CHCNAuthReq_Attachments_Temp SET Submitted=1
WHERE REQUESTID = @RequestID

UPDATE [EZWEB].[dbo].[CHCNAuthReq_Master]
   SET 
		[EZCAP_AuthNo] = @EZCAP_AuthNo
		,[PostDt] = GetDate()
		,[LastAccessDate] = GetDate()
		,[LastModifiedDate] = GetDate()
		,[DraftMode] = 0
 WHERE RequestID=@RequestID


RETURN






GO
