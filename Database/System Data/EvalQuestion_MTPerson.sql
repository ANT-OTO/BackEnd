--select * from [EvalQuestion]


declare @TblContent as Table
(
	[ToType] nvarchar(32) NOT NULL,
	[QuestionSetNumber] int NOT NULL,
	[QuestionNumber] int NOT NULL,
	[Question] [nvarchar](max) NOT NULL
)	

declare @QuestionSetNumber int = 0


----------------------------------------------- To MTPerson ------------------------------------------------------------------------

select @QuestionSetNumber = 0
select @QuestionSetNumber = max([QuestionSetNumber]) --+ 1		-- if need update, we need establish a new question set
from EvalQuestion a
where a.[ToType] = 'MTPerson'

select @QuestionSetNumber = isnull(@QuestionSetNumber, 0) + 1

insert into @TblContent
([ToType], [QuestionSetNumber], [QuestionNumber], [Question])
select a.*
from (
	select 'MTPerson' as [ToType], @QuestionSetNumber as [QuestionSetNumber], 1 as [QuestionNumber], N'How is the quality of translation?' as [Question]
	
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



----------------------------------------------- End To MTPerson ------------------------------------------------------------------------

select * from EvalQuestion