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
from SystemLanguage where Id= 2 -- [Name] = N'简体中文'

insert into @TblCode
(EvalQuestionId, [Question], SystemLanguageId)
select a.EvalQuestionId, a.[Question], @SystemLanguageId
from (
	select a.*
	from (
	select a.Id as EvalQuestionId,
		case 

			when a.QuestionNumber = 1 then N'请您对此次机器翻译质量做出您的评价。您的意见对我们很重要。'

		else N''
		end as Question
	--select * 
	from [EvalQuestion] a
	where QuestionSetNumber = (
			select max(QuestionSetNumber)
			from [EvalQuestion]
			where ToType = 'MTPerson'
		) and ToType = 'MTPerson'
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

select * from EvalQuestion a left join [EvalQuestionY] z on a.Id = z.EvalQuestionId and z.SystemLanguageId = @SystemLanguageId 
where z.Id is null

select * from EvalQuestionY