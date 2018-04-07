declare @Time datetime = getutcdate()


declare @pProviderId int = 0
DECLARE TurnOnProviderOnSchedule_Cursor CURSOR FOR 
	select d.Id from Provider d (nolock)
	inner join (
		select a.ProviderId, max(b.Id) as ProviderSchedule7DaysId
		from ProviderSchedule a (nolock)
			inner join ProviderSchedule7Days b (nolock) on a.Id = b.ProviderScheduleId
		where @Time between b.EffUtcBegin and b.EffUtcEnd	
		group by a.ProviderId
	) e on d.Id = e.ProviderId
	inner join ProviderSchedule7Days f (nolock) on e.ProviderSchedule7DaysId = f.Id
where f.AvailableCodeId in (
						--select * from CodeList where Category = 'ProviderScheduleAvailable'
						1,		-- Available
						2		-- Available as Alternative
					)
	and WEYI.dbo.[sfnProviderOnLineStatusCheck](d.Id) = 0
	OPEN TurnOnProviderOnSchedule_Cursor

	FETCH NEXT FROM TurnOnProviderOnSchedule_Cursor INTO @pProviderId


	WHILE @@FETCH_STATUS = 0 
	BEGIN
		print @pProviderId
		declare @pProviderOnLineStatusId int = null
		EXEC	[sp_ProviderOnLineStatusSet] 
		@pProviderId,
		1,			-- Online,Offline
		null,
		null , -- only for other reason
		null,  -- Unit is Minutes
		null,  --select * from CodeList where Category = 'ProviderVideoOption'
		@pProviderOnLineStatusId output

		FETCH NEXT FROM TurnOnProviderOnSchedule_Cursor INTO @pProviderId
	END

	CLOSE TurnOnProviderOnSchedule_Cursor
	DEALLOCATE TurnOnProviderOnSchedule_Cursor





