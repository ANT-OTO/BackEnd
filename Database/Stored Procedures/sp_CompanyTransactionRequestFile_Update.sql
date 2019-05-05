IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_CompanyTransactionRequestFile_Update]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_CompanyTransactionRequestFile_Update] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_CompanyTransactionRequestFile_Update] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_CompanyTransactionRequestFile_Update] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_CompanyTransactionRequestFile_Update] 
	@pCompanyTransactionRequestId int,
	@pFileId int,
	@pLastUpdateBy int,
	@pLastUpdateByType int,
	@pCompanyTransactionRequestFileId int output
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()

	insert into [dbo].[CompanyTransactionRequestFile]
	(
		[CompanyTransactionRequestId],
		[FileId],
		[Available],
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select	@pCompanyTransactionRequestId,
			@pFileId,
			1,
			@pTime,
			@pTime,
			@pLastUpdateBy,
			@pLastUpdateByType

	select @pCompanyTransactionRequestFileId = SCOPE_IDENTITY()



return

/*

*/



GO


