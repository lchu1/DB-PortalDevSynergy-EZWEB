SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







CREATE  PROCEDURE [dbo].[CHCNPDR_GetAttachmentTemp]

@RequestID varchar(20)

as

SELECT ID, RequestID, [FileName], ContentType, Attachment, Descr
FROM CHCNPDR_Attachments_Temp 
WHERE RequestID = @RequestID










GO
