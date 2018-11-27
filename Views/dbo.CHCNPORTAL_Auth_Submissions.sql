SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE VIEW [dbo].[CHCNPORTAL_Auth_Submissions]
AS
SELECT DISTINCT 
                      AM.RequestID, AM.UserID, AM.Email, AM.RequestType, AM.CHCNReq, AM.RequestDate, AM.AuthFromDate, AM.AuthToDate, CASE WHEN NULLIF (AM.ReqProvID, ' ') 
                      IS NULL THEN AM.UNLISTEDPROV ELSE AM.ReqName END AS ReqName, AM.ReqPhone, AM.ReqFax, AM.ReqFacility, AM.ReqProvName, AM.ReqProvID, 
                      AM.Req_Prov_KeyID, AM.ReqSpec, AM.UnlistedProv, AM.MembID, AM.Memb_Keyid, AM.MembName, AM.MembDOB, AM.BenOPT, AM.PatID, AM.HPCode, 
                      AM.RefToProvID, AM.RefTo_Prov_KeyID, AM.RefToSpec, AM.RefToSpecialty, AM.RefToName, AM.RefToCompanyID, AM.RefToCompanyName, AM.RefContract, 
                      AM.RefToMembReq, AM.RefToLanguage, AM.RefToLocation, AM.RefToContinuity, AM.RefToOnlyProv, AM.RefToOther, AM.SerType, AM.SerConsult, AM.SerTreatment, 
                      AM.SerInpAdm, AM.SerOutSurgHosp, AM.SerDME, AM.SerOutSurgFree, AM.SerHHC, CAST(AM.SerHHCDesc AS varchar(MAX)) AS SerHHCDesc, AM.SerDiagTest, 
                      AM.SerQty, AM.SerPOS, CAST(AM.SvcClinicalDesc AS varchar(MAX)) AS SvcClinicalDesc, AM.FaxRecDt, AM.AuthNo, AD.TBLROWID, AD.PROCCODE, AD.DESCRIPTION, 
                      AD.QTY, AD.MODIF, AD.DX1, AD.DXDESC1, AD.DX2, AD.DXDESC2, AD.DX3, AD.DXDESC3, AD.DX4, AD.DXDESC4, AD.DX5, AD.DXDESC5, AD.DX6, AD.DXDESC6, 
                      AD.DX7, AD.DXDESC7, AD.DX8, AD.DXDESC8, AD.DX9, AD.DXDESC9, AD.DX10, AD.DXDESC10, AD.DX11, AD.DXDESC11, AD.DX12, AD.DXDESC12, 
                      AT.DESCRIPTION AS SERVICETYPE
FROM         dbo.CHCNPORTAL_AuthReq_Master AS AM LEFT OUTER JOIN
                      dbo.CHCNPORTAL_AuthServiceTypes AS AT ON AM.SerType = AT.ID LEFT OUTER JOIN
                      EZCAP65TEST.EZCAPDB.DBO.CHCNPORTAL_AUTH_DIAGS_VS AS AD ON AM.AuthNo = AD.AUTHNO
WHERE     (AM.AuthNo IS NOT NULL) AND (AM.Submitted = 1)



GO
