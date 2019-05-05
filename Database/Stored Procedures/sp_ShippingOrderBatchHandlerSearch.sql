IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ShippingOrderBatchHandlerSearch]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ShippingOrderBatchHandlerSearch] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ShippingOrderBatchHandlerSearch] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ShippingOrderBatchHandlerSearch] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ShippingOrderBatchHandlerSearch] 
	@pCompanyId int,
	@pShippingOrderCode nvarchar(256),
    @pBatchHandlerCode nvarchar(256),
    @pShippingOrderActionTypeCodeId int,
	@pBatchHandlerStatusCodeId int,
	@pBeginDate datetime,
	@pEndDate datetime,
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

	declare @pByCreateDateBegin bit = 0
	declare @pByCreateDateEnd bit = 0

	if(@pBeginDate is not null)
	begin
		select @pByCreateDateBegin = 1
	end

	if(@pEndDate is not null)
	begin
		select @pByCreateDateEnd = 1
	end
	
	declare @pByStatusCodeId bit = 0
	if(isnull(@pBatchHandlerStatusCodeId, 0) > 0)
	begin
		select @pByStatusCodeId = 1
	end

	declare @pByBatchHandlerCode bit = 0
	if(len(isnull(@pBatchHandlerCode, '')) > 0)
	begin
		select @pByBatchHandlerCode = 1
	end

	declare @pByShippingOrderCode bit = 0
	if(len(isnull(@pShippingOrderCode, '')) > 0)
	begin
		select @pByShippingOrderCode = 1
	end

	declare @pByShippingOrderActionTypeCodeId bit = 0
	if(isnull(@pShippingOrderActionTypeCodeId, 0) > 0)
	begin
		select @pByShippingOrderActionTypeCodeId = 1
	end



	--select * from ShippingOrder
	declare @pBatchHandlerTable Table
	(
		[ShippingOrderBatchHandlerId] int NOT NULL,
		[CompanyId] int NOT NULL,
		[ShippingChannelId] int NOT NULL,
		[ShippingChannelName] nvarchar(256) NOT NULL,
		[BatchHandlerCode] nvarchar(256) NOT NULL, 
		[BatchHandlerStatusCodeId] int NOT NULL, --select * from CodeList where Category = 'BatchHandlerStatus'
		[BatchHandlerStatus] nvarchar(256) NOT NULL,
		[UserId] int NOT NULL,
		[UserName] nvarchar(256) NOT NULL,
		[CreateDate] [datetime] NOT NULL,
		[LastUpdate] [datetime] NOT NULL
	)
	insert into @pBatchHandlerTable
	(
		[ShippingOrderBatchHandlerId],
		[CompanyId],
		[ShippingChannelId],
		[ShippingChannelName],
		[BatchHandlerCode], 
		[BatchHandlerStatusCodeId], --select * from CodeList where Category = 'BatchHandlerStatus'
		[BatchHandlerStatus],
		[UserId],
		[UserName],
		[CreateDate],
		[LastUpdate]
	)
	select	a.Id, a.CompanyId, a.ShippingChannelId,
			c.ChannelName, a.BatchHandlerCode, a.BatchHandlerStatusCodeId,
			d.CodeShort, e.Id, isnull(e.FirstName, '') + ' ' + isnull(e.LastName, ''),
			a.CreateDate, a.LastUpdate
	from ShippingOrderBatchHandler a (nolock)
		--left join ShippingOrderBatchHandlerDetail b (nolock) on a.Id = b.ShippingOrderBatchHandlerId
		inner join ShippingChannel c (nolock) on a.ShippingChannelId = c.Id
		inner join CodeList d (nolock) on d.CodeId = a.BatchHandlerStatusCodeId and d.Category = 'BatchHandlerStatus'
		inner join [User] e (nolock) on a.UserId = e.Id
	where a.CompanyId = @pCompanyId
	and (@pByCreateDateBegin = 0 or a.CreateDate >= @pBeginDate)
	and (@pByCreateDateEnd = 0 or a.CreateDate <= @pEndDate)
	and (@pByStatusCodeId = 0 or a.BatchHandlerStatusCodeId = @pBatchHandlerStatusCodeId)
	and (@pByBatchHandlerCode = 0 or a.BatchHandlerCode = @pBatchHandlerCode)
	
	and (@pByShippingOrderActionTypeCodeId = 0 or a.ShippingOrderActionTypeCodeId = @pShippingOrderActionTypeCodeId)

	if(@pByShippingOrderCode = 1)
	begin
		delete
		from @pBatchHandlerTable
		where ShippingOrderBatchHandlerId not in (
			select a.Id from ShippingOrderBatchHandler a (nolock)
			inner join ShippingOrderBatchHandlerDetail b (nolock) on a.Id = b.ShippingOrderBatchHandlerId
			where b.ShippingOrderCode = @pShippingOrderCode
			and a.CompanyId = @pCompanyId
		)
	end


	select @Total = count(distinct(a.[ShippingOrderBatchHandlerId])) 
	--select * 
	from @pBatchHandlerTable a
	
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
		select	[ShippingOrderBatchHandlerId],
				[CompanyId],
				[ShippingChannelId],
				[ShippingChannelName],
				[BatchHandlerCode], 
				[BatchHandlerStatusCodeId], --select * from CodeList where Category = 'BatchHandlerStatus'
				[BatchHandlerStatus],
				[UserId],
				[UserName],
				[CreateDate],
				[LastUpdate],
			ROW_NUMBER() OVER (order by a.[ShippingOrderBatchHandlerId] desc) AS RowNumber
			from @pBatchHandlerTable a
	)

	SELECT *
	from PagedQuery
	where RowNumber  between @RecStart and @RecEnd
	order by RowNumber ASC;



return

/*

*/



GO


