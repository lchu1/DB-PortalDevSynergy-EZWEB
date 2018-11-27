SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- =============================================
-- Synergy 07/13/2016
-- Search for Local Admins
-- =============================================
CREATE PROCEDURE [dbo].[CHCNPortal3_GetLocalAdmins]

@Username VARCHAR(25),
@TaxID VARCHAR(9),
@NPI VARCHAR(10),
@ClinicName VARCHAR(30),
@AffiliatedUser VARCHAR(30)

AS
IF @Username IS NULL AND @TaxID IS NULL AND @NPI IS NULL AND @ClinicName IS NULL AND @AffiliatedUser IS NULL
	RETURN
ELSE
BEGIN
DECLARE @MasterPortalID INT = 9
DECLARE @NPIPropertyName VARCHAR(20) = N'CompanyNPI1'
DECLARE @TaxIDPropertyName VARCHAR(20) = N'CompanyID1'
DECLARE @CompayNamePropertyName VARCHAR(20) = N'CompanyName1'
DECLARE @LocalAdminRoleName VARCHAR(20) = N'Local Admin'
DECLARE @BillingDeptRoleName VARCHAR(50) = N'Dept_Billing'
DECLARE @MemberServicesDeptRoleName VARCHAR(50) = N'Dept_MemberServices'
DECLARE @AuthorizationReferralDeptRoleName VARCHAR(50) = N'Dept_AuthorizationReferral'
DECLARE @AffiliatedUserNPI VARCHAR(20) =
	(SELECT NPI.PropertyValue FROM [Portal_DNN7].[dbo].[Users]
	LEFT OUTER JOIN [Portal_DNN7].[dbo].[UserProfile] NPI ON Users.UserID = NPI.UserID
	AND NPI.PropertyDefinitionID = (SELECT PropertyDefinitionID FROM [Portal_DNN7].[dbo].[ProfilePropertyDefinition] WHERE PropertyName = @NPIPropertyName AND PortalID = @MasterPortalID)
	WHERE Users.Username = @AffiliatedUser)
DECLARE @AffiliatedUserTaxID VARCHAR(20) =
	(SELECT TXID.PropertyValue FROM [Portal_DNN7].[dbo].[Users]
	LEFT OUTER JOIN [Portal_DNN7].[dbo].[UserProfile] TXID ON Users.UserID = TXID.UserID
	AND TXID.PropertyDefinitionID = (SELECT PropertyDefinitionID FROM [Portal_DNN7].[dbo].[ProfilePropertyDefinition] WHERE PropertyName = @TaxIDPropertyName AND PortalID = @MasterPortalID)
	WHERE Users.Username = @AffiliatedUser)

SELECT DISTINCT
	Users.LastName,
	Users.FirstName,
	TXID.PropertyValue AS CompanyID,
  NPI.PropertyValue AS NPI,
	CN.PropertyValue AS CompanyName,
	Dept_Billing = CASE WHEN DeptBilling.RoleID IS NULL THEN '' ELSE 'X' END,
	Dept_MemberServices = CASE WHEN DeptMembServices.RoleID IS NULL THEN '' ELSE 'X' END,
	Dept_AuthorizationReferral = CASE WHEN DeptAuthReferral.RoleID IS NULL THEN '' ELSE 'X' END
FROM [Portal_DNN7].[dbo].[Users]

LEFT OUTER JOIN [Portal_DNN7].[dbo].[UserProfile] TXID ON Users.UserID = TXID.UserID
AND TXID.PropertyDefinitionID = (SELECT PropertyDefinitionID FROM [Portal_DNN7].[dbo].[ProfilePropertyDefinition] WHERE PropertyName = @TaxIDPropertyName AND PortalID = @MasterPortalID)

LEFT OUTER JOIN [Portal_DNN7].[dbo].[UserProfile] CN ON Users.UserID = CN.UserID
AND CN.PropertyDefinitionID = (SELECT PropertyDefinitionID FROM [Portal_DNN7].[dbo].[ProfilePropertyDefinition] WHERE PropertyName = @CompayNamePropertyName AND PortalID = @MasterPortalID)

LEFT OUTER JOIN [Portal_DNN7].[dbo].[UserProfile] NPI ON Users.UserID = NPI.UserID
AND NPI.PropertyDefinitionID = (SELECT PropertyDefinitionID FROM [Portal_DNN7].[dbo].[ProfilePropertyDefinition] WHERE PropertyName = @NPIPropertyName AND PortalID = @MasterPortalID)

LEFT OUTER JOIN [Portal_DNN7].[dbo].[UserRoles] LocalAdmin ON Users.UserID = LocalAdmin.UserID
AND LocalAdmin.RoleID = (SELECT RoleID from [Portal_DNN7].[dbo].[Roles] WHERE Roles.RoleID = LocalAdmin.RoleID and Roles.RoleName= @LocalAdminRoleName)

LEFT OUTER JOIN [Portal_DNN7].[dbo].[UserRoles] DeptBilling ON Users.UserID = DeptBilling.UserID
AND DeptBilling.RoleID = (SELECT RoleID from [Portal_DNN7].[dbo].[Roles] WHERE Roles.RoleID = DeptBilling.RoleID and Roles.RoleName= @BillingDeptRoleName)

LEFT OUTER JOIN [Portal_DNN7].[dbo].[UserRoles] DeptMembServices ON Users.UserID = DeptMembServices.UserID
AND DeptMembServices.RoleID = (SELECT RoleID from [Portal_DNN7].[dbo].[Roles] WHERE Roles.RoleID = DeptMembServices.RoleID and Roles.RoleName= @MemberServicesDeptRoleName)

LEFT OUTER JOIN [Portal_DNN7].[dbo].[UserRoles] DeptAuthReferral ON Users.UserID = DeptAuthReferral.UserID
AND DeptAuthReferral.RoleID = (SELECT RoleID from [Portal_DNN7].[dbo].[Roles] WHERE Roles.RoleID = DeptAuthReferral.RoleID and Roles.RoleName= @AuthorizationReferralDeptRoleName)

WHERE ((Users.Username = @Username) OR (Users.Username LIKE @Username + '%') OR (@Username IS NULL))
AND ((TXID.PropertyValue = @TaxID) OR (TXID.PropertyValue LIKE @TaxID + '%') OR (@TaxID IS NULL))
AND ((CN.PropertyValue = @ClinicName) OR (CN.PropertyValue LIKE '%' + @ClinicName + '%') OR (@ClinicName IS NULL))
AND ((NPI.PropertyValue = @NPI) OR (NPI.PropertyValue LIKE @NPI + '%') OR (@NPI IS NULL))
AND ((TXID.PropertyValue = @AffiliatedUserTaxID) AND (NPI.PropertyValue = @AffiliatedUserNPI) OR (@AffiliatedUser IS NULL))
AND (LocalAdmin.RoleID IS NOT NULL)
END



GO
