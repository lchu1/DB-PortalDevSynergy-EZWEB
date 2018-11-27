SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CHCNAuthReq_DraftDiscardByRequestID] 
	@RequestID  VARCHAR(30)

AS

UPDATE CHCNAuthReq_Master
SET DraftMode = 0
WHERE RequestID=@RequestID



GO
