--select * from MsgTemplate
--select * from CodeList where Category = 'MsgDeliveryMethod'

declare @TblCode as Table
(
	[MsgDeliveryMethodCodeId] int NOT NULL,			-- CodeList (Category MsgDeliveryMethod) Mobile Push, Email, Text
	[TemplateName] [varchar](256) NOT NULL,		-- New_Request, New_Interview, Mobile_Phone_Validation
	[Template] [nvarchar](max) NOT NULL
)	

declare @MsgDeliveryMethodCodeId int = 0
declare @TemplateName [varchar](256) = ''

--select * from MsgTemplate where TemplateName = 'NewDPTNotification'

------------------------------------- Begin  Mobile Push ------------------------------------- 
--select * from CodeList where Category = 'MsgDeliveryMethod'

delete @TblCode

select @TemplateName = 'NewDPTNotification'
select @MsgDeliveryMethodCodeId = 1		-- Mobile Push
										-- select * from CodeList where Category = 'MsgDeliveryMethod'

insert into @TblCode	
([MsgDeliveryMethodCodeId], [TemplateName], [Template])
select a.*
from (
	select @MsgDeliveryMethodCodeId as [MsgDeliveryMethodCodeId], @TemplateName as [TemplateName], 
		'WEYI Translation Service Request $AdditionalInfo$' as [Template]
	
	--UNION
	
	--select @MsgDeliveryMethodCodeId as [MsgDeliveryMethodCodeId], @TemplateName as [TemplateName], 
	--	'Your validation Code is $Code$' as [Template]
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
[MsgTemplate] where Id in (
	select a.Id
	from [MsgTemplate] a left join @TblCode z on a.[MsgDeliveryMethodCodeId] = z.[MsgDeliveryMethodCodeId] and a.TemplateName = z.TemplateName
	where a.[MsgDeliveryMethodCodeId] = @MsgDeliveryMethodCodeId and a.[TemplateName] = @TemplateName and z.[MsgDeliveryMethodCodeId] is null
)


------------------------------------- End Mobile Push ------------------------------------- 



------------------------------------- Begin  Text ------------------------------------- 
--select * from CodeList where Category = 'MsgDeliveryMethod'

/*
delete @TblCode

select @TemplateName = 'NewDPTNotification'
select @MsgDeliveryMethodCodeId = 4		-- Text
										-- select * from CodeList where Category = 'MsgDeliveryMethod'

insert into @TblCode	
([MsgDeliveryMethodCodeId], [TemplateName], [Template])
select a.*
from (
	select @MsgDeliveryMethodCodeId as [MsgDeliveryMethodCodeId], @TemplateName as [TemplateName], 
		'WEYI Client Service Request $AdditionalInfo$' as [Template]
	
	--UNION
	
	--select @MsgDeliveryMethodCodeId as [MsgDeliveryMethodCodeId], @TemplateName as [TemplateName], 
	--	'Your validation Code is $Code$' as [Template]
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
[MsgTemplate] where Id in (
	select a.Id
	from [MsgTemplate] a left join @TblCode z on a.[MsgDeliveryMethodCodeId] = z.[MsgDeliveryMethodCodeId] and a.TemplateName = z.TemplateName
	where a.[MsgDeliveryMethodCodeId] = @MsgDeliveryMethodCodeId and a.[TemplateName] = @TemplateName and z.[MsgDeliveryMethodCodeId] is null
)

*/
------------------------------------- End Text ------------------------------------- 




------------------------------------- Begin  Email ------------------------------------- 
--select * from CodeList where Category = 'MsgDeliveryMethod'
/*
delete @TblCode

select @TemplateName = 'NewDPTNotification'
select @MsgDeliveryMethodCodeId = 3		-- Email
										-- select * from CodeList where Category = 'MsgDeliveryMethod'

insert into @TblCode	
([MsgDeliveryMethodCodeId], [TemplateName], [Template])
select a.*
from (
	select @MsgDeliveryMethodCodeId as [MsgDeliveryMethodCodeId], @TemplateName as [TemplateName], 
		'WEYI Client Service Request $AdditionalInfo$' as [Template]
	
	--UNION
	
	--select @MsgDeliveryMethodCodeId as [MsgDeliveryMethodCodeId], @TemplateName as [TemplateName], 
	--	'Your validation Code is $Code$' as [Template]
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
[MsgTemplate] where Id in (
	select a.Id
	from [MsgTemplate] a left join @TblCode z on a.[MsgDeliveryMethodCodeId] = z.[MsgDeliveryMethodCodeId] and a.TemplateName = z.TemplateName
	where a.[MsgDeliveryMethodCodeId] = @MsgDeliveryMethodCodeId and a.[TemplateName] = @TemplateName and z.[MsgDeliveryMethodCodeId] is null
)

*/
------------------------------------- End Email ------------------------------------- 





select * from MsgTemplate where TemplateName = 'NewDPTNotification'
