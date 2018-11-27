CREATE TABLE [dbo].[_CHCN_Demo_AuthRequest]
(
[ID] [int] NOT NULL,
[UrgentReq] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CHCNReq] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RequestDate] [datetime] NOT NULL,
[ReqName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ReqPhone] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ReqFax] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ReqFacility] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ReqProvider] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PatLN] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PatFN] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PatDOB] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PatAddress] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PatCity] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PatPhone] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PatHP] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PatID] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[RefToSpec] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RefToName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[RefToCompany] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[RefToAddress] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[RefToCity] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[RefToPhone] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[RefToFax] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SerConsult] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SerVisit] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SerVisitQty] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SerInPatient] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SerOutSurgery] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SerDME] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SerHomeCare] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SerCPTCode] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SerCPTDescr] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SerClinical] [varchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AncDXDescr] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AncICD9] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AncTreatment] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AncDOS] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AncFacility] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AncOtherServices] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AncProvName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO