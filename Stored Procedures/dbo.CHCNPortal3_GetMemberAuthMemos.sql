SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO






CREATE PROCEDURE [dbo].[CHCNPortal3_GetMemberAuthMemos]

@AUTHNUMBER varchar(25)

AS

SELECT Memoline1,Memoline2,Memoline3,Memoline4
FROM  EZCAP65TEST.EZCAPDB.dbo.AUTH_MEMOFLDS_VS 
WHERE     (AUTHNO = @AUTHNUMBER)








GO
