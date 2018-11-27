SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CHCN_CONNECTDATA_SLEE]

AS
BEGIN

SELECT dbo.CHCN_CONNECT2_usersAdm_SLEE.UserID, dbo.CHCN_CONNECT2_usersAdm_SLEE.Username AS Expr1, dbo.CHCN_CONNECT2_usersAdm_SLEE.Email, 
                  dbo.CHCN_CONNECT2_usersAdm_SLEE.UsersDisplayNm, dbo.CHCN_CONNECT2_usersAdm_SLEE.RoleName, 
                  dbo.CHCN_CONNECT2_usersAdm_SLEE.RoleNameDisplayNM, dbo.CHCN_CONNECT2_usersAdm_SLEE.FirstName, dbo.CHCN_CONNECT2_usersAdm_SLEE.LastName, 
                  dbo.CHCN_CONNECT2_usersAdm_SLEE.RoleUserid, dbo.CHCN_CONNECT2_usersAdm_SLEE.RoleUserName, dbo.CHCN_CONNECT2_usersAdm_SLEE.RoleEmail, 
                  dbo.CHCN_CONNECT2_usersAdm_SLEE.Status AS Expr2, dbo.CHCN_CONNECT2_usersAdm_SLEE.CreatedOnDate, dbo.CHCN_CONNECT2_usersAdm_SLEE.UserPhoneNO, 
                  dbo.CHCN_CONNECT2_usersAdm_SLEE.NPI, dbo.CHCN_CONNECT2_usersAdm_SLEE.ActivatedDate, dbo.CHCN_CONNECT2_usersAdm_SLEE.IsActivated, 
                  dbo.Chcn_Connect_Beta.*
FROM     dbo.CHCN_CONNECT2_usersAdm_SLEE LEFT OUTER JOIN
                  dbo.Chcn_Connect_Beta ON dbo.CHCN_CONNECT2_usersAdm_SLEE.UserID = dbo.Chcn_Connect_Beta.ConUserid

END

GO
