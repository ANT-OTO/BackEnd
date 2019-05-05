IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_GetLock]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_GetLock] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_GetLock] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_GetLock] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_GetLock] 
	@pLockName nvarchar(128),
	@pSuccess bit OUTPUT
AS

SET NOCOUNT ON

select @pSuccess = 1

insert into LockManager
(LockName, [Description], Locked, Change, CreateDate, LastUpdate)
select a.*
from (
	select @pLockName as LockName, '' as [Description], 1 as Locked, 
		0 as Change, GETUTCDATE() as CreateDate, GETUTCDATE() as LastUpdate
) a left join LockManager z on a.LockName = z.LockName
where z.Id is null


if( @@rowcount = 1 )
begin 
	return
end

update a
set a.Locked = 1, a.Change = 0
from LockManager a
where a.LockName = @pLockName and a.Locked = 0

if ( @@ROWCOUNT = 0)
begin
	select @pSuccess = 0
end	

return

GO


