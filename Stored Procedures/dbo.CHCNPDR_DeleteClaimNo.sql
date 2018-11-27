SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







--SK 11/30/2016
CREATE  PROCEDURE [dbo].[CHCNPDR_DeleteClaimNo]

@RequestID VARCHAR(30), 
@ClaimNo VARCHAR(25),
@Sequence INT

AS

BEGIN

DELETE FROM CHCNPDR_ClaimMulti 
WHERE RequestID = @RequestID AND ClaimNo = @ClaimNo AND Sequence = @Sequence

END










GO
