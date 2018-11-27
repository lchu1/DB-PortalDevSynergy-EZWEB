SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







--SK 11/30/2016
CREATE PROCEDURE [dbo].[CHCNPDR_SaveDraft]

@RequestID  VARCHAR(30),
@UserID INT,
@ClaimNo VARCHAR(25),
@DisputeType VARCHAR(100),
@DisputeReason VARCHAR(MAX) = NULL,
@RetValue VARCHAR(200) OUTPUT

AS

BEGIN
	
	DECLARE @Memb_KeyID UNIQUEIDENTIFIER
	DECLARE @MembID VARCHAR(25)
	DECLARE	@Memb_LName VARCHAR(40)
	DECLARE	@Memb_FName VARCHAR(30)
	DECLARE	@ServiceDate DATETIME
	DECLARE @Rend_ProvID VARCHAR(25)
	DECLARE @Rend_Prov_KeyID UNIQUEIDENTIFIER
	DECLARE	@SpecialtyType VARCHAR(10)
	DECLARE	@ManagerID VARCHAR(10) = ''
	DECLARE	@Submitter_Company VARCHAR(200)
	DECLARE	@Submitter_ProvName VARCHAR(200)
	DECLARE	@Submitter_Phone VARCHAR(80)
	DECLARE	@Submitter_Street VARCHAR(80)
	DECLARE	@Submitter_City VARCHAR(80)
	DECLARE	@Submitter_State VARCHAR(80)
	DECLARE	@Submitter_Zip VARCHAR(10)

	--IF NULLIF(@RequestID,'') IS NULL OR @UserID IS NULL OR NULLIF(@ClaimNo,'') IS NULL OR NULLIF(@DisputeReason,'') IS NULL
	IF NULLIF(@RequestID,'') IS NULL OR @UserID IS NULL --Removed claimno & dispute reason from Synergy's request 1/4/2017
		BEGIN
			SET @RetValue = 'One of the required fields value missing'
			RETURN
		END

	--Get Claim Info 
	SELECT @MembID = m.MembID, @Memb_LName = m.LASTNM, @Memb_FName = m.FIRSTNM, @Memb_KeyID = p.Memb_KeyID, 
			@Rend_ProvID = p.ProvID, @Rend_Prov_KeyID = p.Prov_KeyID, @ServiceDate = p.DATEFROM
	FROM [EZCAP65TEST].[EZCAPDB].DBO.CLAIM_PMASTERS p (NOLOCK)  
		LEFT JOIN [EZCAP65TEST].[EZCAPDB].DBO.MEMB_COMPANY_V m (NOLOCK) ON p.MEMB_KEYID = m.MEMB_KEYID
	WHERE p.ClaimNo = @ClaimNo

	--Get Submitter Info
	DECLARE @MasterPortalID INT = 9
	DECLARE @CompanyIDPropertyName VARCHAR(20) = N'CompanyID'
	DECLARE @PhonePropertyName VARCHAR(20) = N'Telephone'
	DECLARE @AddressPropertyName VARCHAR(20) = N'Street'
	DECLARE @CityPropertyName VARCHAR(20) = N'City'
	DECLARE @StatePropertyName VARCHAR(20) = N'Region'
	DECLARE @ZipPropertyName VARCHAR(20) = N'PostalCode'	
