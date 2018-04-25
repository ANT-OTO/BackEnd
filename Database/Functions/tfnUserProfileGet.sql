
--drop function [dbo].[tfnUserProfileGet]


/****** Object:  UserDefinedFunction [dbo].[tfnUserProfileGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnUserProfileGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnUserProfileGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnUserProfileGet] 
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


print 'Update function [dbo].[tfnUserProfileGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnUserProfileGet]
(
	@pUserId int
)  
RETURNS @Ret_Table Table
(
	[FirstName] nvarchar(256) NOT NULL,
	[LastName] nvarchar(256) NOT NULL,
	[Email] nvarchar(256) NOT NULL,
	[LoginName] nvarchar(256) NOT NULL,
	[Password] nvarchar(256) NOT NULL,
	[PhoneNumberId] int NOT NULL,
	[PhoneNumberCountryId] int NOT NULL,
	[PhoneNumber] nvarchar(256) NOT NULL,
	[AddressId] int NOT NULL,
	[Address1] [nvarchar](256) NOT NULL,
	[Address2] [nvarchar](256) NOT NULL,
	[City] [nvarchar](128) NOT NULL,
	[District] [nvarchar](128) NULL,
	[State] [nvarchar](128) NOT NULL,
	[Zip] [nvarchar](32) NOT NULL,
	[CountryId] [int] NOT NULL,
	[Available] bit NOT NULL
)
as
Begin 
	
	insert into @Ret_Table
	(
		[FirstName],
		[LastName],
		[Email],
		[LoginName],
		[Password],
		[PhoneNumberId],
		[PhoneNumberCountryId],
		[PhoneNumber],
		[AddressId],
		[Address1],
		[Address2],
		[City],
		[District],
		[State],
		[Zip],
		[CountryId],
		[Available]
	)
	select	a.FirstName, a.LastName, a.Email, a.LoginName, '', a.PhoneNumberId,
			b.CountryId, b.PhoneNumber, c.Id, c.Address1, c.Address2,
			c.City, c.District, c.State, c.Zip, c.CountryId, a.Available
	from [User] a (nolock)
		inner join PhoneNumber b (nolock) on a.PhoneNumberId = b.Id
		inner join [Address] c (nolock) on a.AddressId = c.Id
	where a.Id = @pUserId
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnUserProfileGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

