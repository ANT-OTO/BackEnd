IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_CustomerSession_UpdateCompany]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_CustomerSession_UpdateCompany] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_CustomerSession_UpdateCompany] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_CustomerSession_UpdateCompany] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_CustomerSession_UpdateCompany] 
	@pCustomerId int,
	@pCompanyId int
AS

SET NOCOUNT ON

	declare @pTime datetime = getutcdate()
	
	if(exists(
		select *
		from CustomerCompany a (nolock)
			inner join Customers b (nolock) on a.CustomerId = b.Id
		where b.Id = @pCustomerId
		and a.CompanyId = @pCompanyId
		and a.Available = 1
		and b.Available = 1
	))
	begin
		update a
		set a.CompanyId = @pCompanyId
		from CustomerSession a (nolock)
		where a.Id in (
			select max(a.Id)
			from CustomerSession a (nolock)
			where a.CustomerId = @pCustomerId
		)
	end



	
	




	

return

/*

*/



GO


