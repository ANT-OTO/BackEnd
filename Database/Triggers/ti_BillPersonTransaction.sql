
IF  NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[ti_BillPersonTransaction]'))
Begin

	print 'Create TRIGGER dbo.ti_BillPersonTransaction ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create TRIGGER dbo.ti_BillPersonTransaction
		   ON  dbo.BillPersonTransaction
		   AFTER DELETE
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)


End


print 'Update ti_BillPersonTransaction ... ' + convert(varchar, getdate())



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Description:	<Trigger to track the history>
-- =============================================
ALTER TRIGGER dbo.ti_BillPersonTransaction
   ON  dbo.BillPersonTransaction
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here


	declare @PersonId int = 0
	
	select @PersonId = a.PersonId from inserted a 

	declare @Balance decimal(14, 2) = 0
	select @Balance = dbo.[sfn_BillPersonTransaction_GetBalance](@PersonId)

	update a
	set a.Balance = @Balance
		, a.RequiredPaymentNow = dbo.[sfn_BillPersonTransaction_GetPaymentAmount](@PersonId, @Balance)
		, a.LastUpdate = GETUTCDATE()
	--select *
	from BillPersonInfo a 
	where a.PersonId = @PersonId
END
GO


--drop trigger ti_BillPersonTransaction
GO

