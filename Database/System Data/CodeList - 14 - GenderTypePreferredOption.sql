--select * from [CodeList] where Category = 'GenderTypePreferredOption'
--select * from [CodeListY]
--select * from SystemLanguage

declare @TblCode as Table
(
	[CodeListId] [int] NOT NULL,
	[CodeShort] [nvarchar](1024) NOT NULL,
	[CodeLong] [nvarchar](1024) NOT NULL,
	[SystemLanguageId] int NOT NULL
)	

declare @SystemLanguageId int
select @SystemLanguageId = Id
--select *
from SystemLanguage where Id = 14

insert into @TblCode
(CodeListId, CodeShort, CodeLong, SystemLanguageId)
select a.CodeListId, a.CodeShort, a.CodeLong, @SystemLanguageId
from (
	select a.*
	from (
	select a.Id as CodeListId,
		case 
			when CodeId = 1 and a.Category = N'GenderTypePreferredOption' then N'Bevorzugt männlich'			-- 1	Male Preferred
			when CodeId = 2 and a.Category = N'GenderTypePreferredOption' then N'Bevorzugt weiblich'			-- 2	Female Preferred
			when CodeId = 3 and a.Category = N'GenderTypePreferredOption' then N'Nur männlich'			-- 3	Male Only
			when CodeId = 4 and a.Category = N'GenderTypePreferredOption' then N'Nur weiblich'			-- 4	Female Only	
			when CodeId = 5 and a.Category = N'GenderTypePreferredOption' then N'Keine Präferenz'				-- 5	No Preference


		else N''
		end as CodeShort,
		case 
			when CodeId = 1 and a.Category = N'GenderTypePreferredOption' then N'Bevorzugt männlich'			-- 1	Male Preferred
			when CodeId = 2 and a.Category = N'GenderTypePreferredOption' then N'Bevorzugt weiblich'			-- 2	Female Preferred
			when CodeId = 3 and a.Category = N'GenderTypePreferredOption' then N'Nur männlich'			-- 3	Male Only
			when CodeId = 4 and a.Category = N'GenderTypePreferredOption' then N'Nur weiblich'			-- 4	Female Only	
			when CodeId = 5 and a.Category = N'GenderTypePreferredOption' then N'Keine Präferenz'				-- 5	No Preference


		else N''
		end as CodeLong
	from [CodeList] a
	) a where a.CodeShort <> ''

-- select * from CodeList where Category = N'GenderTypePreferredOption'
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

select a.* from CodeListY a inner join CodeList b on a.CodeListId = b.Id where b.Category = 'GenderTypePreferredOption' order by b.SortOrder

go

