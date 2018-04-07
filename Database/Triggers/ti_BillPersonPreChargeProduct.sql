
IF  NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[ti_BillPersonPreChargeProduct]'))
Begin

	print 'Create TRIGGER dbo.ti_BillPersonPreChargeProduct ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create TRIGGER dbo.ti_BillPersonPreChargeProduct
		   ON  dbo.BillPersonPreChargeProduct
		   AFTER DELETE
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)


End


print 'Update ti_BillPersonPreChargeProduct ... ' + convert(varchar, getdate())



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Description:	<Trigger to track the history>
-- =============================================
ALTER TRIGGER dbo.ti_BillPersonPreChargeProduct
   ON  dbo.BillPersonPreChargeProduct
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	insert BillPersonInfo
	(PersonId, IsIndividualBilling, Balance, RequiredPaymentNow, CreateDate, LastUpdate, LastUpdateBy, LastUpdateByType)
	select a.PersonId, [dbo].[sfn_BillPersonIsIndividualBilling](a.PersonId), 0, 0, getutcdate(), getutcdate(), a.LastUpdateBy, a.LastUpdateByType
	from inserted a left join BillPersonInfo z (nolock) on a.PersonId = z.PersonId
	where z.Id is null

END
GO


--drop trigger ti_BillPersonPreChargeProduct
GO

