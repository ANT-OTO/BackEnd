
declare @pPushEnginePropertyId int = 0
declare @pPushEngineId int = 2
exec  [dbo].[sp_PushEngineProperty_Set] 
	2,
	'Engine',
	'PostURL',
	'https://fcm.googleapis.com/fcm/send',
	@pPushEnginePropertyId OUTPUT

exec  [dbo].[sp_PushEngineProperty_Set] 
	2,
	'Engine',
	'Authorization',
	'23425sagsdf',
	@pPushEnginePropertyId OUTPUT

exec  [dbo].[sp_PushEngineProperty_Set] 
	2,
	'Engine',
	'SenderId',
	'23524345',
	@pPushEnginePropertyId OUTPUT

select * from WEYI.dbo.PushEngine
select * from WEYI.dbo.PushEngineProperty where PushEngineId = 2