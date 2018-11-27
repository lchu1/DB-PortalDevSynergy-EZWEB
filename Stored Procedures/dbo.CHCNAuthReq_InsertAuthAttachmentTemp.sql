SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE  PROCEDURE [dbo].[CHCNAuthReq_InsertAuthAttachmentTemp]

@RequestID varchar(30),
@Filename varchar(200),
@ContentType varchar(100),
@Attachment varbinary(MAX),
@Description varchar(500)

as

BEGIN

SET @RequestID = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(@RequestID,CHAR(9),''),CHAR(10),''),CHAR(13),'')))	
SET @Filename = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(@Filename,CHAR(9),''),CHAR(10),''),CHAR(13),'')))	
SET @ContentType = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(@ContentType,CHAR(9),''),CHAR(10),''),CHAR(13),'')))	
SET @Description = LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(@Description,CHAR(9),''),CHAR(10),''),CHAR(13),'')))	

INSERT INTO CHCNAuthReq_Attachments_Temp (RequestID, [FileName], ContentType, Attachment, Descr)
VALUES (@RequestID, @FileName, @ContentType, @Attachment, @Description)

END





GO
