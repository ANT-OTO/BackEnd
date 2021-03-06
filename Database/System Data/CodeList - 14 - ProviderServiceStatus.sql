--select * from [CodeList] where Category = 'ProviderServiceStatus'
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
from SystemLanguage where Id = 14

insert into @TblCode
(CodeListId, CodeShort, CodeLong, SystemLanguageId)
select a.CodeListId, a.CodeShort, a.CodeShort as CodeLong, @SystemLanguageId
from (
	select a.*
	from (
	select a.Id as CodeListId,
		case 
			when CodeId = 1 then N'Ausstehend'		-- 1	Pending Interview
			when CodeId = 2 then N'Bestätigt'		-- 2	Approved
			when CodeId = 3 then N'Nicht Bestätigt'	-- 3	Denied
			when CodeId = 4 then N'In der Ausbildung'	-- 4	In Training
			when CodeId = 5 then N'Warten Sie Texter'		-- 5	Pending Paper Work
			when CodeId = 998 then N'Suspendiert'		-- 998	Suspended
			when CodeId = 999 then N'Annulliert'		-- 999	Cancelled


		else N''
		end as CodeShort
	from [CodeList] a where a.Category = N'ProviderServiceStatus'
	) a where a.CodeShort <> ''

-- select * from CodeList where Category = N'ProviderServiceStatus'
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

select a.* from CodeListY a inner join CodeList b on a.CodeListId = b.Id where b.Category = 'ProviderServiceStatus'

go

