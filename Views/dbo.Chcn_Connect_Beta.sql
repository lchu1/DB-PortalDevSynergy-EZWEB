SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE VIEW [dbo].[Chcn_Connect_Beta]
AS
SELECT        'BETA' AS CBETA, Con.RequestID, Con.AUTHPCP_OfficeContactName AS ConnectContactNM, Con.AUTHPCP_OfficeContactPhone AS ConnectContactPH, AM.AUTHNO, 
                         AM.STATUS, AM.PRIORITYSTATUS, AM.PLACESVC, AM.MEMBID, AM.MEMBNAME, AM.OPT, AM.REQDATE, AM.AUTHDATE, AM.EXPRDATE, AM.AUTHPCP, 
                         PVI.VENDOR AS AuthPCPVendID, VM.VENDORNM AS AuthPCPVendNM, AM.REQPROV, VMreqed.VENDORNM AS ReqedVendorNM, PVI.DEFAULT_YN, 
                         CONVERT(varchar, UN.UserNo) AS User_no, UN.UserName, GETDATE() AS Currentdt, Con.UserID AS ConUserid, 
                         dbo.CHCNPORTAL_LocalAdmin.UserID AS ConAdmUserid, dbo.CHCNPORTAL_LocalAdmin.TaxID AS ConAdmTaxid, 
                         dbo.CHCNPORTAL_LocalAdmin.NPI AS ConAdmNPI, dbo.CHCNPORTAL_LocalAdmin.EnterDate AS ConAdmEnterDate, AD.PROCCODE, AD.DESCR
FROM            EZCAP65TEST.EZCAPDB.dbo.VEND_MASTERS_V AS VMreqed RIGHT OUTER JOIN
                         EZCAP65TEST.EZCAPDB.dbo.AUTH_MASTERS_V AS AM ON VMreqed.VENDORID = AM.VENDOR LEFT OUTER JOIN
                         EZCAP65TEST.EZCAPDB.dbo.PROV_COMPANY_V AS PC INNER JOIN
                         EZCAP65TEST.EZCAPDB.dbo.PROV_VENDINFO_V AS PVI ON PC.PROV_KEYID = PVI.PROV_KEYID INNER JOIN
                         EZCAP65TEST.EZCAPDB.dbo.VEND_MASTERS_V AS VM ON PVI.VENDOR = VM.VENDORID ON AM.AUTHPCP = PC.PROVID RIGHT OUTER JOIN
                         dbo.CHCNAuthReq_Master AS Con ON AM.AUTHNO = Con.EZCAP_AuthNo LEFT OUTER JOIN
                         dbo.CHCNPORTAL_LocalAdmin ON Con.UserID = dbo.CHCNPORTAL_LocalAdmin.UserID LEFT OUTER JOIN
                         EZCAP65TEST.EZCAPDB.dbo.USER_NAMES_V AS UN ON UN.UserNo = AM.CREATEBY LEFT OUTER JOIN
                         EZCAP65TEST.EZCAPDB.DBO.AUTH_DETAILS_VS AS AD ON AD.AUTHNO = AM.AUTHNO
WHERE        (PVI.DEFAULT_YN = 1) OR
                         (PVI.DEFAULT_YN IS NULL)



GO
