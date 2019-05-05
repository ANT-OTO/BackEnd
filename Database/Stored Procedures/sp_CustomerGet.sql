IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_CustomerGet]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_CustomerGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_CustomerGet] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_CustomerGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_CustomerGet] 
	@pCustomerId int
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()

	select distinct (a.Id), a.FirstName, a.LastName, a.NickName,
			a.LoginName, a.CountryId, a.PhoneNumber, a.[Description],
			a.AvatarUrl, a.Gender,
		ROW_NUMBER() OVER (order by a.Id) AS RowNumber
	from 
	(
		select	distinct(a.Id), a.FirstName as FirstName, a.LastName as LastName, 
		a.LoginName as LoginName, isnull(z.NickName, a.NickName) as NickName,
				a.PhoneNumber as PhoneNumber, a.CountryId as CountryId,
				a.Description as [Description], isnull(z.AvatarUrl, '') as [AvatarUrl],
				isnull(z.GenderCode, '') as [Gender]
	--select * 
	from Customers a (nolock)
		inner join CustomerCompany b (nolock) on a.Id = b.CustomerId
		left join CustomerThirdParty z (nolock) on a.Id = z.CustomerId
	where a.Id = @pCustomerId
	and b.Available = 1
	) a
	



return

/*

*/



GO


