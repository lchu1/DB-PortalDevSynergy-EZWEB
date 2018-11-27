SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- =============================================
-- Author: Synergy
-- Description Updates the CPT Temp Table Entry
-- =============================================
CREATE PROCEDURE [dbo].[CHCNPortal3_UpdateAuthCPTTemp] 

@ID VARCHAR(20),
@Qty INT

AS
	
BEGIN	
	UPDATE CHCNAuthReq_CPT_Temp
	SET Qty = @Qty
	WHERE ID = @ID
	
	RETURN 1
END


GO
