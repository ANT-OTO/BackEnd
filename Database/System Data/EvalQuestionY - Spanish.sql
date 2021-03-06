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
from SystemLanguage where [Name] = N'Español'

insert into @TblCode
(EvalQuestionId, [Question], SystemLanguageId)
select a.EvalQuestionId, a.[Question], @SystemLanguageId
from (
	select a.*
	from (
	select a.Id as EvalQuestionId,
		case 

			when ToType = 'Person' and a.Question = 'Voice Quality' then N'La calidad del sonido ( 5 : Muy bueno, 1 : pobres)'
			when ToType = 'Person' and a.Question = 'Service Quality' then N'Calidad de Servicio ( 5 : Muy bueno, 1 : pobres)'
			when ToType = 'Provider' and a.Question = 'Voice Quality' then N'La calidad del sonido ( 5 : Muy bueno, 1 : pobres)'
			when ToType = 'Provider' and a.Question = 'How much would you like to provide service to this client again? (5: most, 1: least)' then N'Evaluación de los clientes ( 5 : bueno, 1 : pobres)'
			when ToType = 'Interviewer' and a.Question = 'Voice Quality' then N'La calidad del sonido ( 5 : Muy bueno, 1 : pobres)'
			when ToType = 'Interviewer' and a.Question = 'Overall Proficiency Level (3 is the minimal required for providing service to clients)' then N'Capacidad de los candidatos seleccionados para hacer el trabajo ( 5 : completo , 3 : competencia básica )'
			when ToType = 'Candidate' and a.Question = 'Voice Quality' then N'La calidad del sonido ( 5 : Muy bueno, 1 : pobres)'
			when ToType = 'Candidate' and a.Question = 'Interview Experience (5: Excellment, 1: Needs a lot of improvement)' then N'La sensación general ( 5 : grande, 1 : muchas áreas de mejora )'

		else N''
		end as Question
	from [EvalQuestion] a
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