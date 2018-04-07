IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_BillProviderStatement_List]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_BillProviderStatement_List] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_BillProviderStatement_List] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_BillProviderStatement_List] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER  procedure [dbo].[sp_BillProviderStatement_List] 
	@pProviderId int
AS
set nocount on
begin
	select a.StartDate,
		a.EndDate,
		a.IsCurrent
	from dbo.BillProviderStatement a (nolock)
	where a.ProviderId = @pProviderId

	return @@rowcount
end