/*
	SELECT @Submitter_Company = up_vendor.PropertyValue, @Submitter_ProvName = u.DisplayName, @Submitter_Phone = up_phone.PropertyValue, 
		@Submitter_Street = up_address.PropertyValue, @Submitter_City = up_city.PropertyValue, @Submitter_State = l.Value, @Submitter_Zip = up_zip.PropertyValue
	FROM Portal_DNN7.dbo.Users u INNER JOIN Portal_DNN7.dbo.UserProfile up ON u.UserID = up.UserID
		LEFT JOIN Portal_DNN7.dbo.UserProfile up_phone ON u.UserID = up_phone.UserID AND up_phone.PropertyDefinitionID 
			= (SELECT PropertyDefinitionID FROM [Portal_DNN7].[dbo].[ProfilePropertyDefinition] WHERE PropertyName = @PhonePropertyName AND PortalID = @MasterPortalID)
		LEFT JOIN Portal_DNN7.dbo.UserProfile up_vendor ON u.UserID = up_vendor.UserID AND up_vendor.PropertyDefinitionID 
			= (SELECT PropertyDefinitionID FROM [Portal_DNN7].[dbo].[ProfilePropertyDefinition] WHERE PropertyName = @CompanyIDPropertyName AND PortalID = @MasterPortalID)
		LEFT JOIN Portal_DNN7.dbo.UserProfile up_address ON u.UserID = up_address.UserID AND up_address.PropertyDefinitionID 
			= (SELECT PropertyDefinitionID FROM [Portal_DNN7].[dbo].[ProfilePropertyDefinition] WHERE PropertyName = @AddressPropertyName AND PortalID = @MasterPortalID)
		LEFT JOIN Portal_DNN7.dbo.UserProfile up_city ON u.UserID = up_city.UserID AND up_city.PropertyDefinitionID 
			= (SELECT PropertyDefinitionID FROM [Portal_DNN7].[dbo].[ProfilePropertyDefinition] WHERE PropertyName = @CityPropertyName AND PortalID = @MasterPortalID)
		LEFT JOIN Portal_DNN7.dbo.UserProfile up_state ON u.UserID = up_state.UserID AND up_state.PropertyDefinitionID 
			= (SELECT PropertyDefinitionID FROM [Portal_DNN7].[dbo].[ProfilePropertyDefinition] WHERE PropertyName = @StatePropertyName AND PortalID = @MasterPortalID)
		LEFT JOIN Portal_DNN7.dbo.Lists l ON l.ListName = @StatePropertyName AND l.EntryID = up_state.PropertyValue
		LEFT JOIN Portal_DNN7.dbo.UserProfile up_zip ON u.UserID = up_zip.UserID AND up_zip.PropertyDefinitionID 
			= (SELECT PropertyDefinitionID FROM [Portal_DNN7].[dbo].[ProfilePropertyDefinition] WHERE PropertyName = @ZipPropertyName AND PortalID = @MasterPortalID)
	WHERE u.UserID = @UserID
*/
	--2/27/2017 Dynamic query due to inconsistent value in UserProfile table for state value - digit(EntryID), 2 characters, or full state name
	--(Will update to dynamic query. For now make it static for urgent testing purpose)
	DECLARE @QUERY VARCHAR(MAX) = ''
	DECLARE @StateValue VARCHAR(20) = '', @StateStrLength INT = 0
	SELECT @StateValue = PropertyValue, @StateStrLength = LEN(PropertyValue) FROM Portal_DNN7.dbo.UserProfile WHERE PropertyDefinitionID = 40 AND userid = @UserID
PRINT '@StateValue - ' + @StateValue
PRINT '@StateStrLength - ' + CAST(@StateStrLength AS VARCHAR(10))
	--SET @QUERY = 'SELECT '

	IF ISNUMERIC(@StateValue) = 1
	BEGIN --Join List with EntryID
PRINT 'Join List with EntryID'
		SELECT @Submitter_Company = up_vendor.PropertyValue, @Submitter_ProvName = u.DisplayName, @Submitter_Phone = up_phone.PropertyValue, 
		@Submitter_Street = up_address.PropertyValue, @Submitter_City = up_city.PropertyValue, @Submitter_State = l.Value, @Submitter_Zip = up_zip.PropertyValue
		FROM Portal_DNN7.dbo.Users u INNER JOIN Portal_DNN7.dbo.UserProfile up ON u.UserID = up.UserID
			LEFT JOIN Portal_DNN7.dbo.UserProfile up_phone ON u.UserID = up_phone.UserID AND up_phone.PropertyDefinitionID 
				= (SELECT PropertyDefinitionID FROM [Portal_DNN7].[dbo].[ProfilePropertyDefinition] WHERE PropertyName = @PhonePropertyName AND PortalID = @MasterPortalID)
			LEFT JOIN Portal_DNN7.dbo.UserProfile up_vendor ON u.UserID = up_vendor.UserID AND up_vendor.PropertyDefinitionID 
				= (SELECT PropertyDefinitionID FROM [Portal_DNN7].[dbo].[ProfilePropertyDefinition] WHERE PropertyName = @CompanyIDPropertyName AND PortalID = @MasterPortalID)
			LEFT JOIN Portal_DNN7.dbo.UserProfile up_address ON u.UserID = up_address.UserID AND up_address.PropertyDefinitionID 
				= (SELECT PropertyDefinitionID FROM [Portal_DNN7].[dbo].[ProfilePropertyDefinition] WHERE PropertyName = @AddressPropertyName AND PortalID = @MasterPortalID)
			LEFT JOIN Portal_DNN7.dbo.UserProfile up_city ON u.UserID = up_city.UserID AND up_city.PropertyDefinitionID 
				= (SELECT PropertyDefinitionID FROM [Portal_DNN7].[dbo].[ProfilePropertyDefinition] WHERE PropertyName = @CityPropertyName AND PortalID = @MasterPortalID)
			LEFT JOIN Portal_DNN7.dbo.UserProfile up_state ON u.UserID = up_state.UserID AND up_state.PropertyDefinitionID 
				= (SELECT PropertyDefinitionID FROM [Portal_DNN7].[dbo].[ProfilePropertyDefinition] WHERE PropertyName = @StatePropertyName AND PortalID = @MasterPortalID)
			LEFT JOIN Portal_DNN7.dbo.Lists l ON l.ListName = @StatePropertyName AND l.EntryID = up_state.PropertyValue
			LEFT JOIN Portal_DNN7.dbo.UserProfile up_zip ON u.UserID = up_zip.UserID AND up_zip.PropertyDefinitionID 
				= (SELECT PropertyDefinitionID FROM [Portal_DNN7].[dbo].[ProfilePropertyDefinition] WHERE PropertyName = @ZipPropertyName AND PortalID = @MasterPortalID)
		WHERE u.UserID = @UserID
	END
	ELSE IF @StateStrLength > 2
	BEGIN --Join List with Text
