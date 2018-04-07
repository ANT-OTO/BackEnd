
declare @pAPIMessageKey nvarchar(50) = 'CommunityProviderMessage'
declare @pAPIMessageValue nvarchar(max) = 'From Other Company'
declare @pAPIMessageId int = 0
declare @pTime datetime = getutcdate()
-- Try to insert API Message  
INSERT INTO dbo.APIMessage 
(
	[MessageKey],
	[MessageValue],
	[Deleted],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
) 
select a.*,@pTime,@pTime,1,1
from (
	select @pAPIMessageKey as [MessageKey],@pAPIMessageValue  as [MessageValue], 0 as [Deleted]
) a left join dbo.APIMessage z on a.MessageKey = z.MessageKey
where z.Id is null

if(@@ROWCOUNT > 0)
begin
	select @pAPIMessageId = SCOPE_IDENTITY()
end
else 
begin
	update dbo.APIMessage 
	set [MessageValue] = @pAPIMessageValue,
		[Deleted] = 0,
		[LastUpdate] = @pTime,
		[LastUpdateBy] = 1,
		[LastUpdateByType] = 1
	where MessageKey = @pAPIMessageKey
	select @pAPIMessageId = Id
	from dbo.APIMessage
	where MessageKey = @pAPIMessageKey
end

if(isnull(@pAPIMessageId,0) <= 0)
begin
	print 'Insert fail'
	return
end
--System Language 2
declare @pSystemLanguageId int = 2
select  @pAPIMessageValue = N'其他来源'

INSERT INTO dbo.APIMessageY 
(
	[APIMessageId],
	[SystemLanguageId],
	[MessageValue],
	[Deleted],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
) 
select a.*,@pTime,@pTime,1,1
from (
	select @pAPIMessageId as [APIMessageId],@pSystemLanguageId as [SystemLanguageId],@pAPIMessageValue  as [MessageValue], 0 as [Deleted]
) a left join dbo.APIMessageY z on a.[APIMessageId] = z.[APIMessageId] and a.SystemLanguageId = z.SystemLanguageId and a.Deleted = z.Deleted
where z.Id is null

if(@@ROWCOUNT = 0)
begin
	update dbo.APIMessageY 
	set [MessageValue] = @pAPIMessageValue,
		[SystemLanguageId] = @pSystemLanguageId,
		[Deleted] = 0,
		[LastUpdate] = @pTime,
		[LastUpdateBy] = 1,
		[LastUpdateByType] = 1
	where APIMessageId = @pAPIMessageId
	
end
GO  

select * from APIMessage order by Id desc
select * from APIMessageY order by Id desc