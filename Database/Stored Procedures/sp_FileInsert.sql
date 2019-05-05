IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_FileInsert]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_FileInsert] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_FileInsert] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_FileInsert] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_FileInsert] 
	@pFileExt nvarchar(64),
	@pFileName nvarchar(256),
	@pFileStoreTypeCodeId int,
	@pFilePath nvarchar(256),
	@pFilePublicUrl nvarchar(512),
	@pMFilePublicUrl nvarchar(512),
	@pSFilePublicUrl nvarchar(512),
	@pUserId int,
	@pFileId int output
AS

SET NOCOUNT ON

declare @Time datetime = getutcdate()

insert into [dbo].[File]
(
	[FileName],
	[FileExt],
	[FileStoreTypeCodeId], --select * from CodeList where Category = 'FileStoreType'
	[FilePath],
	[FilePublicUrl],
	[MFilePublicUrl],
	[SFilePublicUrl],
	[Para1],
	[Para2],
	[Para3],
	[Para4],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select	@pFileName,
		@pFileExt,
		@pFileStoreTypeCodeId,
		@pFilePath,
		@pFilePublicUrl,
		@pMFilePublicUrl,
		@pSFilePublicUrl,
		null,
		null,
		null,
		null,
		@Time,
		@Time,
		@pUserId,
		1
SELECT @pFileId = SCOPE_IDENTITY()




return

/*

*/



GO


