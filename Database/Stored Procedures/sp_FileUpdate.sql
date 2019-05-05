IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_FileUpdate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_FileUpdate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_FileUpdate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_FileUpdate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_FileUpdate] 
	@pPara1 nvarchar(256),
	@pPara2 nvarchar(256),
	@pPara3 nvarchar(256),
	@pPara4 nvarchar(256),
	@pUserId int,
	@pFileId int output
AS

SET NOCOUNT ON

declare @Time datetime = getutcdate()

if(isnull(@pFileId, 0) = 0)
begin
	return
end
else
begin
	update a
	set a.Para1 = @pPara1,
		a.Para2 = @pPara2,
		a.Para3 = @pPara3,
		a.Para4 = @pPara4
	from dbo.[File] a (nolock)
	where a.Id = @pFileId
end




return

/*

*/



GO


