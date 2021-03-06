--select * from [CodeList] where Category = 'DPTEscalateReason'
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
			when CodeId = 1 and a.Category = N'DPTEscalateReason' then N'操作失误，不是有意想接'			-- 1	Accept By Mistake
			when CodeId = 2 and a.Category = N'DPTEscalateReason' then N'内容不是很清楚'		-- 2	Content not very clear
			when CodeId = 6 and a.Category = N'DPTEscalateReason' then N'翻译不出来'		-- 6	Not able to handle
			when CodeId = 999 and a.Category = N'DPTEscalateReason' then N'其他'	-- 999	Other


		else N''
		end as CodeShort
	from [CodeList] a
	) a where a.CodeShort <> ''

-- select * from CodeList where Category = N'DPTEscalateReason'
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

select a.* from CodeListY a inner join CodeList b on a.CodeListId = b.Id where b.Category = 'DPTEscalateReason'