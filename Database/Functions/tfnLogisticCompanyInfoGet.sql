
--drop function [dbo].[tfnLogisticCompanyInfoGet]


/****** Object:  UserDefinedFunction [dbo].[tfnLogisticCompanyInfoGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnLogisticCompanyInfoGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnLogisticCompanyInfoGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnLogisticCompanyInfoGet] 
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


print 'Update function [dbo].[tfnLogisticCompanyInfoGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnLogisticCompanyInfoGet]
(
	@pCompanyId int
)  
RETURNS @Ret_Table Table
(
	CompanyId int,
	UserId int,
	UserLoginName nvarchar(256),
	CompanyCode nvarchar(256),
	CompanyName nvarchar(256),
	Email nvarchar(256),
	PhoneNumber nvarchar(256),
	PhoneNumberCountryId int,
	ContactFirstName nvarchar(256),
	ContactLastName nvarchar(256),
	Address1 nvarchar(256),
	Address2 nvarchar(256) NULL,
	City nvarchar(256),
	District nvarchar(256) NULL,
	[State] nvarchar(256),
	Zip nvarchar(64),
	Fax nvarchar(256),
	CountryId int,
	Available bit
)
as
Begin 
	
	insert into @Ret_Table
	(
		CompanyId,
		UserId,
		UserLoginName,
		CompanyCode,
		CompanyName,
		Email,
		PhoneNumber,
		PhoneNumberCountryId,
		ContactFirstName,
		ContactLastName,
		Address1,
		Address2,
		City,
		District,
		[State],
		Zip,
		Fax,
		CountryId,
		Available
	)
	select	distinct a.CompanyId, 0, '', b.CompanyCode, b.CompanyName, b.Email,
			b2.PhoneNumber, b2.CountryId, b.ContactFirstName, b.ContactLastName, b1.Address1, b1.Address2, b1.City,
			b1.District, b1.[State], b1.Zip, b.Fax, b1.CountryId, b.Active
	from CompanyLogisticCompany a (nolock)
		inner join Company b (nolock) on a.CompanyId = b.Id
		inner join [Address] b1 (nolock) on b.AddressId = b1.Id
		inner join [PhoneNumber] b2 (nolock) on b.PhoneNumberId = b2.Id
		--inner join CompanyUser c (nolock) on b.Id = c.CompanyId
		--inner join [User] d (nolock) on c.UserId = d.Id
		--inner join SecRoleUser e (nolock) on d.Id = e.UserId and e.Available = 1
		--inner join SecRole f (nolock) on e.SecRoleId = f.Id and f.RoleName = N'管理员'
	where a.CustomerCompanyId = @pCompanyId
	or a.CompanyId = @pCompanyId
	order by a.CompanyId desc
	
	
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnLogisticCompanyInfoGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

