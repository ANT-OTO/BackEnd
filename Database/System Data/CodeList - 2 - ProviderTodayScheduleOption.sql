--select * from [CodeList] where Category = 'ProviderTodayScheduleOption'
--select * from [CodeListY]
--select * from SystemLanguage

declare @TblCode as Table
(
	[CodeListId] [int] NOT NULL,
	[CodeShort] [nvarchar](64) NOT NULL,
	[CodeLong] [nvarchar](256) NOT NULL,
	[SystemLanguageId] int NOT NULL
)	

declare @SystemLanguageId int
select @SystemLanguageId = Id
--select *
from SystemLanguage where Id = 2

insert into @TblCode
(CodeListId, CodeShort, CodeLong, SystemLanguageId)
select a.CodeListId, a.CodeShort, a.CodeShort as CodeLong, @SystemLanguageId
from (
	select a.*
	from (
	select a.Id as CodeListId,
		case 
			when CodeId = 1 then N'我今天工作时间可以服务'		-- 1	I am available today
			when CodeId = 2 then N'我今天剩下时间可以服务'		-- 2	I am available for the rest of today
			when CodeId = 3 then N'我今天工作时间可以替补服务'	-- 3	I serve as alternative today
			when CodeId = 4 then N'我今天剩下时间可以替补服务'	-- 4	I serve as alternative for the rest of today
			when CodeId = 5 then N'我今天剩下时间不能工作'		-- 5	I am not available for the rest of today


		else N''
		end as CodeShort
	from [CodeList] a where a.Category = N'ProviderTodayScheduleOption'
	) a where a.CodeShort <> ''

-- select * from CodeList where Category = N'ProviderTodayScheduleOption'
) a

insert into [CodeListY]
(CodeListId, CodeShort, CodeLong, SystemLanguageId, CreateDate)
select a.CodeListId, a.CodeShort, a.CodeShort as CodeLong, @SystemLanguageId, GETDATE() as CreateDate
from @TblCode a left join  [CodeListY] z on a.CodeListId = z.CodeListId and z.SystemLanguageId = @SystemLanguageId 
where z.Id is null

update a
set a.CodeShort = b.CodeShort, a.CodeLong = b.CodeLong
from [CodeListY] a inner join @TblCode b on a.CodeListId = b.CodeListId and a.SystemLanguageId = b.SystemLanguageId

delete CodeListY where CodeListId not in (select Id from CodeList)

select a.* from CodeListY a inner join CodeList b on a.CodeListId = b.Id where b.Category = 'ProviderTodayScheduleOption'

go

