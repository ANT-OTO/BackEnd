--select * from [CodeList] where Category = 'DPTType'
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
			when CodeId = 4 then N'直接翻译：声音'	-- 4	Direct Translation: Audio
			when CodeId = 5 then N'直接翻译：文字'	-- 5	Direct Translation: Text
			when CodeId = 6 then N'直接翻译：图片'	-- 6	Direct Translation: Image
			when CodeId = 7 then N'直接翻译'			-- 7	Direct Translation
			when CodeId = 8 then N'直接翻译：声音/图片'	-- 8	Direct Translation: Image/Audio


		else N''
		end as CodeShort
	from [CodeList] a where a.Category = N'DPTType'
	) a where a.CodeShort <> ''

-- select * from CodeList where Category = N'DPTType'
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

select a.* from CodeListY a inner join CodeList b on a.CodeListId = b.Id where b.Category = 'DPTType'