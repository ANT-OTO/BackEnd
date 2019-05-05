IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ShippingChannelCustomerCompanyGrantRight]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ShippingChannelCustomerCompanyGrantRight] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ShippingChannelCustomerCompanyGrantRight] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ShippingChannelCustomerCompanyGrantRight] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
Alter procedure [dbo].[sp_ShippingChannelCustomerCompanyGrantRight] 
	@pCustomerCompanyId int,
	@pShippingChannelId int,
	@pGranted bit,
	@pUserId int,
	@pLastUpdateBy int,
	@pLastUpdateByType int
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()

	--select * from ShippingChannelCompanyDisplay a (nolock)

	declare @pLogisticCompanyId int = 0
	select @pLogisticCompanyId = c.Id
	from [User] a (nolock)
		inner join CompanyUser b (nolock) on a.Id = b.UserId
		inner join Company c (nolock) on b.CompanyId = c.Id
	where a.Id = @pUserId

	if(exists(
		select *
		from ShippingChannelCompanyDisplay a (nolock)
		where a.ShippingChannelId = @pShippingChannelId
		and a.HandlerCompanyId = @pLogisticCompanyId
		and a.SourceCompanyId = @pCustomerCompanyId
	))
	begin
		update a
		set a.Available = @pGranted,
			a.Display = @pGranted,
			a.LastUpdate = @pTime,
			a.LastUpdateBy = @pLastUpdateBy,
			a.LastUpdateByType = @pLastUpdateByType
		from ShippingChannelCompanyDisplay a
		where a.ShippingChannelId = @pShippingChannelId
		and a.HandlerCompanyId = @pLogisticCompanyId
		and a.SourceCompanyId = @pCustomerCompanyId
	end
	else
	begin
		insert into ShippingChannelCompanyDisplay
		(
			ShippingChannelId,
			SourceCompanyId,
			HandlerCompanyId,
			Display,
			Available,
			CreateDate,
			LastUpdate,
			LastUpdateBy,
			LastUpdateByType
		)
		select	@pShippingChannelId,
				@pCustomerCompanyId,
				@pLogisticCompanyId,
				@pGranted,
				@pGranted,
				@pTime,
				@pTime,
				@pLastUpdateBy,
				@pLastUpdateByType
	end
	


return

/*

*/



GO


