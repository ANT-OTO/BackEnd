
IF  NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[ti_Provider]'))
Begin

	print 'Create TRIGGER dbo.ti_Provider ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create TRIGGER dbo.ti_Provider
		   ON  dbo.Provider
		   AFTER DELETE
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)


End


print 'Update ti_Provider ... ' + convert(varchar, getdate())



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Description:	<Trigger to track the history>
-- =============================================
ALTER TRIGGER dbo.ti_Provider
   ON  dbo.Provider
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here

	-- select top 10 * from ProviderSchedule
	-- select * from CodeList where Category = 'ProviderScheduleAvailable'
	-- select * from CodeList where Category = 'ProviderScheduleDaysType'
	-- select * from CodeList where Category = 'ProviderScheduleHoursType'

	declare @ProviderId int = 0
	

	if( not exists(
		select * from inserted a 
			inner join WEYIMgr.dbo.LSPProvider b (nolock) on b.ProviderId = a.Id ) )
	begin
		return
	end

	select @ProviderId = a.Id
	from inserted a 

	

	Insert into ProviderSchedule
	(ProviderId,EffBegin,EffEnd,AvailableCodeId,DaysTypeCodeId,HoursTypeCodeId,FromTime,ToTime,CreateDate)
	select @ProviderId as ProviderId, '1/1/2016', '12/31/9999', 3, 1, 1, '1/1/2016', '1/1/2016', GETUTCDATE()

	Insert into ProviderSchedule
	(ProviderId,EffBegin,EffEnd,AvailableCodeId,DaysTypeCodeId,HoursTypeCodeId,FromTime,ToTime,CreateDate)
	select @ProviderId as ProviderId, '1/1/2016', '12/31/9999', 1, 1, 4, '1/1/2016 08:00', '1/1/2016 22:00', GETUTCDATE()

	declare @BeginDate datetime = dateadd(day, -1, getutcdate())
	exec [dbo].[sp_ProviderSchedule7Day_Generate] @ProviderId, @BeginDate

	declare @NetTimeZoneId nvarchar(128) = [dbo].[sfnProviderNetTimeZoneId](@ProviderId)
	update a
	set a.EffUtcBegin = WEYITool.dbo.sfnGetUTCTime(@NetTimeZoneId, a.EffBegin),
		a.EffUtcEnd = WEYITool.dbo.sfnGetUTCTime(@NetTimeZoneId, a.EffEnd),
		a.LastUpdate = GETUTCDATE()
	from ProviderSchedule7Days a 
		inner join ProviderSchedule b (nolock) on a.ProviderScheduleId = b.Id
	where b.ProviderId = @ProviderId and (a.EffUtcBegin is null or a.EffUtcEnd is null)
END
GO


--drop trigger ti_Provider
GO

