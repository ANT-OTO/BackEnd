
--drop function [dbo].[tfnCustomerAddressGet]


/****** Object:  UserDefinedFunction [dbo].[tfnCustomerAddressGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnCustomerAddressGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnCustomerAddressGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnCustomerAddressGet] 
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


print 'Update function [dbo].[tfnCustomerAddressGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnCustomerAddressGet]
(
	@pCustomerId int
)  
RETURNS @Ret_Table Table
(
	[Customer_AddressId] int NOT NULL,
	[CustomerId] int NOT NULL,
	[AddressId] int NOT NULL,
	[ContactPersonFirstName] nvarchar(256) NOT NULL,
	[ContactPersonLastName] nvarchar(256) NOT NULL,
	[ContactPersonPhoneNumber] nvarchar(256) NOT NULL,
	[ContactPersonPhoneNumberCountryId] int NOT NULL,
	[IDNumber] nvarchar(256) NOT NULL,
	[DefaultShipping] bit NOT NULL,
	[Address1] [nvarchar](256) NOT NULL,
	[Address2] [nvarchar](256) NOT NULL,
	[City] [nvarchar](128) NOT NULL,
	[District] [nvarchar](128) NULL,
	[State] [nvarchar](128) NOT NULL,
	[Zip] [nvarchar](32) NOT NULL,
	[CountryId] [int] NOT NULL
)
as
Begin 
	
	insert into @Ret_Table
	(
		[Customer_AddressId],
		[CustomerId],
		[AddressId],
		[ContactPersonFirstName],
		[ContactPersonLastName],
		[ContactPersonPhoneNumber],
		[ContactPersonPhoneNumberCountryId],
		[IDNumber],
		[DefaultShipping],
		[Address1] ,
		[Address2] ,
		[City] ,
		[District],
		[State],
		[Zip],
		[CountryId]
	)
	select	b.Id, a.Id, c.Id, b.ContactPersonFirstName, b.ContactPersonLastName,
			b.ContactPersonPhoneNumber, b.ContactPersonPhoneNumberCountryId, isnull(z.CustomerNationalId, ''),
			b.DefaultShipping, c.Address1, c.Address2, c.City,
			c.District, c.[State], c.Zip, c.CountryId
	from Customers a (nolock)
		inner join Customer_Address b (nolock) on a.Id = b.CustomerId
		inner join [Address] c (nolock) on b.AddressId = c.Id
		left join Customer_AddressID z (nolock) on b.Id = z.Customer_AddressId
	where a.Id = @pCustomerId
	and b.Available = 1
	and a.Available = 1
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnCustomerAddressGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

