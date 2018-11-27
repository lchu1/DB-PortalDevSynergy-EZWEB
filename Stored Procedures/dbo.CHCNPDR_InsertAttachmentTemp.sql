SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








CREATE  PROCEDURE [dbo].[CHCNPDR_InsertAttachmentTemp]

@RequestID VARCHAR(30),
@Filename VARCHAR(200),
@ContentType VARCHAR(100),
@Attachment VARBINARY(MAX),
@Description VARCHAR(500)

AS

BEGIN

SET @RequestID = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(@RequestID,CHAR(9),''),CHAR(10),''),CHAR(13),'')))	
SET @Filename = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(@Filename,CHAR(9),''),CHAR(10),''),CHAR(13),'')))	
SET @ContentType = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(@ContentType,CHAR(9),''),CHAR(10),''),CHAR(13),'')))	
SET @Description = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(@Description,CHAR(9),''),CHAR(10),''),CHAR(13),'')))	

INSERT INTO CHCNPDR_Attachments_Temp (RequestID, [FileName], ContentType, Attachment, Descr)
VALUES (@RequestID, @FileName, @ContentType, @Attachment, @Description)

END









GO
