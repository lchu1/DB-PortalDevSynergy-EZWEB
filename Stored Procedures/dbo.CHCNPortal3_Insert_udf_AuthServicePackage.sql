SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- =============================================
-- SK.5/25/2016
-- Create a new UDF Auth Service bundle 
-- =============================================
CREATE PROCEDURE [dbo].[CHCNPortal3_Insert_udf_AuthServicePackage]

	@UserID VARCHAR(5),
	@CompanyID VARCHAR(20),
	@PackageDesc VARCHAR(60),	
	@ASPGroupID INT OUTPUT,
	@RetValue VARCHAR(200) = '' OUTPUT
	
AS
BEGIN
	
	SET NOCOUNT ON;		
	
	
	BEGIN TRY
	BEGIN TRAN
		
		IF @UserID IS NULL OR @CompanyID IS NULL OR @PackageDesc IS NULL
			BEGIN
				SET @RetValue = 'No Insertion was made because of missing required values.'
				RETURN
			END		
		ELSE
			BEGIN			
				
				SET @ASPGroupID = (SELECT  ISNULL(MAX(ASPGROUPID),0) + 1 FROM CHCNPORTAL3_UDF_ASP_GROUPS)
				
				INSERT INTO CHCNPORTAL3_UDF_ASP_GROUPS (ASPGROUPID, COMPANY_ID, GROUP_DESCR, ASPSET, [STATUS], CREATEBY, CREATEDATE, LASTCHANGEBY, LASTCHANGEDATE)
					VALUES(@ASPGroupID, @CompanyID, @PackageDesc, 100, 1, @UserID, GETDATE(), @UserID, GETDATE())											

				COMMIT TRAN
				SET @RetValue = 'Successfully Inserted'
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
