--select * from [CodeList]
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
			when CodeId = 1 and a.Category = N'RequestSituation' then N'我在餐馆'
			when CodeId = 2 and a.Category = N'RequestSituation' then N'我在景点'
			when CodeId = 3 and a.Category = N'RequestSituation' then N'我在酒店'
			when CodeId = 4 and a.Category = N'RequestSituation' then N'我在机场'
			when CodeId = 5 and a.Category = N'RequestSituation' then N'我在出租车'
			when CodeId = 6 and a.Category = N'RequestSituation' then N'我在乘车'
			when CodeId = 999 and a.Category = N'RequestSituation' then N'其他'


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

select a.* from CodeListY a inner join CodeList b on a.CodeListId = b.Id where b.Category = 'RequestSituation'