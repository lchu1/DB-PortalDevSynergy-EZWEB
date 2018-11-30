IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'CHCN-EB\tableau')
CREATE LOGIN [CHCN-EB\tableau] FROM WINDOWS
GO
CREATE USER [CHCN-EB\tableau] FOR LOGIN [CHCN-EB\tableau]
GO
