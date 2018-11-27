SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE  PROCEDURE [dbo].[CHCNAuthReq_GetAttachments]

@RequestID varchar(20)

as

SELECT ID, RequestID, [FileName], ContentType, Descr
FROM CHCNAuthReq_Attachments_Temp 
WHERE RequestID = @RequestID







GO
