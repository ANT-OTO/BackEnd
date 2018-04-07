
-- select * from [FileStructureMgr]
insert into [FileStructureMgr]
(RootFolder, Effective, CreateDate)
select a.*, GETDATE(), GETDATE()
from (
	select distinct a.*
	from (
		select N'C:\Work\WEYI\zFolder' as RootFolder
	
	) a
	
	
) a left join  [FileStructureMgr] z on a.RootFolder = z.RootFolder
where z.Id is null

select * from FileStructureMgr