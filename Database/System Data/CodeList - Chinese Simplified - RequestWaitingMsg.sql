--select * from [CodeList] where Category = 'RequestWaitingMsg'
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
from SystemLanguage where [Name] = N'简体中文'

insert into @TblCode
(CodeListId, CodeShort, CodeLong, SystemLanguageId)
select a.CodeListId, a.CodeShort, a.CodeShort as CodeLong, @SystemLanguageId
from (
	select a.*
	from (
	select a.Id as CodeListId,
		case 
			when CodeId = 1 and a.Category = N'RequestWaitingMsg' then N'正在为您匹配最合适的翻译，请稍候...'
			when CodeId = 2 and a.Category = N'RequestWaitingMsg' then N'正在联系翻译，等候答复...'
			when CodeId = 3 and a.Category = N'RequestWaitingMsg' then N'找到合适的真人翻译可能需要1到3分钟...'
			when CodeId = 4 and a.Category = N'RequestWaitingMsg' then N'我们正在努力，请耐心等候...'

		else N''
		end as CodeShort
	from [CodeList] a
	) a where a.CodeShort <> ''

	
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

select a.* from CodeListY a inner join CodeList b on a.CodeListId = b.Id where b.Category = 'RequestWaitingMsg'