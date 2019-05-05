
--drop function [dbo].[tfnCompanyAddressGet]


/****** Object:  UserDefinedFunction [dbo].[tfnCompanyAddressGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnCompanyAddressGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnCompanyAddressGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnCompanyAddressGet] 
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


print 'Update function [dbo].[tfnCompanyAddressGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnCompanyAddressGet]
(
	@pCompanyId int
)  
RETURNS @Ret_Table Table
(
	[CompanyFromAddressId] int NOT NULL,
	[CompanyId] int NOT NULL,
	[AddressId] int NOT NULL,
	[ContactPersonFirstName] nvarchar(256) NOT NULL,
	[ContactPersonLastName] nvarchar(256) NOT NULL,
	[ContactPersonPhoneNumber] nvarchar(256) NOT NULL,
	[ContactPersonPhoneNumberCountryId] int NOT NULL,
	[Address1] [nvarchar](256) NOT NULL,
	[Address2] [nvarchar](256) NOT NULL,
	[City] [nvarchar](128) NOT NULL,
	[District] [nvarchar](128) NULL,
	[State] [nvarchar](128) NOT NULL,
	[Zip] [nvarchar](32) NOT NULL,
	[CountryId] [int] NOT NULL,
	[DefaultShipping] bit NOT NULL
)
as
Begin 
	
	insert into @Ret_Table
	(
		[CompanyFromAddressId],
		[CompanyId],
		[AddressId],
		[ContactPersonFirstName],
		[ContactPersonLastName],
		[ContactPersonPhoneNumber],
		[ContactPersonPhoneNumberCountryId],
		[Address1] ,
		[Address2] ,
		[City] ,
		[District],
		[State],
		[Zip],
		[CountryId],
		[DefaultShipping]
	)
	select	b.Id, a.Id, c.Id, b.ContactPersonFirstName, b.ContactPersonLastName,
			b.ContactPersonPhoneNumber, b.ContactPersonPhoneNumberCountryId,
			c.Address1, c.Address2, c.City,
			c.District, c.[State], c.Zip, c.CountryId, case when z.Id is null then 0 else 1 end
	from Company a (nolock)
		inner join CompanyFromAddress b (nolock) on a.Id = b.CompanyId
		inner join [Address] c (nolock) on b.AddressId = c.Id
		left join CompanyFromAddressDefault z (nolock) on b.Id = z.CompanyFromAddressId and z.Available = 1
	where a.Id = @pCompanyId
	and b.Available = 1
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnCompanyAddressGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

