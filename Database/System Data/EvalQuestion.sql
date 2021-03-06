--select * from [EvalQuestion]


declare @TblContent as Table
(
	[ToType] nvarchar(32) NOT NULL,
	[QuestionSetNumber] int NOT NULL,
	[QuestionNumber] int NOT NULL,
	[Question] [nvarchar](max) NOT NULL
)	

declare @QuestionSetNumber int = 0


----------------------------------------------- To Person ------------------------------------------------------------------------

select @QuestionSetNumber = 1
select @QuestionSetNumber = max([QuestionSetNumber]) --+ 1		-- if need update, we need establish a new question set
from EvalQuestion a
where a.[ToType] = 'Person'

select @QuestionSetNumber = isnull(@QuestionSetNumber, 1)

insert into @TblContent
([ToType], [QuestionSetNumber], [QuestionNumber], [Question])
select a.*
from (
	select 'Person' as [ToType], @QuestionSetNumber as [QuestionSetNumber], 1 as [QuestionNumber], N'Voice Quality' as [Question]

	UNION
	
	select 'Person' as [ToType], @QuestionSetNumber as [QuestionSetNumber], 2 as [QuestionNumber], N'Service Quality' as [Question]
		
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

----------------------------------------------- End To Person ------------------------------------------------------------------------



----------------------------------------------- To Provider ------------------------------------------------------------------------

select @QuestionSetNumber = 1
select @QuestionSetNumber = max([QuestionSetNumber]) --+ 1		-- if need update, we need establish a new question set
from EvalQuestion a
where a.[ToType] = 'Provider'

select @QuestionSetNumber = isnull(@QuestionSetNumber, 1)

insert into @TblContent
([ToType], [QuestionSetNumber], [QuestionNumber], [Question])
select a.*
from (
	select 'Provider' as [ToType], @QuestionSetNumber as [QuestionSetNumber], 1 as [QuestionNumber], N'Voice Quality' as [Question]

	UNION
	
	select 'Provider' as [ToType], @QuestionSetNumber as [QuestionSetNumber], 2 as [QuestionNumber], N'How much would you like to provide service to this client again? (5: most, 1: least)' as [Question]
		
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

----------------------------------------------- End To Provider ------------------------------------------------------------------------


----------------------------------------------- To Interviewer ------------------------------------------------------------------------

select @QuestionSetNumber = 1
select @QuestionSetNumber = max([QuestionSetNumber]) --+ 1		-- if need update, we need establish a new question set
from EvalQuestion a
where a.[ToType] = 'Interviewer'

select @QuestionSetNumber = isnull(@QuestionSetNumber, 1)

insert into @TblContent
([ToType], [QuestionSetNumber], [QuestionNumber], [Question])
select a.*
from (
	select 'Interviewer' as [ToType], @QuestionSetNumber as [QuestionSetNumber], 1 as [QuestionNumber], N'Voice Quality' as [Question]

	UNION
	
	select 'Interviewer' as [ToType], @QuestionSetNumber as [QuestionSetNumber], 2 as [QuestionNumber], N'Overall Proficiency Level (3 is the minimal required for providing service to clients)' as [Question]
		
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

----------------------------------------------- End To Interviewer ------------------------------------------------------------------------


----------------------------------------------- To Candidate ------------------------------------------------------------------------

select @QuestionSetNumber = 1
select @QuestionSetNumber = max([QuestionSetNumber]) --+ 1		-- if need update, we need establish a new question set
from EvalQuestion a
where a.[ToType] = 'Candidate'

select @QuestionSetNumber = isnull(@QuestionSetNumber, 1)

insert into @TblContent
([ToType], [QuestionSetNumber], [QuestionNumber], [Question])
select a.*
from (
	select 'Candidate' as [ToType], @QuestionSetNumber as [QuestionSetNumber], 1 as [QuestionNumber], N'Voice Quality' as [Question]

	UNION
	
	select 'Candidate' as [ToType], @QuestionSetNumber as [QuestionSetNumber], 2 as [QuestionNumber], N'Interview Experience (5: Excellment, 1: Needs a lot of improvement)' as [Question]
		
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

----------------------------------------------- End To Candidate ------------------------------------------------------------------------

select * from EvalQuestion