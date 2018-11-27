SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- =============================================
-- SK.6/12/2017
-- Return the boolean value whether the claim has been disputed once in the past or not. 
-- =============================================
CREATE PROCEDURE [dbo].[CHCNPDR_IsClaimDisputedOnEZCAP]
	@USERID INT,
	@CLAIMNO VARCHAR(25),
	@RetValue BIT OUTPUT --True or False
AS
BEGIN
	
	SET NOCOUNT ON;

    DECLARE @COMPANYIDLIST varchar(150)	
	SET @COMPANYIDLIST = (SELECT DISTINCT REPLACE([Portal_DNN7].[dbo].CompanyIDList(@USERID),'-',''))			

	IF EXISTS (SELECT * FROM EZCAP65TEST.EZCAPDB.dbo.CHCNPORTAL_CASEMASTER_VS  WITH (NOLOCK)
				WHERE  (CHARINDEX(COMPANY_ID,@CompanyIDList)>0 or CHARINDEX(REPLACE(VENDOR,'-',''), @CompanyIDList)>0) 
					AND	CASETYPE IN ('A1','C1','D1','P1','R1','NC') AND CLAIMNO = @CLAIMNO)
		BEGIN
			SET @RetValue = 1
		END
	ELSE
		BEGIN
			SET @RetValue = 0
		END	
	
END


GO
