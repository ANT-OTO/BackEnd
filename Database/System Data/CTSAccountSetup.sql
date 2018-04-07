declare @pTime datetime = getutcdate()
declare @pExternalThirdPartyInterpreterGroupId int = 0
insert into [dbo].[ExternalThirdPartyInterpreterGroup]
(
	[ThirdPartyName],
	[CreateDate],
	[LastUpdate]
)
select	a.ThirdPartyName,
		a.CreateDate,
		a.LastUpdate
from 
(
	select	'CTS' as [ThirdPartyName],
		@pTime as [CreateDate],
		@pTime as [LastUpdate]
) a
left join [dbo].[ExternalThirdPartyInterpreterGroup] z (nolock) on a.ThirdPartyName = z.ThirdPartyName
where z.Id is null

if(@@ROWCOUNT > 0)
begin
	select @pExternalThirdPartyInterpreterGroupId = SCOPE_IDENTITY()
end
else
begin
	select @pExternalThirdPartyInterpreterGroupId = a.Id
	from dbo.ExternalThirdPartyInterpreterGroup a (nolock)
	where a.ThirdPartyName = 'CTS'
end

if(isnull(@pExternalThirdPartyInterpreterGroupId, 0) = 0)
begin
	print 'Error 1'
	return
end


----------------------------------------------------------------------------
declare @pClientId nvarchar(128) = '24250'
declare @pPwd nvarchar(128) = 'Hot$3uTku'
declare @pAccountDescription nvarchar(128) = 'Regular'
declare @pAccountName nvarchar(128) = 'Regular'

insert into [dbo].[ExternalThirdPartyInterpreterGroupAccount]
(
	[ExternalThirdPartyInterpreterGroupId],
	[AccountName] ,
	[AccountId] ,
	[AccountPwd] ,
	[AccountDescription],
	[LastRetrievedDate],
	[Deleted],
	[CreateDate] ,
	[LastUpdate] 
)
select	a.ExternalThirdPartyInterpreterGroupId,
		a.AccountName,
		a.AccountId,
		a.AccountPwd,
		a.AccountDescription,
		a.LastRetrievedDate,
		a.Deleted,
		a.CreateDate,
		a.LastUpdate
from 
(
	select	@pExternalThirdPartyInterpreterGroupId as [ExternalThirdPartyInterpreterGroupId],
			@pAccountName as [AccountName] ,
			@pClientId as [AccountId] ,
			@pPwd as [AccountPwd] ,
			@pAccountDescription as [AccountDescription],
			NULL as [LastRetrievedDate],
			0 as [Deleted],
			@pTime as [CreateDate] ,
			@pTime as [LastUpdate] 
) a
left join [dbo].[ExternalThirdPartyInterpreterGroupAccount] z (nolock) on a.ExternalThirdPartyInterpreterGroupId = z.ExternalThirdPartyInterpreterGroupId
																	and a.AccountId = z.AccountId
where z.Id is null

if(@@ROWCOUNT > 0)
begin
	print 'Client: ' + @pClientId + ' is created' 
end
else
begin
	update a
	set a.AccountName = @pAccountName,
		a.AccountDescription = @pAccountDescription,
		a.AccountPwd = @pPwd,
		a.LastRetrievedDate = NULL,
		a.LastUpdate = @pTime,
		a.Deleted = 0
	from [dbo].[ExternalThirdPartyInterpreterGroupAccount] a
	where a.ExternalThirdPartyInterpreterGroupId = @pExternalThirdPartyInterpreterGroupId
	and a.AccountId = @pClientId

	print 'Client: ' + @pClientId + ' is updated' 
end


----------------------------------------------------------------------------
select @pClientId = '24235'
select @pPwd = 'hot$3uTku'
select @pAccountDescription = 'Medical'
select @pAccountName = 'Medical'

insert into [dbo].[ExternalThirdPartyInterpreterGroupAccount]
(
	[ExternalThirdPartyInterpreterGroupId],
	[AccountName] ,
	[AccountId] ,
	[AccountPwd] ,
	[AccountDescription],
	[LastRetrievedDate],
	[Deleted],
	[CreateDate] ,
	[LastUpdate] 
)
select	a.ExternalThirdPartyInterpreterGroupId,
		a.AccountName,
		a.AccountId,
		a.AccountPwd,
		a.AccountDescription,
		a.LastRetrievedDate,
		a.Deleted,
		a.CreateDate,
		a.LastUpdate
from 
(
	select	@pExternalThirdPartyInterpreterGroupId as [ExternalThirdPartyInterpreterGroupId],
			@pAccountName as [AccountName] ,
			@pClientId as [AccountId] ,
			@pPwd as [AccountPwd] ,
			@pAccountDescription as [AccountDescription],
			NULL as [LastRetrievedDate],
			0 as [Deleted],
			@pTime as [CreateDate] ,
			@pTime as [LastUpdate] 
) a
left join [dbo].[ExternalThirdPartyInterpreterGroupAccount] z (nolock) on a.ExternalThirdPartyInterpreterGroupId = z.ExternalThirdPartyInterpreterGroupId
																	and a.AccountId = z.AccountId
where z.Id is null

if(@@ROWCOUNT > 0)
begin
	print 'Client: ' + @pClientId + ' is created' 
