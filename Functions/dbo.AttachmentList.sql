SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







CREATE function [dbo].[AttachmentList]( @REQUESTID varchar(30))

RETURNS VARCHAR(500)
AS
BEGIN
DECLARE @AttachmentList varchar(500)

SELECT @AttachmentList = COALESCE(@AttachmentList + ', ', '') + 
   CAST([Filename] AS varchar(100)) 
FROM CHCNPORTAL_AuthReq_Attachments
WHERE REQUESTID = @REQUESTID

RETURN @AttachmentList

END










GO
