SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE VIEW [dbo].[CHCN_AUTH_PORTAL]
AS
SELECT        EzcapAuth.AUTHNO AS EZ_AUTHNO, EzcapAuth.CREATEBY, PRODBEAST.*
FROM            EZCAP65TEST.EZCAPDB.dbo.AUTH_MASTERS_VS AS EzcapAuth LEFT OUTER JOIN
                         dbo.CHCNAuthReq_Master AS PRODBEAST ON EzcapAuth.AUTHNO = PRODBEAST.EZCAP_AuthNo



GO