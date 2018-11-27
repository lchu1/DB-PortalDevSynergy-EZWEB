CREATE TABLE [dbo].[CHCNAuthReq_Master]
(
[RequestID] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[UserID] [nchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Email] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RequestType] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RetroReqReason] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RequestDate] [datetime] NULL,
[ServiceStartDate] [datetime] NULL,
[ServiceEndDate] [datetime] NULL,
[AUTHPCP_OfficeContactName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AUTHPCP_OfficeContactPhone] [varchar] (22) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AUTHPCP_OfficeContactFax] [varchar] (22) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AUTHPCP_Company] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AUTHPCP_Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AUTHPCP_ProvID] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AUTHPCP_KeyID] [uniqueidentifier] NULL,
[AUTHPCP_UnlistedName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AuthPCP_Facility_ProvID] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AuthPCP_Facility_Prov_KeyID] [uniqueidentifier] NULL,
[MembID] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Memb_Keyid] [uniqueidentifier] NULL,
[MembName] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MembSex] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Memb_OptName] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PatID] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NewbornDOB] [datetime] NULL,
[RefToProvID] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RefToProv_KeyID] [uniqueidentifier] NULL,
[RefToSpec] [varchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RefToSpecialty] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RefToName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RefToMedGroup] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UnlistedRefToProvName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UnlistedRefToProvStreet] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UnlistedRefToProvCity] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UnlistedRefToProvState] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RefToProvPhone] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RefToProvFax] [varchar] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UnlistedRefToProvNPI] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RefContract] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RefToMembReq] [bit] NULL,
[RefToLanguage] [bit] NULL,
[RefToLocation] [bit] NULL,
[RefToContinuity] [bit] NULL,
[RefToOnlyProv] [bit] NULL,
[RefToOther] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PlaceSvc_Code] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PlaceSvc_Selected] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Facility_ProvID] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Facility_Prov_KeyID] [uniqueidentifier] NULL,
[FacilityName] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UnlistedFacilityName] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UnlistedFacilityStreet] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UnlistedFacilityCity] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UnlistedFacilityState] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UnlistedFacilityPhone] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UnlistedFacilityFax] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UnlistedFacilityNPI] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Attachment] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Notes_UserComment] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Notes_ForEZCAP] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RequestStatus] [int] NULL,
[EZCAP_AuthNo] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Notify] [bit] NULL,
[StatusChange] [int] NULL,
[NotifyDate] [datetime] NULL,
[PostDt] [datetime] NULL,
[LastAccessDate] [datetime] NULL,
[LastModifiedDate] [datetime] NULL,
[DraftMode] [bit] NULL CONSTRAINT [DF_CHCNAuthReq_Master_DraftMode] DEFAULT ((1)),
[CreateDate] [datetime] NULL
) ON [PRIMARY]
GO