SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- =============================================
-- SK.5/25/2016
-- Update a UDF Auth Service Package Info 
-- =============================================
CREATE PROCEDURE [dbo].[CHCNPortal3_Update_udf_AuthServicePackage]

	@UserID VARCHAR(5),
	@ASPGroupID INT,
	@PackageDesc VARCHAR(60),
	@RetValue VARCHAR(200) = '' OUTPUT
	
AS
BEGIN
	
	SET NOCOUNT ON;		
	
	
	BEGIN TRY
	BEGIN TRAN
		
		IF @UserID IS NULL OR @ASPGroupID IS NULL
			BEGIN
				SET @RetValue = 'No Update was made due to missing required values.'
				RETURN
			END		
		ELSE
			BEGIN																	

				UPDATE CHCNPORTAL3_UDF_ASP_GROUPS
				SET GROUP_DESCR = @PackageDesc, LASTCHANGEBY = @UserID, LASTCHANGEDATE = GETDATE()
				WHERE ASPGROUPID = @ASPGroupID 

				--UPDATE CHCNPORTAL3_UDF_ASP_TABLES
				--SET TO_DATE = CAST(CAST(GETDATE() AS DATE) AS DATETIME), LASTCHANGEBY = @UserID, LASTCHANGEDATE = GETDATE()
				--WHERE ASPGROUPID = @ASPGroupID

				COMMIT TRAN
				SET @RetValue = 'Successfully Updated'
			END
    
    END TRY
	BEGIN CATCH
		--SELECT ERROR_NUMBER(),ERROR_SEVERITY(),ERROR_STATE(),ERROR_PROCEDURE() 
		SET @RetValue = 'Error Line: ' + CAST(ERROR_LINE() AS VARCHAR(50)) + ', Error Message: ' + ERROR_MESSAGE();
		IF (@@TRANCOUNT > 0)
			ROLLBACK TRAN				
	END CATCH	
	
END




GO
