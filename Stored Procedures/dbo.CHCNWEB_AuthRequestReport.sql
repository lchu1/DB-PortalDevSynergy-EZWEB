SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO













CREATE           PROCEDURE [dbo].[CHCNWEB_AuthRequestReport]

@REQDATE datetime

As

SELECT DISTINCT 
                      A.ID, CASE WHEN UrgentReq <> 1 THEN 'NO' ELSE 'YES' END AS UrgentReq, CASE WHEN CHCNReq <> 1 THEN 'NO' ELSE 'YES' END AS CHCNReq, 
                      A.RequestDate, A.ReqName, A.ReqPhone, A.ReqFax, A.ReqFacility, A.ReqProvider, A.PatLN, A.PatFN, A.PatDOB, A.PatAddress, A.PatCity, A.PatPhone, 
                      A.PatHP, A.PatID, A.RefToSpec, A.RefToName, A.RefToCompany, A.RefToAddress, A.RefToCity, A.RefToPhone, A.RefToFax, 
                      CASE WHEN SerConsult <> 1 THEN 'NO' ELSE 'YES' END AS SerConsult, CASE WHEN SerVisit <> 1 THEN 'NO' ELSE 'YES' END AS SerVisit, 
                      A.SerVisitQty, CASE WHEN SerInPatient <> 1 THEN 'NO' ELSE 'YES' END AS SerInPatient, 
                      CASE WHEN SerOutSurgery <> 1 THEN 'NO' ELSE 'YES' END AS SerOutSurgery, A.SerDME, A.SerHomeCare, A.SerCPTCode, A.SerCPTDescr, 
                      A.SerClinical, A.AncDXDescr, A.AncICD9, A.AncTreatment, A.AncDOS, A.AncFacility, A.AncOtherServices, A.AncProvName, P.PROVID AS EZ_PROVID, 
                      M.MEMBID AS EZ_MEMBID
FROM         CHCNWEB_CHCN_PCPS AS P LEFT OUTER JOIN
                      CHCNWEB_CHCN_CLINICS AS C ON P.SITE = C.SITE RIGHT OUTER JOIN
                      CHCNWeb_Auth_Request AS A ON C.NAME = A.ReqFacility AND A.ReqFacility = C.NAME AND 
                      P.REVFN = A.ReqProvider LEFT OUTER JOIN
                      CHCNWEB_PATID_REF AS M ON A.PatID = M.PATID
WHERE CONVERT(char(10),A.RequestDate,101) = @REQDATE











GO
