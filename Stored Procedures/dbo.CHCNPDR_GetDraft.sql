SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







CREATE PROCEDURE [dbo].[CHCNPDR_GetDraft]

@RequestID  VARCHAR(30)

AS

SELECT *
FROM  CHCNPDR_Master
WHERE RequestID=@RequestID








GO