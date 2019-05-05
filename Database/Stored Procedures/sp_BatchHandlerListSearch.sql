IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_BatchHandlerListSearch]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_BatchHandlerListSearch] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_BatchHandlerListSearch] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_BatchHandlerListSearch] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_BatchHandlerListSearch] 
	@pCompanyId int,
	@pBeginDate datetime,
	@pEndDate datetime,
	@pBatchNumberSearch nvarchar(256),
	@pBatchStatusCodeId int,
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
	--@pShippingOrderCode nvarchar(256),
	declare @pByBatchNumberSearch bit = 0
	if(len(isnull(@pBatchNumberSearch, '')) > 0)
	begin
		select @pByBatchNumberSearch = 1
	end

	declare @pByBatchStatusCodeId bit = 0
	if(@pBatchStatusCodeId is not null)
	begin
		select @pByBatchStatusCodeId = 1
	end




	--select * from BatchHandler
	--select * from BatchHandlerProperty
	declare @pBatchHandlerTable Table
	(
		BatchHandlerId int NOT NULL,
		BatchNumber int NOT NULL,
		BatchTemplateId int NOT NULL,
		BatchTemplate nvarchar(256) NOT NULL,
		BatchStatusCodeId int NOT NULL,
		BatchStatus nvarchar(256) NOT NULL,
		CreateDate datetime NOT NULL
	)
	insert into @pBatchHandlerTable
	(
		BatchHandlerId,
		BatchNumber,
		BatchTemplateId,
		BatchTemplate,
		BatchStatusCodeId,
		BatchStatus,
		CreateDate
	)
	select a.Id, a.BatchNumber, c.Id, c.TemplateName, a.BatchStatusCodeId, b.CodeShort, a.CreateDate
	from BatchHandler a (nolock)
		inner join CodeList b (nolock) on a.BatchStatusCodeId = b.CodeId and b.Category = 'BatchStatus'
		inner join BatchTemplate c (nolock) on a.BatchTemplateId = c.Id
		inner join [User] d (nolock) on a.UserId = d.Id
		inner join CompanyUser e (nolock) on d.Id = e.UserId
		inner join Company f (nolock) on e.CompanyId = f.Id
	where f.Id = @pCompanyId
	and (@pByBatchStatusCodeId = 0 or a.BatchStatusCodeId = @pBatchStatusCodeId)
	and (@pByBatchNumberSearch = 0 or a.BatchNumber = @pBatchNumberSearch)


	


	select @Total = count(distinct(a.BatchHandlerId)) 
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
		select	BatchHandlerId,
				BatchNumber,
				BatchTemplateId,
				BatchTemplate,
				BatchStatusCodeId,
				BatchStatus,
				CreateDate,
			ROW_NUMBER() OVER (order by a.BatchHandlerId desc) AS RowNumber
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


