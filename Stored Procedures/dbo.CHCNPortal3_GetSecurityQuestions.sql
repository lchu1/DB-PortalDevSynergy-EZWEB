SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [dbo].[CHCNPortal3_GetSecurityQuestions]

AS 

SELECT [SecurityQuestion]
      ,[Ordering]
FROM [Portal_DNN7].[dbo].[CHCNPortal_SecurityQuestions]






GO
