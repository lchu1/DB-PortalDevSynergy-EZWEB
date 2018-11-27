SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO




--Sends email 
CREATE PROCEDURE [dbo].[CHCNEDI_SendEmail]

@to varchar(1000),
@from varchar(1000),
@subject varchar(200), 
@message varchar(1000)

as

declare @RC int

--exec @RC = master.dbo.xp_smtp_sendmail @server = N'exchange2k3.chcn-eb.org', @from=@from, @to=@to, @subject=@subject, @message=@message
exec @RC = msdb.dbo.sp_send_dbmail  @profile_name = 'ADMIN',@reply_to=@from, @recipients=@to, @subject=@subject, @body=@message, @body_format = 'Text', @file_attachments = NULL 





GO
