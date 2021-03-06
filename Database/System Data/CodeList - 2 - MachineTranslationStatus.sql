--select * from [CodeList] where Category = 'MachineTranslationStatus'
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
			when CodeId = 1 and a.Category = N'MachineTranslationStatus' then N'正在图像识别'		-- 1	Image Recognition In Process...
			when CodeId = 2 and a.Category = N'MachineTranslationStatus' then N'正在语音识别'		-- 2	Audio Recognition In Process...
			when CodeId = 3 and a.Category = N'MachineTranslationStatus' then N'正在机器自动翻译'	-- 3	Machine Translation In Process...
			when CodeId = 4 and a.Category = N'MachineTranslationStatus' then N'正在合成语音'		-- 4	Text To Speech In Process...
			when CodeId = 5 and a.Category = N'MachineTranslationStatus' then N'重新识别已经启动'		-- 5	Re-process started
			when CodeId = 91 and a.Category = N'MachineTranslationStatus' then N'图像识别没有成功'		-- 91	Image Recognition Failed
			when CodeId = 92 and a.Category = N'MachineTranslationStatus' then N'语音识别没有成功'		-- 92	Audio Recognition Failed
			when CodeId = 93 and a.Category = N'MachineTranslationStatus' then N'机器自动翻译没有成功'		-- 93	Machine Translation Failed
			when CodeId = 94 and a.Category = N'MachineTranslationStatus' then N'合成语音没有成功'		-- 94	Text To Speech Failed

		else N''
		end as CodeShort
	from [CodeList] a
	) a where a.CodeShort <> ''

-- select * from CodeList where Category = N'MachineTranslationStatus'
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

select a.* from CodeListY a inner join CodeList b on a.CodeListId = b.Id where b.Category = 'MachineTranslationStatus'