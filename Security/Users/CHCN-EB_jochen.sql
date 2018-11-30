IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'CHCN-EB\jochen')
CREATE LOGIN [CHCN-EB\jochen] FROM WINDOWS
GO
CREATE USER [CHCN-EB\jochen] FOR LOGIN [CHCN-EB\jochen]
GO
