--select * from [CodeList] where Category = 'DPTDenyReason'
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
			when CodeId = 2 and a.Category = N'DPTDenyReason' then N'内容不清楚'			-- 2	Content not clear
			when CodeId = 6 and a.Category = N'DPTDenyReason' then N'语言不对'		-- 6	Wrong language
			when CodeId = 7 and a.Category = N'DPTDenyReason' then N'涉及违法信息'		-- 7	
			when CodeId = 8 and a.Category = N'DPTDenyReason' then N'太长了。需要专业版。'		-- 7	
			when CodeId = 999 and a.Category = N'DPTDenyReason' then N'其他'	-- 999	Other
			when CodeId = 9999 and a.Category = N'DPTDenyReason' then N'您今天的真人翻译额度已达到。请使用智能翻译。'	-- 9999	You have reached your daily limit for Fong Live. Please use Fong Auto. 
			when CodeId = 10000 and a.Category = N'DPTDenyReason' then N'我们不能服务这个请求。原因：'	-- 10000	This cannot be serviced. Reason: 


		else N''
		end as CodeShort,
		case 
			when CodeId = 2 and a.Category = N'DPTDenyReason' then N'内容不清楚'			-- 2	Content not clear
			when CodeId = 6 and a.Category = N'DPTDenyReason' then N'语言不对'		-- 6	Wrong language
			when CodeId = 7 and a.Category = N'DPTDenyReason' then N'此条请求涉及违法信息，多次发送，我们将会封停您的使用权'		-- 7	
			when CodeId = 8 and a.Category = N'DPTDenyReason' then N'小芳真人翻译目前只针对短句或日常用语的翻译。对于较为复杂的图片和较长的文本，敬请期待小芳专业翻译。谢谢！'		-- 7	
			when CodeId = 999 and a.Category = N'DPTDenyReason' then N'其他'	-- 999	Other
			when CodeId = 9999 and a.Category = N'DPTDenyReason' then N'您今天的真人翻译额度已达到。请使用智能翻译。'	-- 9999	You have reached your daily limit for Fong Live. Please use Fong Auto. 
			when CodeId = 10000 and a.Category = N'DPTDenyReason' then N'我们不能服务这个请求。原因： '	-- 10000	This cannot be serviced. Reason: 


		else N''
		end as CodeLong
	from [CodeList] a
	) a where a.CodeShort <> ''

-- select * from CodeList where Category = N'DPTDenyReason'
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

select a.* from CodeListY a inner join CodeList b on a.CodeListId = b.Id where b.Category = 'DPTDenyReason' order by b.SortOrder