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

------------------------------------- Begin  Text ------------------------------------- 
--select * from CodeList where Category = 'MsgDeliveryMethod'
--delete [MsgTemplate] where MsgDeliveryMethodCodeId = 4
delete @TblCode

select @TemplateName = 'PhoneValidation'
select @MsgDeliveryMethodCodeId = 4		-- Text
										-- select * from CodeList where Category = 'MsgDeliveryMethod'

insert into @TblCode	
([MsgDeliveryMethodCodeId], [TemplateName], [Template])
select a.*
from (
	select @MsgDeliveryMethodCodeId as [MsgDeliveryMethodCodeId], @TemplateName as [TemplateName], 
		'Validation Code is $Code$' as [Template]
	
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


------------------------------------- End Text ------------------------------------- 




------------------------------------- Begin  Push ------------------------------------- 
--select * from CodeList where Category = 'MsgDeliveryMethod'
--delete [MsgTemplate] where MsgDeliveryMethodCodeId = 1
delete @TblCode

select @TemplateName = 'NewTaskNotification'
select @MsgDeliveryMethodCodeId = 1		-- Mobile Push
										-- select * from CodeList where Category = 'MsgDeliveryMethod'

insert into @TblCode	
([MsgDeliveryMethodCodeId], [TemplateName], [Template])
select a.*
from (
	select @MsgDeliveryMethodCodeId as [MsgDeliveryMethodCodeId], @TemplateName as [TemplateName], 
		'New Task $AdditionalInfo$' as [Template]
	
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
[MsgTemplateY] where MsgTemplateId in (
	select a.Id
	from [MsgTemplate] a left join @TblCode z on a.[MsgDeliveryMethodCodeId] = z.[MsgDeliveryMethodCodeId] and a.TemplateName = z.TemplateName
	where a.[MsgDeliveryMethodCodeId] = 1 and a.[TemplateName] = @TemplateName and z.[MsgDeliveryMethodCodeId] is null
)

delete 
--select * from
[MsgTemplate] where Id in (
	select a.Id
	from [MsgTemplate] a left join @TblCode z on a.[MsgDeliveryMethodCodeId] = z.[MsgDeliveryMethodCodeId] and a.TemplateName = z.TemplateName
	where a.[MsgDeliveryMethodCodeId] = 1 and a.[TemplateName] = @TemplateName and z.[MsgDeliveryMethodCodeId] is null
)






------------------------------------- End Push ------------------------------------- 

------------------------------------- Begin Candidate Push ------------------------------------- 
--select * from CodeList where Category = 'MsgDeliveryMethod'
--delete [MsgTemplate] where MsgDeliveryMethodCodeId = 1

delete @TblCode

select @TemplateName = 'CandidatePush'
select @MsgDeliveryMethodCodeId = 1		-- Mobile Push
										-- select * from CodeList where Category = 'MsgDeliveryMethod'

insert into @TblCode	
([MsgDeliveryMethodCodeId], [TemplateName], [Template])
select a.*
from (
	select @MsgDeliveryMethodCodeId as [MsgDeliveryMethodCodeId], @TemplateName as [TemplateName], 
		'To be interviewed $InterviewInfo$' as [Template]
) a 


insert into [MsgTemplate]
([MsgDeliveryMethodCodeId], [TemplateName], [Template], CreateDate)
select a.*, GETUTCDATE()
from @TblCode a left join  [MsgTemplate] z on a.[MsgDeliveryMethodCodeId] = z.[MsgDeliveryMethodCodeId] and a.TemplateName = z.TemplateName
where z.Id is null

update a
set a.[Template] = b.[Template]
-- select
from [MsgTemplate] a inner join  @TblCode b on a.[MsgDeliveryMethodCodeId] = b.[MsgDeliveryMethodCodeId] and a.TemplateName = b.TemplateName

delete 
--select * from
[MsgTemplateY] where MsgTemplateId in (
	select a.Id
	from [MsgTemplate] a left join @TblCode z on a.[MsgDeliveryMethodCodeId] = z.[MsgDeliveryMethodCodeId] and a.TemplateName = z.TemplateName
	where a.[MsgDeliveryMethodCodeId] = 1 and a.[TemplateName] = @TemplateName and z.[MsgDeliveryMethodCodeId] is null
)

delete 
--select * from
[MsgTemplate] where Id in (
	select a.Id
	from [MsgTemplate] a left join @TblCode z on a.[MsgDeliveryMethodCodeId] = z.[MsgDeliveryMethodCodeId] and a.TemplateName = z.TemplateName
	where a.[MsgDeliveryMethodCodeId] = 1 and a.[TemplateName] = @TemplateName and z.[MsgDeliveryMethodCodeId] is null
)


------------------------------------- End Candidate Push ------------------------------------- 

------------------------------------- Begin Interviewer Push ------------------------------------- 
--select * from CodeList where Category = 'MsgDeliveryMethod'
--delete [MsgTemplate] where MsgDeliveryMethodCodeId = 1

delete @TblCode

select @TemplateName = 'InterviewerPush'
select @MsgDeliveryMethodCodeId = 1		-- Mobile Push
										-- select * from CodeList where Category = 'MsgDeliveryMethod'

insert into @TblCode	
([MsgDeliveryMethodCodeId], [TemplateName], [Template])
select a.*
from (
	select @MsgDeliveryMethodCodeId as [MsgDeliveryMethodCodeId], @TemplateName as [TemplateName], 
		'Interview Candidate $CandidateInfo$' as [Template]
) a 


insert into [MsgTemplate]
([MsgDeliveryMethodCodeId], [TemplateName], [Template], CreateDate)
select a.*, GETUTCDATE()
from @TblCode a left join  [MsgTemplate] z on a.[MsgDeliveryMethodCodeId] = z.[MsgDeliveryMethodCodeId] and a.TemplateName = z.TemplateName
where z.Id is null

update a
set a.[Template] = b.[Template]
-- select
from [MsgTemplate] a inner join  @TblCode b on a.[MsgDeliveryMethodCodeId] = b.[MsgDeliveryMethodCodeId] and a.TemplateName = b.TemplateName

delete 
--select * from
[MsgTemplateY] where MsgTemplateId in (
	select a.Id
	from [MsgTemplate] a left join @TblCode z on a.[MsgDeliveryMethodCodeId] = z.[MsgDeliveryMethodCodeId] and a.TemplateName = z.TemplateName
	where a.[MsgDeliveryMethodCodeId] = 1 and a.[TemplateName] = @TemplateName and z.[MsgDeliveryMethodCodeId] is null
)

delete 
--select * from
[MsgTemplate] where Id in (
	select a.Id
	from [MsgTemplate] a left join @TblCode z on a.[MsgDeliveryMethodCodeId] = z.[MsgDeliveryMethodCodeId] and a.TemplateName = z.TemplateName
	where a.[MsgDeliveryMethodCodeId] = 1 and a.[TemplateName] = @TemplateName and z.[MsgDeliveryMethodCodeId] is null
)


------------------------------------- End Interviewer Push ------------------------------------- 


select * from MsgTemplate
