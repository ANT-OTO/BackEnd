IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ItemOnSaleRequestTempBufferGet]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ItemOnSaleRequestTempBufferGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ItemOnSaleRequestTempBufferGet] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ItemOnSaleRequestTempBufferGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ItemOnSaleRequestTempBufferGet] 
	@pCompanyId int,
	@pUserId int,
	@pSystemLanguageId int,
	@PageSize INT,
	@Page INT output,
	@Total INT OUTPUT,
	@TotalPages INT OUTPUT
AS

SET NOCOUNT ON
	if(isnull(@PageSize, 0) <= 0)
	begin
		return
	end
	declare @pTime datetime = getutcdate()
	declare @TempTable Table
	(
		[ItemOnSaleRequestTempBufferId] int NOT NULL,
		[ItemId] int NOT NULL,
		[SourceTable] nvarchar(256) NOT NULL,
		[SourceId] int NOT NULL,
		[ItemOnSaleRequestTempBufferStatusCodeId] int NOT NULL, --select * from CodeList where Category = 'ItemOnSaleRequestTempBufferStatus'
		[Price] nvarchar(256) NULL,
		[CurrencyId] int NULL,
		[Description] nvarchar(max) NOT NULL,
		CreateDate datetime NOT NULL
	)

	insert into @TempTable
	(
		[ItemOnSaleRequestTempBufferId],
		[ItemId],
		[SourceTable],
		[SourceId],
		[ItemOnSaleRequestTempBufferStatusCodeId], --select * from CodeList where Category = 'ItemOnSaleRequestTempBufferStatus'
		[Price],
		[CurrencyId],
		[Description],
		CreateDate
	)
	select	a.Id, a.ItemId, a.SourceTable, a.SourceId, a.ItemOnSaleRequestTempBufferStatusCodeId, a.Price, a.CurrencyId, 
			a.[Description], a.CreateDate
	from [ItemOnSaleRequestTempBuffer] a (nolock)
		inner join CodeList b (nolock) on a.ItemOnSaleRequestTempBufferStatusCodeId = b.CodeId AND b.Category = 'ItemOnSaleRequestTempBufferStatus'
		left join CodeListY z (nolock) on b.Id = z.CodeListId and z.SystemLanguageId = @pSystemLanguageId
		inner join Item c (nolock) on c.Id = a.ItemId
		inner join CompanyItem d (nolock) on c.Id = d.ItemId
	where d.CompanyId = @pCompanyId
	and a.ItemOnSaleRequestTempBufferStatusCodeId = 1

	

	select @Total = count(*) 
	--select *
	from @TempTable a

	select @TotalPages = CEILING(convert(decimal(10,2), @Total)/convert(decimal(10,2) ,@PageSize))
	declare @MaxPage INT

	select @MaxPage = (@Total - 1 )/@PageSize + 1

	if ( @Page < 1 )
	BEGIN
		select @Page = 1
	END

	if ( @Page > @MaxPage )
	BEGIN
		select @Page = @MaxPage
	END

	declare @RecStart INT,
			@RecEnd INT

	select @RecStart = (@Page - 1) * @PageSize + 1,
			@RecEnd = @Page * @PageSize

	if( @RecEnd > @Total )
	begin
		select @RecEnd = @Total
	end
	;

	with PagedQuery AS
	(
		select	a.ItemOnSaleRequestTempBufferId,
				[ItemId],
				[SourceTable],
				[SourceId],
				[ItemOnSaleRequestTempBufferStatusCodeId], --select * from CodeList where Category = 'ItemOnSaleRequestTempBufferStatus'
				[Price],
				[CurrencyId],
				[Description],
				CreateDate,
				ROW_NUMBER() OVER (order by a.CreateDate desc) AS RowNumber
		from @TempTable a
	)

	SELECT *
	from PagedQuery
	where RowNumber  between @RecStart and @RecEnd
	order by RowNumber ASC;



return

/*

*/



GO


