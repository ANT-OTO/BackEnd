sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
sp_configure 'clr enabled', 1;
GO
RECONFIGURE;
GO


USE [WEYITool]
EXEC sp_changedbowner 'sa'
GO

ALTER DATABASE [WEYITool] SET TRUSTWORTHY ON;

ALTER ASSEMBLY [WEYISQLTool]
   WITH PERMISSION_SET = UNSAFE;