SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



create VIEW [dbo].[CHCNWEB_SPECIALISTS_ALL_V]
AS
SELECT     MIN(ID) AS ID, PROVID, CITY, CODE
FROM         dbo.CHCNWEB_SPECIALISTS_ALL
GROUP BY CITY, PROVID, CODE



GO
