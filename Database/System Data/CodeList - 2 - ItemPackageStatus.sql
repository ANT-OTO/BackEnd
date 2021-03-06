--select * from [CodeList] where Category = 'ItemPackageStatus'
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
from SystemLanguage where Id = 2

insert into @TblCode
(CodeListId, CodeShort, CodeLong, SystemLanguageId)
select a.CodeListId, a.CodeShort, a.CodeLong, @SystemLanguageId
from (
	select a.*
	from (
	select a.Id as CodeListId,
		case 
			when CodeId = 1 and a.Category = N'ItemPackageStatus' then N'已提交'			-- 2	Content not clear
			when CodeId = 2 and a.Category = N'ItemPackageStatus' then N'正在审核'		-- 6	Wrong language
			when CodeId = 96 and a.Category = N'ItemPackageStatus' then N'已通过'		-- 7	
			when CodeId = 97 and a.Category = N'ItemPackageStatus' then N'已取消'	-- 999	Other
			when CodeId = 98 and a.Category = N'ItemPackageStatus' then N'已驳回'	-- 9999	You have reached your daily limit for Fong Live. Please use Fong Auto. 
			

		else N''
		end as CodeShort,
		case 
			when CodeId = 1 and a.Category = N'ItemPackageStatus' then N'已提交'			-- 2	Content not clear
			when CodeId = 2 and a.Category = N'ItemPackageStatus' then N'正在审核'		-- 6	Wrong language
			when CodeId = 96 and a.Category = N'ItemPackageStatus' then N'已通过'		-- 7	
			when CodeId = 97 and a.Category = N'ItemPackageStatus' then N'已取消'	-- 999	Other
			when CodeId = 98 and a.Category = N'ItemPackageStatus' then N'已驳回'	-- 9999	You have reached your daily limit for Fong Live. Please use Fong Auto. 
			

		else N''
		end as CodeLong
	from [CodeList] a
	) a where a.CodeShort <> ''

-- select * from CodeList where Category = N'ItemPackageStatus'
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

select a.* from CodeListY a inner join CodeList b on a.CodeListId = b.Id where b.Category = 'ItemPackageStatus' order by b.SortOrder