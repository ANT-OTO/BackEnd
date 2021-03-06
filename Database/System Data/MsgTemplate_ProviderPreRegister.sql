--select * from MsgTemplate
--select * from CodeList where Category = 'MsgDeliveryMethod'

declare @TblCode as Table
(
	[MsgDeliveryMethodCodeId] int NOT NULL,			-- CodeList (Category MsgDeliveryMethod) Mobile Push, Email, Text
	[TemplateName] [varchar](256) NOT NULL,		-- New_Request, New_Interview, Mobile_Phone_Validation
	[Template] [nvarchar](max) NOT NULL
)	


declare @TemplateName [varchar](256) = ''



--select * from CodeList where Category = 'MsgDeliveryMethod' order by SortOrder
--select * from MsgTemplate

delete @TblCode

select @TemplateName = 'ProviderPreRegister'

insert into @TblCode	
([MsgDeliveryMethodCodeId], [TemplateName], [Template])
select a.*
from (
	select 3 as [MsgDeliveryMethodCodeId], @TemplateName as [TemplateName], 
'<p>A link to download the WEYI Provider mobile app <a href=''$Link$''>$Link$</a> has been sent to your phone. Just follow the prompts to register. Remember to add at least two languages, one of which should be your native language.</p>

<p>Screening interviews are conducted through the WEYI app. This allows us to reach candidates regardless of geographic location, and have reasonable assurance of their technical skills.</p>

<p>Make sure you email pm@weyimobile.com with the date and time(s) when you can interview with a Provider Services Manager over the app. The meeting will only take 10-15 minutes.</p>

<p>If you don''t have a smart phone you can provide service through the web application <a href=''https://www.weyimobile.com/provider''>https://www.weyimobile.com/provider</a>.</p>

<p>Thank you,<br />
Tim</p>

<p>Timothy Kudzma<br />
WEYI Provider Services<br />
tkudzma@weyimobile.com<br />
mobile: (954) 288-7711<br />
Skype: timkudzma<br />
Toll free: (855) 568-6509</p>
' as [Template]
	

	UNION 

	select 31 as [MsgDeliveryMethodCodeId], @TemplateName as [TemplateName], 
		'WEYI Provider App' as [Template]

	UNION
	
	select 4 as [MsgDeliveryMethodCodeId], @TemplateName as [TemplateName], 
		'Welcome to the WEYI provider community! Download the WEYI Provider app here: $Link$' as [Template]
) a 

insert into [MsgTemplate]
([MsgDeliveryMethodCodeId], [TemplateName], [Template], CreateDate)
select a.*, GETUTCDATE()
from @TblCode a left join  [MsgTemplate] z on a.[MsgDeliveryMethodCodeId] = z.[MsgDeliveryMethodCodeId] and a.TemplateName = z.TemplateName
where z.Id is null

update a
set a.[Template] = b.[Template]
from [MsgTemplate] a inner join  @TblCode b on a.[MsgDeliveryMethodCodeId] = b.[MsgDeliveryMethodCodeId] and a.TemplateName = b.TemplateName

delete 
--select * from
[MsgTemplateY] where MsgTemplateId in (
	select a.Id
	from [MsgTemplate] a left join @TblCode z on a.[MsgDeliveryMethodCodeId] = z.[MsgDeliveryMethodCodeId] and a.TemplateName = z.TemplateName
	where a.[TemplateName] = @TemplateName and z.[MsgDeliveryMethodCodeId] is null
)

delete 
--select * from
[MsgTemplate] where Id in (
	select a.Id
	from [MsgTemplate] a left join @TblCode z on a.[MsgDeliveryMethodCodeId] = z.[MsgDeliveryMethodCodeId] and a.TemplateName = z.TemplateName
	where a.[TemplateName] = @TemplateName and z.[MsgDeliveryMethodCodeId] is null
)




select * from MsgTemplate where TemplateName = 'ProviderPreRegister'
