use weyi

--drop function [dbo].[tfn_AuthenrizeHelperPhoneInfoGet]


/****** Object:  UserDefinedFunction [dbo].[tfn_AuthenrizeHelperPhoneInfoGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfn_AuthenrizeHelperPhoneInfoGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfn_AuthenrizeHelperPhoneInfoGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfn_AuthenrizeHelperPhoneInfoGet] 
		(
    @pSystemLanguageId int,
	@pCategory [nvarchar](128)
		)
		RETURNS @Ret_Table Table
(	
	[CodeId] [int] NOT NULL,
	[CodeShort] [nvarchar](30) NOT NULL,
	[CodeLong] [nvarchar](256) NOT NULL,
	[SortOrder] [varchar](8) NOT NULL
)
		AS  
		BEGIN 
			return 
		END
	'


	exec (@create)
END


print 'Update function [dbo].[tfn_AuthenrizeHelperPhoneInfoGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfn_AuthenrizeHelperPhoneInfoGet]
(
    @pVOSPhoneRequestId int 
)  
RETURNS @Ret_Table Table
(
	[Id] int identity(1,1) NOT NULL,
	[PhoneNumber] nvarchar(128) NOT NULL,
	[RegionCode] nvarchar(64) NOT NULL,
	[Digits] nvarchar(128) NULL,
	[WaitingTime] int NULL
)
as
Begin 

	declare @pTime datetime = getutcdate()
	declare @pBillCompanyProductId int,
			@pBillCompanyProductIVRManagementId int
	select	@pBillCompanyProductId = b.Id,
			@pBillCompanyProductIVRManagementId = c.Id
	from WEYI.dbo.VOSPhoneNumber a (nolock)
		inner join WEYI.dbo.VOSPhoneRequest a1 (nolock) on a1.VOSPhoneNumberId = a.Id
		inner join WEYIMgr.dbo.BillCompanyProduct b (nolock) on a.BillCompanyProductId = b.Id
		inner join WEYIMgr.dbo.BillCompanyProductIVRManagement c (nolock) on b.Id = c.BillCompanyProductId
	where a1.Id = @pVOSPhoneRequestId
		and a.CompanyId = b.CompanyId
		and c.PhoneInEnabled = 1

	insert into @Ret_Table
	(
		[PhoneNumber],
		[RegionCode],
		[Digits],
		[WaitingTime]
	)
	select b.PhoneNumber, b1.RegionCode, c.SignalCommand,c.WaitingTime
	from WEYIMgr.dbo.BillCompanyProductIVRManagement a (nolock)
		inner join WEYIMgr.dbo.BillCompanyProductIVRManagementAuthenrizationPhone b (nolock) on a.Id = b.BillCompanyProductIVRManagementId
		inner join WEYI.dbo.Region b1 (nolock) on b.RegionId = b1.Id
		left join WEYIMgr.dbo.BillCompanyProductIVRManagementAuthenrizationPhoneSignalDemand c (nolock) on b.Id = c.BillCompanyProductIVRManagementPhoneId
	where a.BillCompanyProductId = @pBillCompanyProductId
		and a.Id = @pBillCompanyProductIVRManagementId
		and b.Deleted = 0
		order by case when c.Id is null then a.Id else c.SortOrder end
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfn_AuthenrizeHelperPhoneInfoGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

