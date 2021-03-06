--select * from [CodeList] where Category = 'DPTStatus'
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
			when CodeId = 1 then N'正在发送翻译请求'			-- 1	New
			when CodeId = 2 then N'正在发送翻译请求'		-- 2	Sent To Provider
			when CodeId = 3 then N'译员已接受任务'			-- 3	Accepted by Provider
			when CodeId = 4 then N'正在为您翻译'				-- 4	Translation In Process
			when CodeId = 5 then N'翻译完成'				-- 5	Finished
			when CodeId = 91 then N'用户取消了翻译请求。'	-- 91	Cancelled By User
			when CodeId = 92 then N'系统取消了翻译请求。'	-- 92	Cancelled by System
			when CodeId = 93 then N'翻译任务正在转给更高级别译员。'		-- 93	Escalated by Provider
			when CodeId = 94 then N'抱歉，您的翻译请求无法处理。'	-- 94	Denied by Provider
			when CodeId = 95 then N'抱歉，您的翻译请求无法处理。'	-- 95	Denied by System
			when CodeId = 96 then N'翻译任务正在转给更高级别译员。'		-- 96	Escalated by System


		else N''
		end as CodeShort
	from [CodeList] a where Category = N'DPTStatus'
	) a where a.CodeShort <> ''

-- select * from CodeList where Category = N'DPTStatus'
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

select a.* from CodeListY a inner join CodeList b on a.CodeListId = b.Id where b.Category = 'DPTStatus'