IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_CustomerCompanyListGet]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_CustomerCompanyListGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_CustomerCompanyListGet] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_CustomerCompanyListGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_CustomerCompanyListGet] 
	@pCustomerId int
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()

	declare @Ret_Table Table
	(
		CompanyId int,
		CompanyName nvarchar(256),
		CompanyCode nvarchar(256),
		isDefault bit
	)
	insert into @Ret_Table
	(
		CompanyId,
		CompanyName,
		CompanyCode,
		isDefault
	)
	select	c.Id as CompanyId,
			c.CompanyName as CompanyName,
			c.CompanyCode as CompanyCode,
			0 as isDefault
	--select * 
	from Customers a (nolock)
		inner join CustomerCompany b (nolock) on a.Id = b.CustomerId
		inner join Company c (nolock) on b.CompanyId = c.Id
	where a.Id = @pCustomerId
	and a.Available = 1
	and b.Available = 1
	and c.Active = 1

	
	declare @pCompanyId int = 0
	select @pCompanyId = min(CompanyId) 
	from @Ret_Table

	if(exists(
		select *
		from CustomerSession a (nolock)
		where a.CustomerId = @pCustomerId
	))
	begin
		select @pCompanyId = a.CompanyId
		from CustomerSession a (nolock)
		where a.Id in 
		(
			select max(a.Id)
			from CustomerSession a (nolock)
			where a.CustomerId = @pCustomerId
		)
	end

	update a
	set a.isDefault = 1
	from @Ret_Table a
	where a.CompanyId = @pCompanyId

	select *
	from @Ret_Table
	order by CompanyId desc



return

/*

*/



GO


