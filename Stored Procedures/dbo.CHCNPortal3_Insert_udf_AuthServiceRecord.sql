SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- =============================================
-- SK.5/25/2016
-- Create a service record for a Service Bundle
-- =============================================
CREATE PROCEDURE [dbo].[CHCNPortal3_Insert_udf_AuthServiceRecord]

	@UserID VARCHAR(5),
	@ASPGroupID INT,
	@SVCCode VARCHAR(25),
	@Qty VARCHAR(25),
	@Modif VARCHAR(25),
	@RetValue VARCHAR(200) = '' OUTPUT
	
AS
BEGIN
	
	SET NOCOUNT ON;	
	
	SET @SVCCode = LTRIM(RTRIM(@SVCCode))
	
	BEGIN TRY
	BEGIN TRAN
		
		IF @UserID IS NULL OR @ASPGroupID IS NULL OR @SVCCode IS NULL
			BEGIN
				SET @RetValue = 'No Service record Insertion was made because of missing required values.'
				RETURN
			END		
		ELSE
			BEGIN									

				INSERT INTO CHCNPORTAL3_UDF_ASP_TABLES (ASPGROUPID, FROM_DATE, PHCODE, AUTH_SVCCODE, COMMON_ID, QTY, MODIF, CREATEBY, CREATEDATE, LASTCHANGEBY, LASTCHANGEDATE)
				SELECT @ASPGROUPID, CAST(CAST(GETDATE() AS DATE) AS DATETIME), 'P', @SVCCode, 
					(SELECT TOP 1 COMMON_ID FROM [EZWEB].[DBO].[CHCNAUTHREQ_CPT] WHERE LTRIM(RTRIM(PROCCODE)) = @SVCCode),
					@Qty, @Modif, @UserID, GETDATE(), @UserID, GETDATE()				

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
