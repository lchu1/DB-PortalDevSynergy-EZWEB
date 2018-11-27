SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





CREATE VIEW [dbo].[CHCNWEB_SPECIALISTS_VS]
AS
SELECT DISTINCT 
                      dbo.CHCNWEB_SPECIALISTS.ID, dbo.CHCNWEB_SPECIALISTS.PROVID, dbo.CHCNWEB_SPECIALISTS.LASTNAME, 
                      dbo.CHCNWEB_SPECIALISTS.FIRSTNAME, dbo.CHCNWEB_SPECIALISTS.STREET, dbo.CHCNWEB_SPECIALISTS.CITY, 
                      dbo.CHCNWEB_SPECIALISTS.ZIP, dbo.CHCNWEB_SPECIALISTS.PHONE, dbo.CHCNWEB_SPECIALISTS.FAX, 
                      dbo.CHCNWEB_SPECIALISTS.MEMOLINE3, dbo.CHCNWEB_SPECIALISTS.MEDICAL_GROUP, dbo.CHCNWEB_SPECIALISTS.CODE,
					  dbo.CHCNWEB_SPECIALISTS.DESCR --SK.12/28/2015 Added DESCR
FROM         dbo.CHCNWEB_SPECIALISTS INNER JOIN
                      dbo.CHCNWEB_SPECIALISTS_V ON dbo.CHCNWEB_SPECIALISTS.ID = dbo.CHCNWEB_SPECIALISTS_V.ID





GO
