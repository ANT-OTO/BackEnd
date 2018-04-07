--select * from Provider 
declare @pProviderId int = 0,
	@IntervalSec1 int = 3,
	@DTMFDigits1 nvarchar(64) = '1234',
	@IntervalSec2 int = 7,
	@DTMFDigits2 nvarchar(64) = '57',
	@pTime datetime = getutcdate()
delete from dbo.[OPIProviderSignalCommand]
where ProviderId = @pProviderId
--DTMF 1
insert into [dbo].[OPIProviderSignalCommand]
(
		[ProviderId] ,
		[SortOrder] ,
		[SignalCommand], -- '0-9 , #,*,+' or use command elements to replace '#FromLanguage#' 
		[WaitingTime],  -- Seconds Unit
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
)
select @pProviderId as [ProviderId],
		1 as [SortOrder],
		@DTMFDigits1 as [SignalCommand],
		@IntervalSec1 as [WaitingTime],
		@pTime as [CreateDate],
		@pTime as [LastUpdate],
		1 as [LastUpdateBy],
		1 as [LastUpdateByType]

--DTMF 2
insert into [dbo].[OPIProviderSignalCommand]
(
		[ProviderId] ,
		[SortOrder] ,
		[SignalCommand], -- '0-9 , #,*,+' or use command elements to replace '#FromLanguage#' 
		[WaitingTime],  -- Seconds Unit
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
)
select @pProviderId as [ProviderId],
		2 as [SortOrder],
		@DTMFDigits2 as [SignalCommand],
		@IntervalSec2 as [WaitingTime],
		@pTime as [CreateDate],
		@pTime as [LastUpdate],
		1 as [LastUpdateBy],
		1 as [LastUpdateByType]

SELECT * FROM [OPIProviderSignalCommand]















