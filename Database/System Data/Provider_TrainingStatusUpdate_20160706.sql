
DECLARE	@return_value int,
		@pProviderPropertyId int

declare @pTime datetime

DECLARE ProviderId_Cursor CURSOR FOR 
select a.ProviderId
from (
	select a.Id as ProviderId from Provider a
		inner join ProviderProperty b on a.Id = b.ProviderId and b.PropertyType = 'Registration' and b.PropertyName = 'Complete' and b.PropertyValue = 'Y'
			left join ProviderProperty  z on a.Id = z.ProviderId and z.PropertyType = 'Train' and z.PropertyName = 'Complete' and z.PropertyValue = 'Y'
			left join ProviderProperty  y on a.Id = z.ProviderId and y.PropertyType = 'Setup' and y.PropertyName = 'ContractSigned' and y.PropertyValue = 'Y'
	where a.PromoCode = '' and (z.Id is null or y.Id is null) 

	UNION

	select 2925 as ProviderId
) a

declare @ProviderId int = 0

OPEN ProviderId_Cursor

FETCH NEXT FROM ProviderId_Cursor INTO @ProviderId


WHILE @@FETCH_STATUS = 0 
BEGIN


	select @pTime = getutcdate()

	EXEC	@return_value = [dbo].[sp_ProviderProperty_Set]
			@pProviderId = @ProviderId,
			@pPropertyType = N'Train',
			@pPropertyName = N'Complete',
			@pPropertyValue = N'Y',
			@pTime = @pTime,
			@pProviderPropertyId = @pProviderPropertyId OUTPUT


	EXEC	@return_value = [dbo].[sp_ProviderProperty_Set]
			@pProviderId = @ProviderId,
			@pPropertyType = N'Setup',
			@pPropertyName = N'ContractSigned',
			@pPropertyValue = N'Y',
			@pTime = @pTime,
			@pProviderPropertyId = @pProviderPropertyId OUTPUT


	declare @ProviderWebURLId int = 0
	insert into ProviderWebURL
	(ProviderId, Purpose, CreateDate)
	select @ProviderId, 'HomeDisplay', getutcdate()

	select @ProviderWebURLId = SCOPE_IDENTITY()

	insert into ProviderWebURLDetail
	(ProviderWebURLId, URL, DisplaySeconds, CreateDate)
	select @ProviderWebURLId, 'Provider/ProviderServiceStatus.aspx?v=' + convert(varchar(32), @ProviderWebURLId), 30, getutcdate()


	insert into ProviderWebURLDetail
	(ProviderWebURLId, URL, DisplaySeconds, CreateDate)
	select @ProviderWebURLId, 'ProviderHomeDefault.html?v=' + convert(varchar(32), @ProviderWebURLId), 30, getutcdate()


	FETCH NEXT FROM ProviderId_Cursor INTO @ProviderId
END

CLOSE ProviderId_Cursor
DEALLOCATE ProviderId_Cursor


--select * from ProviderWebURL where ProviderId = @ProviderId order by Id desc
--select * from ProviderWebURLDetail where ProviderWebURLId in (3613,
--3570)

--Provider/ProviderServiceStatus.aspx?v=594
--ProviderHomeDefault.html?v=594


--select * from ProviderWebURL where ProviderId = 96 order by Id desc
--select * from ProviderWebURLDetail where ProviderWebURLId in (594,
--593)