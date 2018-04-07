
IF  NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[ti_PersonSessionMobileValidation]'))
Begin

	print 'Create TRIGGER dbo.ti_PersonSessionMobileValidation ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create TRIGGER dbo.ti_PersonSessionMobileValidation
		   ON  dbo.PersonSessionMobileValidation
		   AFTER DELETE
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)


End


print 'Update ti_PersonSessionMobileValidation ... ' + convert(varchar, getdate())



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Description:	<Trigger to track the history>
-- =============================================
ALTER TRIGGER dbo.ti_PersonSessionMobileValidation
   ON  dbo.PersonSessionMobileValidation
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here

	-- select top 1 * from NotificationText
	-- select top 1 * from PersonSession
	-- select top 1 * from MobileValidation
	-- select top 1 * from MsgTemplate

	declare @SystemLanguageId int = 0
	select @SystemLanguageId = b.SystemLanguageId
	from inserted a
		inner join PersonSession b (nolock) on a.PersonSessionId = b.Id

	Insert into NotificationText
	(MsgTemplateId, SystemLanguageId, RegionId, MobilePhone, Msg, RefTable, RefId, [Sent], [Status], CreateDate, LastUpdate)
	select d.[MsgTemplateId], @SystemLanguageId, c.RegionId, c.MobilePhone, Replace(d.[Template], '$Code$', c.ValidationCode)
		, 'PersonSessionMobileValidation', a.Id, 0, 'New', GETUTCDATE(), GETUTCDATE()
	from inserted a
		inner join PersonSession b (nolock) on a.PersonSessionId = b.Id
		inner join MobileValidation c (nolock) on a.MobileValidationId = c.Id
		inner join dbo.tfnMsgTemplate(@SystemLanguageId) d on d.[MsgDeliveryMethodCodeId] = 4			-- Text
																										-- select * from CodeList where Category = 'MsgDeliveryMethod'
		left join NotificationText z (nolock) on z.RefTable = 'PersonSessionMobileValidation' and z.RefId = a.Id
	where z.Id is null

END
GO


drop trigger ti_PersonSessionMobileValidation
GO

