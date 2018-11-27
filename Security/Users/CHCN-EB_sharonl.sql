IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'CHCN-EB\sharonl')
CREATE LOGIN [CHCN-EB\sharonl] FROM WINDOWS
GO
CREATE USER [CHCN-EB\sharonl] FOR LOGIN [CHCN-EB\sharonl]
GO
