declare @pTime datetime = getutcDate()
declare @pStartTime datetime
select @pStartTime = DATEADD(HOUR,8,CreateDate)
from WEYI.dbo.MarketActivation
order by Id desc
select @pStartTime = CAST(@pStartTime AS DATE)
print @pStartTime
declare @pTempTable table(
	[MarketCode] nvarchar(50),
	[ActivationCount] int,
	[ActivationDate] datetime
)
while(@pStartTime < DATEADD(HOUR,8,@pTime))
begin
	insert into @pTempTable
	([MarketCode],[ActivationCount],[ActivationDate])
	select MarketCode as [MarketCode], Count(*) as [ActivedCount],@pStartTime as [ActivationDate]
	from WEYI.dbo.MarketActivation
	where DATEADD(HOUR,8,CreateDate) >= @pStartTime
	and DATEADD(HOUR,8,CreateDate) < DATEADD(HOUR,24,@pStartTime)
	group by MarketCode
	select @pStartTime = DATEADD(HOUR,24,@pStartTime)
end

select * from @pTempTable