end
else
begin
	update a
	set a.AccountName = @pAccountName,
		a.AccountDescription = @pAccountDescription,
		a.AccountPwd = @pPwd,
		a.LastRetrievedDate = NULL,
		a.LastUpdate = @pTime,
		a.Deleted = 0
	from [dbo].[ExternalThirdPartyInterpreterGroupAccount] a
	where a.ExternalThirdPartyInterpreterGroupId = @pExternalThirdPartyInterpreterGroupId
	and a.AccountId = @pClientId

	print 'Client: ' + @pClientId + ' is updated' 
end



----------------------------------------------------------------------------
select @pClientId = '24422'
select @pPwd = 'hot$3uTkv'
select @pAccountDescription = 'CA Prison'
select @pAccountName = 'CA Prison'

insert into [dbo].[ExternalThirdPartyInterpreterGroupAccount]
(
	[ExternalThirdPartyInterpreterGroupId],
	[AccountName] ,
	[AccountId] ,
	[AccountPwd] ,
	[AccountDescription],
	[LastRetrievedDate],
	[Deleted],
	[CreateDate] ,
	[LastUpdate] 
)
select	a.ExternalThirdPartyInterpreterGroupId,
		a.AccountName,
		a.AccountId,
		a.AccountPwd,
		a.AccountDescription,
		a.LastRetrievedDate,
		a.Deleted,
		a.CreateDate,
		a.LastUpdate
from 
(
	select	@pExternalThirdPartyInterpreterGroupId as [ExternalThirdPartyInterpreterGroupId],
			@pAccountName as [AccountName] ,
			@pClientId as [AccountId] ,
			@pPwd as [AccountPwd] ,
			@pAccountDescription as [AccountDescription],
			NULL as [LastRetrievedDate],
			0 as [Deleted],
			@pTime as [CreateDate] ,
			@pTime as [LastUpdate] 
) a
left join [dbo].[ExternalThirdPartyInterpreterGroupAccount] z (nolock) on a.ExternalThirdPartyInterpreterGroupId = z.ExternalThirdPartyInterpreterGroupId
																	and a.AccountId = z.AccountId
where z.Id is null

if(@@ROWCOUNT > 0)
begin
	print 'Client: ' + @pClientId + ' is created' 
end
else
begin
	update a
	set a.AccountName = @pAccountName,
		a.AccountDescription = @pAccountDescription,
		a.AccountPwd = @pPwd,
		a.LastRetrievedDate = NULL,
		a.LastUpdate = @pTime,
		a.Deleted = 0
	from [dbo].[ExternalThirdPartyInterpreterGroupAccount] a
	where a.ExternalThirdPartyInterpreterGroupId = @pExternalThirdPartyInterpreterGroupId
	and a.AccountId = @pClientId

	print 'Client: ' + @pClientId + ' is updated' 
end


----------------------------------------------------------------------------
select @pClientId = '24974'
select @pPwd = 'hot$3uTkv'
select @pAccountDescription = 'US Only'
select @pAccountName = 'US Only'

insert into [dbo].[ExternalThirdPartyInterpreterGroupAccount]
(
	[ExternalThirdPartyInterpreterGroupId],
	[AccountName] ,
	[AccountId] ,
	[AccountPwd] ,
	[AccountDescription],
	[LastRetrievedDate],
	[Deleted],
	[CreateDate] ,
	[LastUpdate] 
)
select	a.ExternalThirdPartyInterpreterGroupId,
		a.AccountName,
		a.AccountId,
		a.AccountPwd,
		a.AccountDescription,
		a.LastRetrievedDate,
		a.Deleted,
		a.CreateDate,
		a.LastUpdate
from 
(
	select	@pExternalThirdPartyInterpreterGroupId as [ExternalThirdPartyInterpreterGroupId],
			@pAccountName as [AccountName] ,
			@pClientId as [AccountId] ,
			@pPwd as [AccountPwd] ,
			@pAccountDescription as [AccountDescription],
			NULL as [LastRetrievedDate],
			0 as [Deleted],
			@pTime as [CreateDate] ,
			@pTime as [LastUpdate] 
) a
left join [dbo].[ExternalThirdPartyInterpreterGroupAccount] z (nolock) on a.ExternalThirdPartyInterpreterGroupId = z.ExternalThirdPartyInterpreterGroupId
																	and a.AccountId = z.AccountId
where z.Id is null

if(@@ROWCOUNT > 0)
begin
	print 'Client: ' + @pClientId + ' is created' 
end
else
begin
	update a
	set a.AccountName = @pAccountName,
		a.AccountDescription = @pAccountDescription,
		a.AccountPwd = @pPwd,
		a.LastRetrievedDate = NULL,
		a.LastUpdate = @pTime,
		a.Deleted = 0
	from [dbo].[ExternalThirdPartyInterpreterGroupAccount] a
	where a.ExternalThirdPartyInterpreterGroupId = @pExternalThirdPartyInterpreterGroupId
	and a.AccountId = @pClientId

	print 'Client: ' + @pClientId + ' is updated' 
end



select * from [ExternalThirdPartyInterpreterGroupAccount]

select * from [ExternalThirdPartyInterpreterGroup]