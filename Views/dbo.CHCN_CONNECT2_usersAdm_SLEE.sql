SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE VIEW [dbo].[CHCN_CONNECT2_usersAdm_SLEE]
AS
SELECT TOP (100) PERCENT Companyid.CompanyID, Companyid.PropertyValue, Companyid.Seq, Companyid.PropertyCategory, V.VENDORID, V.VENDORNM, Companyid.UserID, 
                  Users.UserID AS UsersID_, Users.Username, Users.Email, Users.DisplayName AS UsersDisplayNm, Users.CreatedByUserID, CONVERT(VARCHAR, Users.CreatedOnDate, 
                  101) AS CreatedONDt, Users.LastModifiedByUserID, Users.LastModifiedOnDate, RN.RoleName, RN.DisplayName AS RoleNameDisplayNM, Users.FirstName, Users.LastName, 
                  Users.IsSuperUser, RN.UserID AS RoleUserid, RN.Username AS RoleUserName, RN.Email AS RoleEmail, RN.Status, Users.CreatedOnDate, 
                  Portal_DNN7.dbo.UserPortals.Authorised, dbo.CHCN_CONTACT_PHONE.UserPhoneNO, dbo.CHCNPORTAL_LocalAdmin.NPI, dbo.CHCNPORTAL_LocalAdmin.IsValidated, 
                  dbo.CHCNPORTAL_LocalAdmin.ActivatedDate, dbo.CHCNPORTAL_LocalAdmin.IsActivated
FROM     Portal_DNN7.dbo.vw_UserRoles AS RN INNER JOIN
                  Portal_DNN7.dbo.Users AS Users ON RN.UserID = Users.UserID LEFT OUTER JOIN
                  dbo.CHCNPORTAL_LocalAdmin ON Users.UserID = dbo.CHCNPORTAL_LocalAdmin.UserID LEFT OUTER JOIN
                  dbo.CHCN_CONTACT_PHONE ON Users.UserID = dbo.CHCN_CONTACT_PHONE.UserID LEFT OUTER JOIN
                  Portal_DNN7.dbo.UserPortals ON Users.UserID = Portal_DNN7.dbo.UserPortals.UserId LEFT OUTER JOIN
                  EZCAP65TEST.EZCAPDB.DBO.VEND_MASTERS_VS AS V RIGHT OUTER JOIN
                  Portal_DNN7.dbo._CHCN_CompanyID_V AS Companyid ON REPLACE(V.VENDORID, '-', '') = Companyid.PropertyValue ON Users.UserID = Companyid.UserID
GROUP BY Companyid.CompanyID, Companyid.PropertyValue, Companyid.Seq, Companyid.PropertyCategory, V.VENDORID, V.VENDORNM, Companyid.UserID, Users.UserID, 
                  Users.Username, Users.Email, Users.DisplayName, Users.CreatedByUserID, CONVERT(VARCHAR, Users.CreatedOnDate, 101), Users.LastModifiedByUserID, 
                  Users.LastModifiedOnDate, RN.RoleName, RN.DisplayName, Users.FirstName, Users.LastName, RN.UserID, RN.Username, RN.Email, RN.Status, Users.CreatedOnDate, 
                  Users.IsSuperUser, Portal_DNN7.dbo.UserPortals.Authorised, dbo.CHCN_CONTACT_PHONE.UserPhoneNO, dbo.CHCNPORTAL_LocalAdmin.NPI, 
                  dbo.CHCNPORTAL_LocalAdmin.ActivatedDate, dbo.CHCNPORTAL_LocalAdmin.IsValidated, dbo.CHCNPORTAL_LocalAdmin.IsActivated
HAVING (Companyid.CompanyID = N'CompanyID1')
ORDER BY RoleNameDisplayNM



GO
