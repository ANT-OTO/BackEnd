/****** Object:  UserDefinedFunction [dbo].[sfn_AuthenrizeNumDigitsGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sfn_AuthenrizeNumDigitsGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	print 'Create function [dbo].[sfn_AuthenrizeNumDigitsGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[sfn_AuthenrizeNumDigitsGet] 
		(
		)
		returns  bit

		AS  
		BEGIN 
			declare @Ret_value bit
			return @Ret_value
		END
	'


	exec (@create)
END


print 'Update function [dbo].[sfn_AuthenrizeNumDigitsGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[sfn_AuthenrizeNumDigitsGet]
(
	@pPhoneNumber nvarchar(256)
)
RETURNS  int
as
Begin 
	declare @Rtn_Value int = 0
	declare @pTime datetime = getutcdate()
	declare @pBillCompanyProductId int,
			@pBillCompanyProductIVRManagementId int
	select	@pBillCompanyProductId = b.Id,
			@pBillCompanyProductIVRManagementId = c.Id
	from WEYI.dbo.VOSPhoneNumber a (nolock)
		inner join WEYIMgr.dbo.BillCompanyProduct b (nolock) on a.BillCompanyProductId = b.Id
		inner join WEYIMgr.dbo.BillCompanyProductIVRManagement c (nolock) on b.Id = c.BillCompanyProductId
	where a.PhoneNumber = @pPhoneNumber
		and a.CompanyId = b.CompanyId
		and c.PhoneInEnabled = 1
	select @Rtn_value = max(len(c.PIN))
	from WEYIMgr.dbo.BillCompanyProduct a (nolock)
		inner join WEYIMgr.dbo.BillClientProduct b (nolock) on a.Id = b.BillCompanyProductId and b.Deleted = 0
		inner join WEYIMgr.dbo.BillCompanyClientProductIVRPinInfo c (nolock) on c.BillClientProductId = b.Id and c.Available = 1
	where a.Id = @pBillCompanyProductId
	return isnull(@Rtn_Value,0)
End
/*

--select top 10 * from WEYI.dbo.Person
select [dbo].[sfn_AuthenrizeNumDigitsGet](3824)
*/

GO


