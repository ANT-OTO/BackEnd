IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_BatchHandlerPropertySet]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_BatchHandlerPropertySet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_BatchHandlerPropertySet] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_BatchHandlerPropertySet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
Alter procedure [dbo].[sp_BatchHandlerPropertySet] 
	@pBatchHandlerId int,
	@pPropertyName nvarchar(64),
	@pPropertyValue nvarchar(256),
	@pUserId int,
	@pLastUpdateBy int,
	@pLastUpdateByType int
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()
	
	insert into [dbo].[BatchHandlerProperty]
	(
		[BatchHandlerId],
		[PropertyName],
		[PropertyValue],   
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select	a.BatchHandlerId, a.PropertyName, a.PropertyValue,
			a.CreateDate, a.LastUpdate, a.LastUpdateBy, a.LastUpdateByType
	from
	(
		select	@pBatchHandlerId as BatchHandlerId, @pPropertyName as PropertyName,
				@pPropertyValue as PropertyValue, @pTime as CreateDate,
				@pTime as LastUpdate, @pLastUpdateBy as LastUpdateBy,
				@pLastUpdateByType as LastUpdateByType
	) a
	left join [dbo].[BatchHandlerProperty] z (nolock) on a.BatchHandlerId = z.BatchHandlerId and a.PropertyName = z.PropertyName
	where z.Id is null
	
	if(@@ROWCOUNT = 0)
	begin
		update a
		set a.PropertyValue = @pPropertyValue,
			a.LastUpdate = @pTime,
			a.LastUpdateBy = @pLastUpdateBy,
			a.LastUpdateByType = @pLastUpdateByType
		from dbo.BatchHandlerProperty a
		where a.BatchHandlerId = @pBatchHandlerId
		and a.PropertyName = @pPropertyName
	end

	if(@pPropertyName = 'SourceCompanyId')
	begin
		declare @pHandlerCompanyId int = 0
		select @pHandlerCompanyId = a.CompanyId
		from CompanyLogisticCompany a (nolock)
		where a.CustomerCompanyId = convert(int, @pPropertyValue)

		if(isnull(@pHandlerCompanyId, 0) <> 0)
		begin
			declare @pHandlerCompany nvarchar(256) = convert(nvarchar(256),@pHandlerCompanyId)
			exec [dbo].[sp_BatchHandlerPropertySet] 
				@pBatchHandlerId,
				'HandlerCompanyId',
				@pHandlerCompany,
				@pUserId,
				@pLastUpdateBy,
				@pLastUpdateByType
		end
		
	end

	
	


return

/*

*/



GO


