SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





CREATE PROCEDURE [dbo].[CHCNAuthReq_GetAllSelectedICDCPTCombo]

@RequestID varchar(20)

as

SELECT DiagCode, DIAGREFNO, ProcCode, modif 
FROM CHCNAuthReq_CPT_Temp CPT left join CHCNAuthReq_ICD_Temp ICD on CPT.RequestID=ICD.RequestID
where CPT.requestid=@RequestID AND DIAGREFNO <=3





GO
