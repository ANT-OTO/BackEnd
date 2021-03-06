--select * from MsgTemplate
--select * from CodeList where Category = 'MsgDeliveryMethod'


declare @PromoCodeSourceId int

declare @TblCode as Table
(
	PromoCode nvarchar(128) NOT NULL
)	

insert into @TblCode
(PromoCode)
select 'Heritage' 



insert into PromoCodeSource
(PromoCode, CreateDate)
select a.*, GETUTCDATE()
from @TblCode a left join  PromoCodeSource z on a.PromoCode = z.PromoCode
where z.Id is null

select @PromoCodeSourceId = SCOPE_IDENTITY()

declare @MsgTemplateId varchar(16) = ''
select @MsgTemplateId = convert(varchar, max(a.Id))
from MsgTemplate a (nolock)
where a.TemplateName = 'PersonPromoCode_Heritage'


--select * from PromoCodeSourceProperty
insert into PromoCodeSourceProperty
(PromoCodeSourceId, PropertyType, PropertyName,  PropertyValue, CreateDate, LastUpdate)
select a.*, GETUTCDATE(), GETUTCDATE()
from (
	select @PromoCodeSourceId as PromoCodeSourceId, 'MsgTemplateId' as PropetyType, 'ToPerson' as PropertyName, @MsgTemplateId as PropertyValue
) a left join PromoCodeSourceProperty z (nolock) on z.PropertyType = a.PropetyType and a.PropertyName = a.PropertyName
where z.Id is null


update a
set a.PropertyValue = @MsgTemplateId
	, a.LastUpdate = GETUTCDATE()
from PromoCodeSourceProperty a 
where a.PromoCodeSourceId = @PromoCodeSourceId and a.PropertyType = 'MsgTemplateId' and a.PropertyName = 'ToPerson' and a.PropertyValue <> @MsgTemplateId






select * from PromoCodeSource where PromoCode = 'Heritage'
select * from PromoCodeSourceProperty where PromoCodeSourceId in (select Id from PromoCodeSource where PromoCode = 'Heritage')
