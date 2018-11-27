SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS OFF
GO




CREATE Procedure [dbo].[CHCNPORTAL_GetAuthLetter]
    @Authno varchar(25)
As
    
EXEC [EZCAP65TEST].[EZCAPDB].[dbo].ReportAuthLetter @authno=@authno, @OpID = '1'




GO
