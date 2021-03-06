--select * from LockManager

declare @TblCode as Table
(
	[LockName] [nvarchar](128) NOT NULL,
	[Description] [nvarchar](256) NOT NULL,
	[Locked] [bit] NOT NULL,
	[Change] [bit] NOT NULL
)	

------------------------------------- Begin  ------------------------------------- 
--delete [LockManager] where LockName = ''
delete @TblCode

insert into @TblCode	
(LockName, [Description], Locked, Change)
select a.*
from (
	select 'ScheduleUpdater' as LockName, 'Lock to update expiring Providers Schedule every day' as [Description], 0 as Locked, 0 as Change
	
	UNION
	
	select 'TextMsgSend' as LockName, 'Lock to send text message' as [Description], 0 as Locked, 0 as Change

	UNION

	select 'InterviewMgr' as LockName, 'Lock to manage interviews for the new providers' as [Description], 0 as Locked, 0 as Change

) a 

insert into [LockManager]
(LockName, [Description], Locked, Change, CreateDate, LastUpdate)
select a.*, GETUTCDATE(), GETUTCDATE()
from @TblCode a left join  [LockManager] z on a.LockName = z.LockName
where z.Id is null

update a
set a.[Description] = b.[Description], a.Locked = b.Locked, a.Change = b.Change
from [LockManager] a inner join  @TblCode b on a.LockName = b.LockName 

delete 
--select *
from [LockManager] where Id in (
	select Id
	from LockManager a left join @TblCode b on a.LockName = b.LockName
	where b.LockName is null
)

select * from LockManager

------------------------------------- End  ------------------------------------- 
