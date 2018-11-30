IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'CHCN-EB\shawnal')
CREATE LOGIN [CHCN-EB\shawnal] FROM WINDOWS
GO
CREATE USER [CHCN-EB\shawnal] FOR LOGIN [CHCN-EB\shawnal]
GO
