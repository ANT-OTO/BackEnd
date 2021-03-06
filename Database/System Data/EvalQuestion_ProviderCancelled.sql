--select * from [EvalQuestion]


declare @TblContent as Table
(
	[ToType] nvarchar(32) NOT NULL,
	[QuestionSetNumber] int NOT NULL,
	[QuestionNumber] int NOT NULL,
	[Question] [nvarchar](max) NOT NULL
)	

declare @QuestionSetNumber int = 0


select *
from EvalQuestion a
where a.[ToType] = 'ProviderCancelled' and a.QuestionSetNumber = (select max([QuestionSetNumber]) from EvalQuestion a where a.[ToType] = 'ProviderCancelled')
order by a.QuestionNumber


----------------------------------------------- To ProviderCancelled ------------------------------------------------------------------------

select @QuestionSetNumber = 1
select @QuestionSetNumber = max([QuestionSetNumber]) --+ 1		-- if need update, we need establish a new question set
from EvalQuestion a
where a.[ToType] = 'ProviderCancelled'

select @QuestionSetNumber = isnull(@QuestionSetNumber, 1)

insert into @TblContent
([ToType], [QuestionSetNumber], [QuestionNumber], [Question])
select a.*
from (
	select 'ProviderCancelled' as [ToType], @QuestionSetNumber as [QuestionSetNumber], 1 as [QuestionNumber], N'Client cancelled request. No rating needed.' as [Question]
) a 


insert into [EvalQuestion]
([ToType], [QuestionSetNumber], [QuestionNumber], [Question], CreateDate)
select a.*, GETDATE()
from @TblContent a left join  [EvalQuestion] z on a.[ToType] = z.[ToType] and a.[QuestionSetNumber] = z.[QuestionSetNumber] and a.[QuestionNumber] = z.[QuestionNumber]
where z.Id is null

update a
set a.[Question] = b.[Question]
from [EvalQuestion] a inner join  @TblContent b on a.[ToType] = b.[ToType] and a.[QuestionSetNumber] = b.[QuestionSetNumber] and a.[QuestionNumber] = b.[QuestionNumber]
where Not ( a.[Question] = b.[Question])

----------------------------------------------- End To ProviderCancelled ------------------------------------------------------------------------



-----------------------------------------------------------------------------------------------------------------------------------


--select * from [EvalQuestion]
--select * from [EvalQuestionY]
--select * from SystemLanguage

declare @TblCode as Table
(
	[EvalQuestionId] [int] NOT NULL,
	[SystemLanguageId] [int] NOT NULL,
	[Question] [nvarchar](max) NOT NULL
)	

declare @SystemLanguageId int
select @SystemLanguageId = Id
--select *
from SystemLanguage where [Name] = N'简体中文'

delete @TblCode

insert into @TblCode
(EvalQuestionId, [Question], SystemLanguageId)
select a.EvalQuestionId, a.[Question], @SystemLanguageId
from (
	select a.*
	from (
	select a.Id as EvalQuestionId,
		case 

			when ToType = 'ProviderCancelled' and a.QuestionNumber = 1 then N'客户取消了请求。不用打分'

		else N''
		end as Question
	--select * 
	from [EvalQuestion] a
	where a.QuestionSetNumber = @QuestionSetNumber
	) a where a.Question <> ''

	
) a

insert into [EvalQuestionY]
(EvalQuestionId, [Question], SystemLanguageId, CreateDate)
select a.EvalQuestionId, a.[Question], @SystemLanguageId, GETDATE() as CreateDate
from @TblCode a left join  [EvalQuestionY] z on a.EvalQuestionId = z.EvalQuestionId and z.SystemLanguageId = @SystemLanguageId 
where z.Id is null

update a
set a.[Question] = b.[Question]
from [EvalQuestionY] a inner join @TblCode b on a.EvalQuestionId = b.EvalQuestionId and a.SystemLanguageId = b.SystemLanguageId

delete EvalQuestionY where EvalQuestionId not in (select Id from EvalQuestion)

--select * from EvalQuestion a left join [EvalQuestionY] z on a.Id = z.EvalQuestionId and z.SystemLanguageId = @SystemLanguageId 
--where z.Id is null

--select * from EvalQuestionY where SystemLanguageId = @SystemLanguageId

select * from EvalQuestion a inner join EvalQuestionY b on a.Id = b.EvalQuestionId and b.SystemLanguageId = @SystemLanguageId
where a.ToType = 'ProviderCancelled' and a.QuestionSetNumber = @QuestionSetNumber
order by a.QuestionNumber

-----------------------------------------------------------------------------------------------------------------------------------

select @SystemLanguageId = Id
--select *
from SystemLanguage where [Name] = N'繁體中文'

delete @TblCode
insert into @TblCode
(EvalQuestionId, [Question], SystemLanguageId)
select a.EvalQuestionId, a.[Question], @SystemLanguageId
from (
	select a.*
	from (
	select a.Id as EvalQuestionId,
		case 

			when ToType = 'ProviderCancelled' and a.QuestionNumber = 1 then N'客戶取消了請求。不用打分'

		else N''
		end as Question
	--select * 
	from [EvalQuestion] a 
	where a.QuestionSetNumber = @QuestionSetNumber
	) a where a.Question <> ''

	
) a


insert into [EvalQuestionY]
(EvalQuestionId, [Question], SystemLanguageId, CreateDate)
select a.EvalQuestionId, a.[Question], @SystemLanguageId, GETDATE() as CreateDate
from @TblCode a left join  [EvalQuestionY] z on a.EvalQuestionId = z.EvalQuestionId and z.SystemLanguageId = @SystemLanguageId 
where z.Id is null

update a
set a.[Question] = b.[Question]
from [EvalQuestionY] a inner join @TblCode b on a.EvalQuestionId = b.EvalQuestionId and a.SystemLanguageId = b.SystemLanguageId

delete EvalQuestionY where EvalQuestionId not in (select Id from EvalQuestion)


-----------------------------------------------------------------------------------------------------------------------------------


select * from EvalQuestion a inner join EvalQuestionY b on a.Id = b.EvalQuestionId and b.SystemLanguageId = @SystemLanguageId
where a.ToType = 'ProviderCancelled' and a.QuestionSetNumber = @QuestionSetNumber
order by a.QuestionNumber