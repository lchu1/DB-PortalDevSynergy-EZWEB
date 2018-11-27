SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE  PROCEDURE [dbo].[P_SendEmail]
AS
BEGIN

DECLARE @RowId INT
DECLARE @RC INT
DECLARE @Message VARCHAR(4000)

DECLARE CRSSendMail CURSOR READ_ONLY
FOR
SELECT RowId from TestEmail
OPEN CRSSendMail
FETCH NEXT FROM CRSSendMail INTO @RowId
WHILE (@@fetch_status <> -1)
BEGIN
        IF (@@fetch_status <> -2)
        BEGIN

                        SELECT @message = 'This a new Auth Request from ' + REQNAME + ' submitted on ' + 
CONVERT(VARCHAR(100),REQDATE) + ' with Tracking ID ' + CONVERT(CHAR(10), REQID)
                        FROM TestEmail
                        Where RowId = @RowId

                        exec @RC = master.dbo.xp_smtp_sendmail @server = N'mail.chcn-eb.org', @from = N'candidoa@chcn-eb.org', @to =
N'candidoa@chcn-eb.org', @subject = 'New Auth Request.' , @Message = @Message

                        --Delete the one that has been send successfully
                        IF @RC != 0
                                DELETE FROM TestMail WHere RowId =
@RowId
                END
             FETCH NEXT FROM CRSSendMail INTO @RowId
END

CLOSE CRSSendMail
DEALLOCATE CRSSendMail

END



GO
