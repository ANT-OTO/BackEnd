
--drop function [dbo].[tfnCustomerAddressResourceGet]


/****** Object:  UserDefinedFunction [dbo].[tfnCustomerAddressResourceGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnCustomerAddressResourceGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnCustomerAddressResourceGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnCustomerAddressResourceGet] 
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


print 'Update function [dbo].[tfnCustomerAddressResourceGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnCustomerAddressResourceGet]
(
	@pCustomerAddressId int
)  
RETURNS @Ret_Table Table
(
	[Customer_AddressId] int NOT NULL,
	[FileId] int NOT NULL
)
as
Begin 
	
	insert into @Ret_Table
	(
		[Customer_AddressId],
		[FileId]
	)
	select b.Id, c.FileId
	from Customer_Address b (nolock)
		inner join Customer_AddressResource c (nolock) on b.Id = c.Customer_AddressId
	where b.Id = @pCustomerAddressId
	and b.Available = 1
	and c.Available = 1
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnCustomerAddressResourceGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

