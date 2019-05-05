IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ItemPackageInsertBuffer]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ItemPackageInsertBuffer] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ItemPackageInsertBuffer] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ItemPackageInsertBuffer] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ItemPackageInsertBuffer] 
	@pSourceId int,
	@pSourceTable nvarchar(256),
	@pUserId int,
	@pPrice nvarchar(256),
	@pCurrencyId int,
	@pDescription nvarchar(max),
	@pItemOnSaleRequestTempBufferId int output
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	declare @pItemId int = 0
	if(@pSourceTable = 'ItemSubmitPackage')
	begin
		select @pItemId = a.ItemId
		from ItemSubmitPackage a (nolock)
		where a.Id = @pSourceId
		and a.ItemPackageStatusCodeId = 96-- select * from CodeList where Category = 'ItemPackageStatus'
	end
	if(@pSourceTable = 'ItemUpdatePackage')
	begin
		select @pItemId = a.ItemId
		from ItemUpdatePackage a (nolock)
		where a.Id = @pSourceId
		and a.ItemPackageStatusCodeId = 96
	end

	if(@pItemId > 0)
	begin
		insert into [dbo].[ItemOnSaleRequestTempBuffer]
		(
			[ItemId],
			[SourceTable],
			[SourceId],
			[ItemOnSaleRequestTempBufferStatusCodeId], --select * from CodeList where Category = 'ItemOnSaleRequestTempBufferStatus'
			[Price],
			[CurrencyId],
			[Description],
			[CreateDate],
			[LastUpdate],
			[LastUpdateBy],
			[LastUpdateByType]
		)
		select	a.ItemId, a.SourceTable, a.SourceId, a.ItemOnSaleRequestTempBufferStatusCodeId,
				a.Price, a.CurrencyId, a.[Description],
				a.CreateDate, a.LastUpdate, a.LastUpdateBy, a.LastUpdateByType 
		from (
				select	@pItemId as [ItemId], @pSourceTable as [SourceTable], @pSourceId as [SourceId], 1 as [ItemOnSaleRequestTempBufferStatusCodeId],
						@pTime as [CreateDate], @pTime as [LastUpdate], @pUserId as [LastUpdateBy], 1 as [LastUpdateByType],
						@pPrice as [Price], @pCurrencyId as [CurrencyId], @pDescription as [Description]
		) a 
		left join [dbo].[ItemOnSaleRequestTempBuffer] z (nolock) on a.ItemId = z.ItemId and z.ItemOnSaleRequestTempBufferStatusCodeId in (1)
		where z.Id is null
		if(@@ROWCOUNT > 0)
		begin
			select @pItemOnSaleRequestTempBufferId = SCOPE_IDENTITY()
		end
		else
		begin
			update a
			set a.SourceTable = @pSourceTable,
				a.SourceId = @pSourceId,
				a.Price = @pPrice,
				a.CurrencyId = @pCurrencyId,
				a.[Description] = @pDescription
			from ItemOnSaleRequestTempBuffer a
			where a.ItemId = @pItemId
			and a.ItemOnSaleRequestTempBufferStatusCodeId in (1)
		end

		
	end



return

/*

*/



GO


