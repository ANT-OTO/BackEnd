IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ItemOnSaleRequestCreate]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ItemOnSaleRequestCreate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ItemOnSaleRequestCreate] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ItemOnSaleRequestCreate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ItemOnSaleRequestCreate] 
	@pItemOnSaleRequestTempBufferId int,
	@pItemId int,
	@pPrice nvarchar(256),
	@pCurrencyId int,
	@pDescription nvarchar(max),
	@pItemOnSaleRequestId int output,
	@pItemSubmitPackageId int,
	@pItemUpdatePackageId int,
	@pUserId int
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	if(@pItemOnSaleRequestTempBufferId is not null)
	begin
		select @pItemId = a.ItemId
		from ItemOnSaleRequestTempBuffer a (nolock)
		where a.Id = @pItemOnSaleRequestTempBufferId
	end
	insert into [dbo].[ItemOnSaleRequest]
	(
		[ItemId],
		[ItemOnSaleRequestTempBufferId],
		[Description],
		[UpdatedPrice],
		[UpdatedCurrencyId],
		[ItemOnSaleRequestStatusCodeId], --select * from CodeList where Category = 'ItemOnSaleRequestStatus'
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select	a.ItemId, a.ItemOnSaleRequestTempBufferId, isnull(a.Description, ''), a.UpdatedPrice, a.UpdatedCurrencyId,
			a.ItemOnSaleRequestStatusCodeId, a.CreateDate, a.LastUpdate, a.LastUpdateBy, a.LastUpdateByType
	from 
	(
		select	@pItemId as ItemId, @pItemOnSaleRequestTempBufferId as ItemOnSaleRequestTempBufferId,
				@pDescription as [Description], @pPrice as [UpdatedPrice], @pCurrencyId as [UpdatedCurrencyId],
				1 as ItemOnSaleRequestStatusCodeId, @pTime as CreateDate, @pTime as LastUpdate,
				@pUserId as LastUpdateBy, 1 as LastUpdateByType
	) a
	left join [ItemOnSaleRequest] z (nolock) on a.ItemId = z.ItemId and z.ItemOnSaleRequestStatusCodeId = 1
	where z.Id is null

	if(@@ROWCOUNT > 0)
	begin
		select @pItemOnSaleRequestId = SCOPE_IDENTITY()
	end
	else
	begin
		update a
		set a.UpdatedPrice = @pPrice,
			a.UpdatedCurrencyId = @pCurrencyId,
			a.Description = isnull(@pDescription, ''),
			a.LastUpdateBy = @pUserId,
			a.LastUpdate = @pTime,
			a.ItemOnSaleRequestTempBufferId = @pItemOnSaleRequestTempBufferId
		from ItemOnSaleRequest a 
		where a.ItemId = @pItemId
		and a.ItemOnSaleRequestStatusCodeId = 1

		select @pItemOnSaleRequestId = a.Id
		from ItemOnSaleRequest a (nolock)
		where a.ItemId = @pItemId
		and a.ItemOnSaleRequestStatusCodeId = 1
	end

	if(@pItemOnSaleRequestId > 0 and isnull(@pItemSubmitPackageId, 0) > 0 or isnull(@pItemUpdatePackageId, 0) > 0)
	begin
		insert into [dbo].[ItemPackageOnSale]
		(
			[SourceTable],
			[SourceId],
			[ItemOnSaleRequestId],
			[CreateDate],
			[LastUpdate],
			[LastUpdateBy],
			[LastUpdateByType]
		)
		select	case when isnull(@pItemSubmitPackageId, 0) > 0 then 'ItemSubmitPackage' else 'ItemUpdatePackage' end,
				case when isnull(@pItemSubmitPackageId, 0) > 0 then @pItemSubmitPackageId else @pItemUpdatePackageId end,
				@pItemOnSaleRequestId,
				@pTime,
				@pTime,
				@pUserId,
				1
		update a
		set a.ItemPackageStatusCodeId = 95
		from ItemSubmitPackage a
		where a.Id = @pItemSubmitPackageId

		update a
		set a.ItemPackageStatusCodeId = 95
		from ItemUpdatePackage a
		where a.Id = @pItemUpdatePackageId



	end



return

/*

*/



GO


