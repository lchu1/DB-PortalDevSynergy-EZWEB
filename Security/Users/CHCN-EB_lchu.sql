IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'CHCN-EB\lchu')
CREATE LOGIN [CHCN-EB\lchu] FROM WINDOWS
GO
CREATE USER [CHCN-EB\lchu] FOR LOGIN [CHCN-EB\lchu]
GO