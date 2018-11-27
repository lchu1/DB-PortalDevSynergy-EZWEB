SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- =============================================
-- Synergy 07/25/2016
-- Retrieve a single user from DNN
-- =============================================
CREATE PROCEDURE [dbo].[CHCNPORTAL3_GetUserProfile]
@UserID int,
@PortalID int
AS
BEGIN
		SELECT DISTINCT [Portal_DNN7].[dbo].[Users].UserID, [Portal_DNN7].[dbo].[Users].Username, [Portal_DNN7].[dbo].[Users].LastName, [Portal_DNN7].[dbo].[Users].FirstName, [Portal_DNN7].[dbo].[Users].Email,
			CONVERT(char(10),[Portal_DNN7].[dbo].[UserPortals].CreatedDate,101) AS CreateDate,
			Authorized = CASE WHEN [Portal_DNN7].[dbo].[UserPortals].Authorised = '1' THEN 'YES' ELSE 'NO' END,
			Claims = CASE WHEN Claims.RoleID is null THEN '' ELSE 'X' END,
			Auths = CASE WHEN Auths.RoleID is null THEN '' ELSE 'X' END,
			Elig = CASE WHEN Elig.RoleID is null THEN '' ELSE 'X' END,
			EOB = CASE WHEN EOB.RoleID is null THEN '' ELSE 'X' END,
			AuthReq = CASE WHEN AuthReq.RoleID is null THEN '' ELSE 'X' END,
			Cap = CASE WHEN CapDown.RoleID is null THEN '' ELSE 'X' END,
			EligDownload = CASE WHEN Edown.RoleID is null THEN '' ELSE 'X' END,
			Document = CASE WHEN Document.RoleID is null THEN '' ELSE 'X' END,
			MemberRetention = CASE WHEN MemberRetention.RoleID is null THEN '' ELSE 'X' END,
			Disputes = CASE WHEN Disputes.RoleID is null THEN '' ELSE 'X' END,

			Dept_Billing = CASE WHEN DeptBilling.RoleID is null THEN '' ELSE 'X' END,
			Dept_MemberServices = CASE WHEN DeptMembServices.RoleID is null THEN '' ELSE 'X' END,
			Dept_AuthorizationReferral = CASE WHEN DeptAuthReferral.RoleID is null THEN '' ELSE 'X' END
		FROM    [Portal_DNN7].[dbo].[Users] LEFT OUTER JOIN
				[Portal_DNN7].[dbo].[UserRoles] Elig ON [Portal_DNN7].[dbo].[Users].UserID = Elig.UserID AND Elig.RoleID =
						(SELECT RoleID from [Portal_DNN7].[dbo].[Roles] R1 WHERE R1.RoleID=Elig.RoleID and R1.RoleName='MSO Eligibility' and PortalID=@PortalID) LEFT OUTER JOIN
				[Portal_DNN7].[dbo].[UserRoles] Claims ON [Portal_DNN7].[dbo].[Users].UserID = Claims.UserID AND Claims.RoleID =
						(SELECT RoleID from [Portal_DNN7].[dbo].[Roles] R2 WHERE R2.RoleID=Claims.RoleID and R2.RoleName='MSO Claims' and PortalID=@PortalID) LEFT OUTER JOIN
				[Portal_DNN7].[dbo].[UserRoles] Auths ON [Portal_DNN7].[dbo].[Users].UserID = Auths.UserID AND Auths.RoleID =
						(SELECT RoleID from [Portal_DNN7].[dbo].[Roles] R3 WHERE R3.RoleID=Auths.RoleID and R3.RoleName='MSO Auth Search' and PortalID=@PortalID) LEFT OUTER JOIN
				[Portal_DNN7].[dbo].[UserRoles] EOB ON [Portal_DNN7].[dbo].[Users].UserID = EOB.UserID AND EOB.RoleID =
						(SELECT RoleID from [Portal_DNN7].[dbo].[Roles] R4 WHERE R4.RoleID=EOB.RoleID and R4.RoleName='EOB Download' and PortalID=@PortalID) LEFT OUTER JOIN
				[Portal_DNN7].[dbo].[UserRoles] AuthReq ON [Portal_DNN7].[dbo].[Users].UserID = AuthReq.UserID AND AuthReq.RoleID =
						(SELECT RoleID from [Portal_DNN7].[dbo].[Roles] R5 WHERE R5.RoleID=AuthReq.RoleID and R5.RoleName='MSO Auth Submit' and PortalID=@PortalID) LEFT OUTER JOIN
				[Portal_DNN7].[dbo].[UserRoles] LocalAdmin ON [Portal_DNN7].[dbo].[Users].UserID = LocalAdmin.UserID AND LocalAdmin.RoleID =
						(SELECT RoleID from [Portal_DNN7].[dbo].[Roles] R6 WHERE R6.RoleID=LocalAdmin.RoleID and R6.RoleName='Local Admin' and PortalID=@PortalID) LEFT OUTER JOIN
				[Portal_DNN7].[dbo].[UserRoles] CapDown ON [Portal_DNN7].[dbo].[Users].UserID = CapDown.UserID AND CapDown.RoleID =
						(SELECT RoleID from [Portal_DNN7].[dbo].[Roles] R7 WHERE R7.RoleID=CapDown.RoleID and R7.RoleName='Capitation Download' and PortalID=@PortalID) LEFT OUTER JOIN
				[Portal_DNN7].[dbo].[UserRoles] EDown ON [Portal_DNN7].[dbo].[Users].UserID = EDown.UserID AND EDown.RoleID =
						(SELECT RoleID from [Portal_DNN7].[dbo].[Roles] R8 WHERE R8.RoleID=EDown.RoleID and R8.RoleName='Eligibility Download' and PortalID=@PortalID) LEFT OUTER JOIN
				[Portal_DNN7].[dbo].[UserRoles] Document ON [Portal_DNN7].[dbo].[Users].UserID = Document.UserID AND Document.RoleID =
						(SELECT RoleID from [Portal_DNN7].[dbo].[Roles] R9 WHERE R9.RoleID=Document.RoleID and R9.RoleName='Document Exchange' and PortalID=@PortalID) LEFT OUTER JOIN
				[Portal_DNN7].[dbo].[UserRoles] MemberRetention ON [Portal_DNN7].[dbo].[Users].UserID = MemberRetention.UserID AND MemberRetention.RoleID =
						(SELECT RoleID from [Portal_DNN7].[dbo].[Roles] R10 WHERE R10.RoleID=MemberRetention.RoleID and R10.RoleName='Membership Retention' and PortalID=@PortalID) LEFT OUTER JOIN

				[Portal_DNN7].[dbo].[UserRoles] Disputes ON [Portal_DNN7].[dbo].[Users].UserID = Disputes.UserID AND Disputes.RoleID =
						(SELECT RoleID from [Portal_DNN7].[dbo].[Roles] R10 WHERE R10.RoleID=Disputes.RoleID and R10.RoleName='ePDR' and PortalID=@PortalID) LEFT OUTER JOIN

				[Portal_DNN7].[dbo].[UserRoles] DeptBilling ON [Portal_DNN7].[dbo].[Users].UserID = DeptBilling.UserID AND DeptBilling.RoleID =
					(SELECT RoleID from [Portal_DNN7].[dbo].[Roles] R11 WHERE R11.RoleID=DeptBilling.RoleID and R11.RoleName='Dept_Billing') LEFT OUTER JOIN
				[Portal_DNN7].[dbo].[UserRoles] DeptMembServices ON [Portal_DNN7].[dbo].[Users].UserID = DeptMembServices.UserID AND DeptMembServices.RoleID =
					(SELECT RoleID from [Portal_DNN7].[dbo].[Roles] R12 WHERE R12.RoleID=DeptMembServices.RoleID and R12.RoleName='Dept_MemberServices') LEFT OUTER JOIN
				[Portal_DNN7].[dbo].[UserRoles] DeptAuthReferral ON [Portal_DNN7].[dbo].[Users].UserID = DeptAuthReferral.UserID AND DeptAuthReferral.RoleID =
					(SELECT RoleID from [Portal_DNN7].[dbo].[Roles] R13 WHERE R13.RoleID=DeptAuthReferral.RoleID and R13.RoleName='Dept_AuthorizationReferral') LEFT OUTER JOIN

				[Portal_DNN7].[dbo].[UserPortals] ON [Portal_DNN7].[dbo].[Users].UserID = [Portal_DNN7].[dbo].[UserPortals].UserId LEFT OUTER JOIN
				[Portal_DNN7].[dbo].[_CHCN_COMPANY_VS] ON [Portal_DNN7].[dbo].[Users].UserID = [Portal_DNN7].[dbo].[_CHCN_COMPANY_VS].UserID LEFT OUTER JOIN
				[Portal_DNN7].[dbo].[UserProfile] ON [Portal_DNN7].[dbo].[Users].UserID=UserProfile.UserID LEFT OUTER JOIN
				[Portal_DNN7].[dbo].[ProfilePropertyDefinition] PPD on UserProfile.PropertyDefinitionID = PPD.PropertyDefinitionID
		WHERE     [Portal_DNN7].[dbo].[_CHCN_COMPANY_VS].UserID = @UserID
	END



GO
