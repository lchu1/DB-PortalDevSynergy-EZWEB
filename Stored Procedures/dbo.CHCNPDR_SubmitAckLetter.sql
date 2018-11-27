SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- =============================================
--SK.1/18/2017
--Attached Ack Letter to EZCAP 
-- =============================================
CREATE PROCEDURE [dbo].[CHCNPDR_SubmitAckLetter] 

	@PDRNO VARCHAR(25), --CaseNo
	@FILENAME VARCHAR(500),
	@IMAGEFILE VARBINARY(MAX),
	@RetValue VARCHAR(200) OUTPUT

AS
BEGIN
	
	SET NOCOUNT ON;
	DECLARE @FolderName VARCHAR(50)
	DECLARE @FolderID INT
    DECLARE @ContentType VARCHAR(100) = 'application/pdf'
	DECLARE @FileDesc VARCHAR(500) = 'ACKNOWLEDGEMENT LETTER'  
	DECLARE @ReferenceID VARCHAR(25) = @PDRNO

	IF CHARINDEX('.pdf',@FILENAME) = 0 
	SET @FILENAME = @FILENAME + '.PDF'

	SET @FolderName = 'CHCNCHC'+@PDRNO
									
	declare @p10 varchar(250)
	EXEC [EZCAP65TEST].[ECD].[dbo].[usp_CreateFolder_CRUDOperations] @inDMLType='I',@inFolderName=@FolderName,@inDescription='',@inParentID='',@inIsPublic=0,@inIsSystemDefined=1,@inCREATEBY=1,@inModifiedBy=1,@in_IsEZNET=0,@ou_intRetValue=@p10 output,@ou_FolderID=@FolderID output							
					
	declare @p12 varchar(300)=NULL, @p13 varchar(250)=NULL, @p14 bigint=NULL, @p15 int=NULL, @p16 int=NULL, @p17 datetime=NULL, @p18 varchar(25)=NULL, @p19 int=NULL
	EXEC [EZCAP65TEST].[ECD].[dbo].[usp_FileInformation_CRUDOperations] @inDMLType='I',@inPhysicalFileName=@FileName,@inDescription=@FileDesc,@inFolderID=@FolderID,@inReferenceID=@ReferenceID,@inFileStatue=0,@inCREATEBY=1,@inModuleID=9,@inContenttype=@ContentType,@inImageClaim=@IMAGEFILE, @inCompany_ID='CHCNCHC',@ou_intRetValue=@p12 output,@ou_FileName=@p13 output,@ou_ModifiedDate=@p14 output,@ou_FileID=@p15 output,@ou_ErrorNo=@p16 output,@ou_CreatedDate=@p17 output,@ou_Version=@p18 output,@ou_HistoryId=@p19 output,@in_IsEZNET=0
	--select @p12, @p13, @p14, @p15, @p16, @p17, @p18, @p19										
	
	IF @p16 <> 0
		BEGIN
			SET @RetValue = 'Error: Ack Letter Attachement to EZCAP has failed - ' + @p12
		END
	ELSE
		SET @RetValue = 'Acknowledge Letter has been attached to EZCAP successfully'
    
END




GO
