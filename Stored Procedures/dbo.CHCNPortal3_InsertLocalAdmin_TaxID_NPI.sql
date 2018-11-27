SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- =============================================
-- SK.01/08/2016
-- Store Local Admin TaxID and NPI combination
-- Stripping out hyphens from TaxID SK.5/17/2016
-- =============================================
CREATE  PROCEDURE [dbo].[CHCNPortal3_InsertLocalAdmin_TaxID_NPI]
	
	@UserID VARCHAR(5),
	@TaxID VARCHAR(11),
	@NPI VARCHAR(25),
	@IsValidated BIT 
	
AS
IF @TaxID IS NULL OR @NPI IS NULL 
	RETURN
ELSE
BEGIN	

    INSERT INTO CHCNPORTAL_LocalAdmin (UserID, TaxID, NPI, IsValidated)
	VALUES (@UserID, REPLACE(@TaxID,'-',''), @NPI, @IsValidated)
	
END



GO
