SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




create PROCEDURE [dbo].[CHCNPORTAL_MAKE_CLAIM_IMAGES]

AS

-- RUNS NIGHTLY, 01/22/2014, CTA
	
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CHCNPORTAL_CLAIM_IMAGES]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[CHCNPORTAL_CLAIM_IMAGES]

SELECT CLAIMNO,IMAGECLAIM
INTO DBO.CHCNPORTAL_CLAIM_IMAGES
FROM [EZCAP65TEST].[EZCAPDB].dbo.CHCNEDI_CLAIMIMAGES_VS



CREATE INDEX CLAIMNO on CHCNPORTAL_CLAIM_IMAGES(CLAIMNO)
























GO