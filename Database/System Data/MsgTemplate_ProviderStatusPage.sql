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

select @TemplateName = 'ProviderStatusPage'

insert into @TblCode	
([MsgDeliveryMethodCodeId], [TemplateName], [Template])
select a.*
from (
	select 5 as [MsgDeliveryMethodCodeId], @TemplateName as [TemplateName], 
		'<strong>Welcome!</strong>
<div style="display:$DisplayApproved$;">
<p>You have been approved to provide the following interpretation services:</p>
<ul>$ApprovedItemList$
</ul>
<p>Be sure to set your schedule according to your availability.</p>
</div>
<div style="display:$DisplayPending$;">
<p>Your application as a WEYI service provider for the following is pending training and approval.</p>
<ul>$PendingItemList$
</ul>
<p>You can expect to be contacted during your scheduled service hours by a Provider Manager to complete your application.</p>
</div>
<div>
<div style="display:$DisplayNotActive$;">
<p>Your currently do not have any services approved or pending approval.</p>
</div>
<div>
If you have any questions, please call Provider Services at: +1 (855) 568-6509 or email pm@weyimobile.com
</div>' as [Template]
	
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




select * from MsgTemplate where TemplateName = 'ProviderStatusPage'
