IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ItemOnSaleRequestGetById]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ItemOnSaleRequestGetById] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ItemOnSaleRequestGetById] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ItemOnSaleRequestGetById] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ItemOnSaleRequestGetById] 
	@pItemOnSaleRequestId int,
	@pUserId int,
	@pSystemLanguageId int
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	declare @TempTable Table
	(
		[ItemOnSaleRequestId] int NOT NULL,
		[ItemId] int NOT NULL,
		[ItemOnSaleRequestTempBufferId] int NULL,
		[Description] nvarchar(max) NOT NULL,
		[UpdatedPrice] nvarchar(256) NOT NULL,
		[UpdatedCurrencyId] int NOT NULL,
		[UpdatedCurrency] nvarchar(256) NOT NULL,
		[ItemOnSaleRequestStatusCodeId] int NOT NULL, --select * from CodeList where Category = 'ItemOnSaleRequestStatus'
		CreateDate datetime NOT NULL
	)

	insert into @TempTable
	(
		[ItemOnSaleRequestId],
		[ItemId],
		[ItemOnSaleRequestTempBufferId],
		[Description],
		[UpdatedPrice],
		[UpdatedCurrencyId],
		[UpdatedCurrency],
		[ItemOnSaleRequestStatusCodeId], --select * from CodeList where Category = 'ItemOnSaleRequestStatus'
		CreateDate
	)
	select	a.Id, a.ItemId, a.ItemOnSaleRequestTempBufferId, a.[Description], a.[UpdatedPrice], a.[UpdatedCurrencyId], isnull(y.Code, ''),
			a.ItemOnSaleRequestStatusCodeId, a.CreateDate
	from [ItemOnSaleRequest] a (nolock)
		inner join CodeList b (nolock) on a.ItemOnSaleRequestStatusCodeId = b.CodeId AND b.Category = 'ItemOnSaleRequestStatus'
		left join CodeListY z (nolock) on b.Id = z.CodeListId and z.SystemLanguageId = @pSystemLanguageId
		inner join Item c (nolock) on c.Id = a.ItemId
		inner join CompanyItem d (nolock) on c.Id = d.ItemId
		left join Currency y (nolock) on a.UpdatedCurrencyId = y.Id
	where a.Id = @pItemOnSaleRequestId
	
	select * from @TempTable



return

/*

*/



GO


