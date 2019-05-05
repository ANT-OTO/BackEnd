IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ItemOnSaleRequestPlatformInsert]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ItemOnSaleRequestPlatformInsert] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ItemOnSaleRequestPlatformInsert] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ItemOnSaleRequestPlatformInsert] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ItemOnSaleRequestPlatformInsert] 
	@pItemOnSaleRequestId int,
	@pPlatformName nvarchar(256),
	@pUserId int,
	@pItemOnSaleRequestPlatformInfoId int output
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	
	insert into [dbo].[ItemOnSaleRequestPlatformInfo]
	(
		[ItemOnSaleRequestId],
		[PlatformName],
		[Available],
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select	a.ItemOnSaleRequestId, a.PlatformName, a.Available, a.CreateDate, a.LastUpdate, a.LastUpdateBy, a.LastUpdateByType
	from 
	(
		select	@pItemOnSaleRequestId as ItemOnSaleRequestId, @pPlatformName as PlatformName,
				1 as Available, @pTime as CreateDate, @pTime as LastUpdate, @pUserId as LastUpdateBy,
				1 as LastUpdateByType
	) a
	left join [ItemOnSaleRequestPlatformInfo] z (nolock) on a.[ItemOnSaleRequestId] = z.[ItemOnSaleRequestId] and a.PlatformName = z.PlatformName and z.Available = 1
	where z.Id is null

	if(@@ROWCOUNT > 0)
	begin
		select @pItemOnSaleRequestPlatformInfoId = SCOPE_IDENTITY()
	end
	else
	begin

		select @pItemOnSaleRequestPlatformInfoId = a.Id
		from ItemOnSaleRequestPlatformInfo a (nolock)
		where a.ItemOnSaleRequestId = @pItemOnSaleRequestId
		and a.PlatformName = @pPlatformName
		and a.Available = 1
	end



return

/*

*/



GO


