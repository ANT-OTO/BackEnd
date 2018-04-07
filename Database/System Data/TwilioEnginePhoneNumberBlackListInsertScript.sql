
declare @pFromCaller nvarchar(256) = '+100000000'
declare @pToCaller nvarchar(256) = null

declare @pTime datetime = getutcdate()
update a
set a.Available = 1,
	a.LastUpdate = 0
from WEYI.dbo.TwilioEnginePhoneNumberBlackList a
where a.FromCaller = @pFromCaller
		and ((a.ToNumber is null and @pToCaller is null) or (a.ToNumber = @pToCaller)) and a.Available = 0


insert into WEYI.[dbo].[TwilioEnginePhoneNumberBlackList]
(
	[FromCaller],
	[ToNumber],
	[Available],
	[CreateDate],
	[LastUpdate]
)
select a.*
from
(
select	@pFromCaller as [FromCaller] ,
		@pToCaller as [ToNumber],
		1 as [Available],
		@pTime as [CreateDate],
		@pTime as [LastUpdate]
) a
left join WEYI.dbo.TwilioEnginePhoneNumberBlackList z (nolock) on a.FromCaller = z.FromCaller
		and ((z.ToNumber is null) or (a.ToNumber = z.ToNumber)) and a.Available = z.Available
where z.Id is null

select * from WEYI.[dbo].[TwilioEnginePhoneNumberBlackList]