PRINT 'Join List with Text'
		SELECT @Submitter_Company = up_vendor.PropertyValue, @Submitter_ProvName = u.DisplayName, @Submitter_Phone = up_phone.PropertyValue, 
		@Submitter_Street = up_address.PropertyValue, @Submitter_City = up_city.PropertyValue, @Submitter_State = l.Value, @Submitter_Zip = up_zip.PropertyValue
		FROM Portal_DNN7.dbo.Users u INNER JOIN Portal_DNN7.dbo.UserProfile up ON u.UserID = up.UserID
			LEFT JOIN Portal_DNN7.dbo.UserProfile up_phone ON u.UserID = up_phone.UserID AND up_phone.PropertyDefinitionID 
				= (SELECT PropertyDefinitionID FROM [Portal_DNN7].[dbo].[ProfilePropertyDefinition] WHERE PropertyName = @PhonePropertyName AND PortalID = @MasterPortalID)
			LEFT JOIN Portal_DNN7.dbo.UserProfile up_vendor ON u.UserID = up_vendor.UserID AND up_vendor.PropertyDefinitionID 
				= (SELECT PropertyDefinitionID FROM [Portal_DNN7].[dbo].[ProfilePropertyDefinition] WHERE PropertyName = @CompanyIDPropertyName AND PortalID = @MasterPortalID)
			LEFT JOIN Portal_DNN7.dbo.UserProfile up_address ON u.UserID = up_address.UserID AND up_address.PropertyDefinitionID 
				= (SELECT PropertyDefinitionID FROM [Portal_DNN7].[dbo].[ProfilePropertyDefinition] WHERE PropertyName = @AddressPropertyName AND PortalID = @MasterPortalID)
			LEFT JOIN Portal_DNN7.dbo.UserProfile up_city ON u.UserID = up_city.UserID AND up_city.PropertyDefinitionID 
				= (SELECT PropertyDefinitionID FROM [Portal_DNN7].[dbo].[ProfilePropertyDefinition] WHERE PropertyName = @CityPropertyName AND PortalID = @MasterPortalID)
			LEFT JOIN Portal_DNN7.dbo.UserProfile up_state ON u.UserID = up_state.UserID AND up_state.PropertyDefinitionID 
				= (SELECT PropertyDefinitionID FROM [Portal_DNN7].[dbo].[ProfilePropertyDefinition] WHERE PropertyName = @StatePropertyName AND PortalID = @MasterPortalID)
			LEFT JOIN Portal_DNN7.dbo.Lists l ON l.ListName = @StatePropertyName AND l.Text = up_state.PropertyValue
			LEFT JOIN Portal_DNN7.dbo.UserProfile up_zip ON u.UserID = up_zip.UserID AND up_zip.PropertyDefinitionID 
				= (SELECT PropertyDefinitionID FROM [Portal_DNN7].[dbo].[ProfilePropertyDefinition] WHERE PropertyName = @ZipPropertyName AND PortalID = @MasterPortalID)
		WHERE u.UserID = @UserID
	END
	ELSE
	BEGIN --Do not join with List but just use string 
