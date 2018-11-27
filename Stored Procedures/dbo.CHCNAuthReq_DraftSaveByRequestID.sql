SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE PROCEDURE [dbo].[CHCNAuthReq_DraftSaveByRequestID]

@RequestID  VARCHAR(30),
@RequestType VARCHAR(1) = NULL,
@RetroReqReason VARCHAR(MAX) = NULL,
@ServiceStartDate DateTime = NULL,
@ServiceEndDate DateTime = NULL,
@AUTHPCP_OfficeContactName varchar(50)= NULL,
@AUTHPCP_OfficeContactPhone varchar(22)=NULL,
@AUTHPCP_OfficeContactFax varchar(22)=NULL,
@AUTHPCP_Company varchar(200) = NULL,
@AUTHPCP_Name varchar(50) = NULL,
@AUTHPCP_ProvID varchar(20) = NULL,
@AUTHPCP_KeyID uniqueidentifier = NULL,
@AUTHPCP_UnlistedName varchar(50) = NULL,
@AUTHPCP_Facility_ProvID varchar(20) = NULL,
@AUTHPCP_Facility_Prov_KeyID uniqueidentifier = NULL,
@MembID varchar(20) = NULL,
@Memb_KeyID uniqueidentifier = NULL,
@MembName varchar(25) = NULL,
@MembSex varchar(1) = NULL,
@Memb_OptName varchar(10) = NULL,
@PatID varchar(15) = NULL,
@NewBornDOB DateTime = NULL,
@RefToProvID varchar(20) = NULL,
@RefToProv_KeyID uniqueidentifier = NULL,
@RefToSpec varchar(3) = NULL,
@UnlistedRefToProvName varchar(50) = NULL,
@UnlistedRefToProvStreet varchar(50) = NULL,
@UnlistedRefToProvCity varchar(50) = NULL,
@UnlistedRefToProvState varchar(30) = NULL,
@RefToProvPhone varchar(20) = NULL,
@RefToProvFax varchar(20) = NULL,
@UnlistedRefToProvNPI varchar(10) = NULL,
@RefToName varchar(50) = NULL,
@RefToMedGroup varchar(100) = NULL,
@RefContract varchar(1) = NULL,
@RefToMembReq bit = NULL,
@RefToLanguage bit = NULL,
@RefToLocation bit = NULL,
@RefToContinuity bit = NULL,
@RefToOnlyProv bit = NULL,
@RefToOther varchar(500) = NULL,
@PlaceSvc_Code varchar(2) = NULL,
@PlaceSvc_Selected varchar(100) = NULL,
@Facility_ProvID varchar(20) = NULL,
@Facility_Prov_KeyID uniqueidentifier = NULL,
@FacilityName varchar(200) = NULL,
@UnlistedFacilityName varchar(200) = NULL,
@UnlistedFacilityStreet varchar(200) = NULL,
@UnlistedFacilityCity varchar(100) = NULL,
@UnlistedFacilityState varchar(100) = NULL,
@UnlistedFacilityPhone varchar(20) = NULL,
@UnlistedFacilityFax varchar(20) = NULL,
@UnlistedFacilityNPI varchar(10) = NULL,
@Notes_UserComment varchar(max) = NULL,
@Notes_ForEZCAP varchar(max) = NULL
AS

UPDATE [EZWEB].[dbo].[CHCNAuthReq_Master]

   SET 
      [RequestType] = @RequestType
      ,[RetroReqReason] = @RetroReqReason
      ,[ServiceStartDate] = @ServiceStartDate
      ,[ServiceEndDate] = @ServiceEndDate
      ,[AUTHPCP_OfficeContactName] = @AUTHPCP_OfficeContactName
	  ,[AUTHPCP_OfficeContactPhone] = @AUTHPCP_OfficeContactPhone
	  ,[AUTHPCP_OfficeContactFax] = @AUTHPCP_OfficeContactFax
      ,[AUTHPCP_Company] = @AUTHPCP_Company
      ,[AUTHPCP_Name] = @AUTHPCP_Name
      ,[AUTHPCP_ProvID] = @AUTHPCP_ProvID
      ,[AUTHPCP_KeyID] = @AUTHPCP_KeyID
      ,[AUTHPCP_UnlistedName] = @AUTHPCP_UnlistedName
      ,[AUTHPCP_Facility_ProvID] = @AUTHPCP_Facility_ProvID
      ,[AUTHPCP_Facility_Prov_KeyID] = @AUTHPCP_Facility_Prov_KeyID
      ,[MembID] = @MembID
      ,[Memb_Keyid] = @Memb_KeyID 
      ,[MembName] = @MembName
      ,[MembSex] = @MembSex
      ,[Memb_OptName] = @Memb_OptName
      ,[PatID] = @PatID
      ,[NewbornDOB] = @NewbornDOB
      ,[RefToProvID] = @RefToProvID
      ,[RefToProv_KeyID] = @RefToProv_KeyID 
      ,[RefToSpec] = @RefToSpec
      ,[UnlistedRefToProvName] = @UnlistedRefToProvName
      ,[UnlistedRefToProvStreet] = @UnlistedRefToProvStreet
      ,[UnlistedRefToProvCity] = @UnlistedRefToProvCity
      ,[UnlistedRefToProvState] = @UnlistedRefToProvState
      ,[RefToProvPhone] = @RefToProvPhone
      ,[RefToProvFax] = @RefToProvFax
      ,[UnlistedRefToProvNPI] = @UnlistedRefToProvNPI
      ,[RefToName] = @RefToName
      ,[RefToMedGroup] = @RefToMedGroup
      ,[RefContract] = @RefContract
      ,[RefToMembReq] = @RefToMembReq
      ,[RefToLanguage] = @RefToLanguage
      ,[RefToLocation] = @RefToLocation
      ,[RefToContinuity] = @RefToContinuity
      ,[RefToOnlyProv] = @RefToOnlyProv
      ,[RefToOther] = @RefToOther
      ,[PlaceSvc_Code] = @PlaceSvc_Code
      ,[PlaceSvc_Selected] = @PlaceSvc_Selected
      ,[Facility_ProvID] = @Facility_ProvID
      ,[Facility_Prov_KeyID] = @Facility_Prov_KeyID
      ,[FacilityName] = @FacilityName
      ,[UnlistedFacilityName] = @UnlistedFacilityName
      ,[UnlistedFacilityStreet] = @UnlistedFacilityStreet
      ,[UnlistedFacilityCity] = @UnlistedFacilityCity
      ,[UnlistedFacilityState] = @UnlistedFacilityState
      ,[UnlistedFacilityPhone] = @UnlistedFacilityPhone
      ,[UnlistedFacilityFax] = @UnlistedFacilityFax
      ,[UnlistedFacilityNPI] = @UnlistedFacilityNPI
      ,[Notes_UserComment] = @Notes_UserComment
      ,[Notes_ForEZCAP] = @Notes_ForEZCAP
      ,[LastAccessDate] = GetDate()
      ,[LastModifiedDate] = GetDate()
      /****
      ,[Attachment] = <Attachment, varchar(1),>
      ,[RequestStatus] = <RequestStatus, int,>
      ,[EZCAP_AuthNo] = <EZCAP_AuthNo, varchar(25),>
      ,[Notify] = <Notify, bit,>
      ,[StatusChange] = <StatusChange, int,>
      ,[NotifyDate] = <NotifyDate, datetime,>
      ,[PostDt] = <PostDt, datetime,>
      ,[DraftMode] = <DraftMode, bit,> **/
 WHERE RequestID=@RequestID


GO
