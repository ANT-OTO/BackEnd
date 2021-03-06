--select * from CodeList

declare @TblCode as Table
(
	[Category] [nvarchar](128) NOT NULL,
	[CodeId] [int] NOT NULL,
	[CodeShort] [nvarchar](64) NOT NULL,
	[CodeLong] [nvarchar](256) NOT NULL,
	[SortOrder] [varchar](8) NOT NULL,
	[Available] [bit] NOT NULL
)	



------------------------------------- Begin RequestWaitingMsg ------------------------------------- 
--delete [CodeList] where Category = 'RequestWaitingMsg'

delete @TblCode

insert into @TblCode	
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from (
	select 'RequestWaitingMsg' as Category, 1 as CodeId, '<= 15' as CodeShort, 'Matching the best interpreter for you. Please wait...' as CodeLong, '001' as SortOrder, 1 as Available
	
	UNION
	
	select 'RequestWaitingMsg' as Category, 2 as CodeId, '15 ~ 30' as CodeShort, 'Notifying interpreters. Waiting for response...' as CodeLong, '002' as SortOrder, 1 as Available

	UNION
	
	select 'RequestWaitingMsg' as Category, 3 as CodeId, '30 ~ 60' as CodeShort, 'Getting live interpreter occasionally could take more than 1 minute...' as CodeLong, '003' as SortOrder, 1 as Available

	UNION
	
	select 'RequestWaitingMsg' as Category, 4 as CodeId, '> 60' as CodeShort, 'We are working hard on it. Please be patient...' as CodeLong, '004' as SortOrder, 1 as Available

) a 

insert into [CodeList]
(Category, CodeId, CodeShort, CodeLong, SortOrder, Available)
select a.*
from @TblCode a left join  [CodeList] z on a.Category = z.Category and a.CodeId = z.CodeId 
where z.Id is null

update a
set a.CodeShort = b.CodeShort, a.CodeLong = b.CodeLong, a.SortOrder = b.SortOrder, a.Available = b.Available
from [CodeList] a inner join  @TblCode b on a.Category = b.Category and a.CodeId = b.CodeId 

delete 
--select * from
CodeListY where CodeListId in (select Id from CodeList where Category = 'RequestWaitingMsg' and CodeId not in (select CodeId from @TblCode))
delete CodeList where Category = 'RequestWaitingMsg' and CodeId not in (select CodeId from @TblCode)

select * from CodeList where Category = 'RequestWaitingMsg'


------------------------------------- End RequestWaitingMsg ------------------------------------- 




delete 
--select * from
CodeListY where CodeListId not in (select Id from CodeList)

go


-----------------------------------------------------------System Language Id: 2 Begin ---------------------------------------------------------------------------------------------------

--select * from [CodeList] where Category = 'RequestWaitingMsg'
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
			when CodeId = 1 and a.Category = N'RequestWaitingMsg' then N'正在为您匹配最合适的翻译，请稍候...'	
			when CodeId = 2 and a.Category = N'RequestWaitingMsg' then N'正在联系翻译，等候答复...'		
			when CodeId = 3 and a.Category = N'RequestWaitingMsg' then N'找到合适的真人翻译偶尔可能需要超过1分钟...'
			when CodeId = 4 and a.Category = N'RequestWaitingMsg' then N'我们正在努力，请耐心等候...'


		else N''
		end as CodeShort,
		case 
			when CodeId = 1 and a.Category = N'RequestWaitingMsg' then N'正在为您匹配最合适的翻译，请稍候...'	
			when CodeId = 2 and a.Category = N'RequestWaitingMsg' then N'正在联系翻译，等候答复...'		
			when CodeId = 3 and a.Category = N'RequestWaitingMsg' then N'找到合适的真人翻译偶尔可能需要超过1分钟...'
			when CodeId = 4 and a.Category = N'RequestWaitingMsg' then N'我们正在努力，请耐心等候...'


		else N''
		end as CodeLong
	from [CodeList] a
	) a where a.CodeShort <> ''

-- select * from CodeList where Category = N'RequestWaitingMsg'
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

select a.* from CodeListY a inner join CodeList b on a.CodeListId = b.Id where b.Category = 'RequestWaitingMsg' order by b.SortOrder

go


-----------------------------------------------------------System Language Id: 2 End -----------------------------------------------------------------------------------------------------


-----------------------------------------------------------System Language Id: 14 Begin ---------------------------------------------------------------------------------------------------

--select * from [CodeList] where Category = 'RequestWaitingMsg'
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
from SystemLanguage where Id = 14

insert into @TblCode
(CodeListId, CodeShort, CodeLong, SystemLanguageId)
select a.CodeListId, a.CodeShort, a.CodeLong, @SystemLanguageId
from (
	select a.*
	from (
	select a.Id as CodeListId,
		case 
			when CodeId = 1 and a.Category = N'RequestWaitingMsg' then N'Wir suchen den besten Dometscher für Sie. Bitte warten...'	
			when CodeId = 2 and a.Category = N'RequestWaitingMsg' then N'Dolmetscher werden benachrichtigt. Warten auf Rückmeldung...'		
			when CodeId = 3 and a.Category = N'RequestWaitingMsg' then N'Der Aufbau einer Verbindung zu einem Dolmetscher kann gelegentlich über eine Minute dauern...'
			when CodeId = 4 and a.Category = N'RequestWaitingMsg' then N'Wir arbeiten daran. Bitte haben Sie Geduld...'


		else N''
		end as CodeShort,
		case 
			when CodeId = 1 and a.Category = N'RequestWaitingMsg' then N'Wir suchen den besten Dometscher für Sie. Bitte warten...'	
			when CodeId = 2 and a.Category = N'RequestWaitingMsg' then N'Dolmetscher werden benachrichtigt. Warten auf Rückmeldung...'		
			when CodeId = 3 and a.Category = N'RequestWaitingMsg' then N'Der Aufbau einer Verbindung zu einem Dolmetscher kann gelegentlich über eine Minute dauern...'
			when CodeId = 4 and a.Category = N'RequestWaitingMsg' then N'Wir arbeiten daran. Bitte haben Sie Geduld...'


		else N''
		end as CodeLong
	from [CodeList] a
	) a where a.CodeShort <> ''

-- select * from CodeList where Category = N'RequestWaitingMsg'
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

select a.* from CodeListY a inner join CodeList b on a.CodeListId = b.Id where b.Category = 'RequestWaitingMsg' order by b.SortOrder

go


-----------------------------------------------------------System Language Id: 14 End -----------------------------------------------------------------------------------------------------