PRINT 'Do not join with List but just use string'
		SELECT @Submitter_Company = up_vendor.PropertyValue, @Submitter_ProvName = u.DisplayName, @Submitter_Phone = up_phone.PropertyValue, 
		@Submitter_Street = up_address.PropertyValue, @Submitter_City = up_city.PropertyValue, @Submitter_State = up_state.PropertyValue, @Submitter_Zip = up_zip.PropertyValue
		FROM Portal_DNN7.dbo.Users u INNER JOIN Portal_DNN7.dbo.UserProfile up ON u.UserID = up.UserID
			LEFT JOIN Portal_DNN7.dbo.UserProfile up_phone ON u.UserID = up_phone.UserID AND up_phone.PropertyDefinitionID 
				= (SELECT PropertyDefinitionID FROM [Portal_DNN7].[dbo].[ProfilePropertyDefinition] WHERE PropertyName = @PhonePropertyName AND PortalID = @MasterPortalID)
			LEFT JOIN Portal_DNN7.dbo.UserProfile up_vendor ON u.UserID = up_vendor.UserID AND up_vendor.PropertyDefinitionID 
				= (SELECT PropertyDefinitionID FROM [Portal_DNN7].[dbo].[ProfilePropertyDefinition] WHERE PropertyName = @CompanyIDPropertyName AND PortalID = @MasterPortalID)
			LEFT JOIN Portal_DNN7.dbo.UserProfile up_address ON u.UserID = up_address.UserID AND up_address.PropertyDefinitionID 
				= (SELECT PropertyDefinitionID FROM [Portal_DNN7].[dbo].[ProfilePropertyDefinition] WHERE PropertyName = @AddressPropertyName AND PortalID = @MasterPortalID)
			LEFT JOIN Portal_DNN7.dbo.UserProfile up_city ON u.UserID = up_city.UserID AND up_city.PropertyDefinitionID 
				= (SELECT PropertyDefinitionID FROM [Portal_DNN7].[dbo].[ProfilePropertyDefinition] WHERE PropertyName = @CityPropertyName AND PortalID = @MasterPortalID)
			LEFT JOIN Portal_DNN7.dbo.UserProfile up_state ON u.UserID = up_state.UserID AND up_state.PropertyDefinitionID 
				= (SELECT PropertyDefinitionID FROM [Portal_DNN7].[dbo].[ProfilePropertyDefinition] WHERE PropertyName = @StatePropertyName AND PortalID = @MasterPortalID)			
			LEFT JOIN Portal_DNN7.dbo.UserProfile up_zip ON u.UserID = up_zip.UserID AND up_zip.PropertyDefinitionID 
				= (SELECT PropertyDefinitionID FROM [Portal_DNN7].[dbo].[ProfilePropertyDefinition] WHERE PropertyName = @ZipPropertyName AND PortalID = @MasterPortalID)
		WHERE u.UserID = @UserID
	END

	UPDATE [dbo].[CHCNPDR_Master]
	   SET [ClaimNo] = @ClaimNo
		  ,[MembID] = @MembID
		  ,[Memb_LName] = @Memb_LName
		  ,[Memb_FName] = @Memb_FName
		  ,[Memb_KeyID] = @Memb_KeyID
		  ,[ServiceDate] = @ServiceDate
		  ,[Rend_ProvID] = @Rend_ProvID
		  ,[Rend_Prov_KeyID] = @Rend_Prov_KeyID
		  ,[SpecialtyType] = @SpecialtyType		  
		  ,[ManagerID] = @ManagerID
		  ,[Submitter_Company] = @Submitter_Company
		  ,[Submitter_ProvName] = @Submitter_ProvName
		  ,[Submitter_Phone] = @Submitter_Phone
		  ,[Submitter_Street] = @Submitter_Street
		  ,[Submitter_City] = @Submitter_City
		  ,[Submitter_State] = @Submitter_State
		  ,[Submitter_Zip] = @Submitter_Zip
		  ,[DisputeType] = @DisputeType
		  ,[DisputeReason] = @DisputeReason      		  
		  ,[LastChangeBy] = @UserID
		  ,[LastChangeDate] = GETDATE()
		  ,[DraftMode] = 1
	 WHERE RequestID=@RequestID
END






GO
