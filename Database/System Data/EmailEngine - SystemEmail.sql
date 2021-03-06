--select * from [EmailEngine]


declare @TblContent as Table
(
	[Id] int NOT NULL,
	[EngineName] [nvarchar](64) NOT NULL
)	


insert into @TblContent
([Id], [EngineName])
select a.*
from (
	select 1 as Id, N'SystemEmail' as [Name]
	
) a 


insert into [EmailEngine]
([Id], [EngineName], CreateDate, LastUpdate)
select a.*, GETDATE(), GETDATE()
from @TblContent a left join  [EmailEngine] z on a.Id = z.Id
where z.Id is null

update a
set a.[EngineName] = b.[EngineName]
	,a.LastUpdate = GETDATE()
from [EmailEngine] a inner join  @TblContent b on a.Id = b.Id
where Not ( a.[EngineName] = b.[EngineName])

select * from EmailEngine


declare @EmailEngineId int = 0
select @EmailEngineId = a.Id
from EmailEngine a (nolock) where EngineName = 'SystemEmail'

if( @EmailEngineId > 0 )
begin
	--select * from EmailEngineProperty

	delete EmailEngineProperty where EmailEngineId = @EmailEngineId

	DECLARE	@return_value int,
		@pEmailEnginePropertyId int

	EXEC	@return_value = [dbo].[sp_EmailEngineProperty_Set]
			@pEmailEngineId = @EmailEngineId,
			@pPropertyType = N'Engine',
			@pPropertyName = N'SMTP',
			@pPropertyValue = N'smtp.gmail.com',
			@pEmailEnginePropertyId = @pEmailEnginePropertyId OUTPUT

	EXEC	@return_value = [dbo].[sp_EmailEngineProperty_Set]
			@pEmailEngineId = @EmailEngineId,
			@pPropertyType = N'Engine',
			@pPropertyName = N'SMTPPort',
			@pPropertyValue = N'587',
			@pEmailEnginePropertyId = @pEmailEnginePropertyId OUTPUT

	EXEC	@return_value = [dbo].[sp_EmailEngineProperty_Set]
			@pEmailEngineId = @EmailEngineId,
			@pPropertyType = N'Engine',
			@pPropertyName = N'SMTPSecurity',
			@pPropertyValue = N'SSL',
			@pEmailEnginePropertyId = @pEmailEnginePropertyId OUTPUT

	EXEC	@return_value = [dbo].[sp_EmailEngineProperty_Set]
			@pEmailEngineId = @EmailEngineId,
			@pPropertyType = N'Security',
			@pPropertyName = N'UserName',
			@pPropertyValue = N'test@hticonsulting.net',
			@pEmailEnginePropertyId = @pEmailEnginePropertyId OUTPUT

	EXEC	@return_value = [dbo].[sp_EmailEngineProperty_Set]
			@pEmailEngineId = @EmailEngineId,
			@pPropertyType = N'Security',
			@pPropertyName = N'Pwd',
			@pPropertyValue = N'abc062015',
			@pEmailEnginePropertyId = @pEmailEnginePropertyId OUTPUT

end

select * from EmailEngineProperty