
--drop function [dbo].[tfnSupplierPlaceInfoGet]


/****** Object:  UserDefinedFunction [dbo].[tfnSupplierPlaceInfoGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnSupplierPlaceInfoGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnSupplierPlaceInfoGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnSupplierPlaceInfoGet] 
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


print 'Update function [dbo].[tfnSupplierPlaceInfoGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnSupplierPlaceInfoGet]
(
    @pSupplierPlaceInfoId int
)  
RETURNS @Ret_Table Table
(
	[SupplierPlaceInfoId] int NOT NULL,
	[SupplierName] nvarchar(256) NOT NULL,
	[SupplierLocation] nvarchar(256) NOT NULL,
	[PriceInfo] nvarchar(128) NOT NULL,
	[CurrencyId] int NOT NULL,
	[Description] nvarchar(max) NOT NULL
)
as
Begin 
	
	insert into @Ret_Table
	(
		[SupplierPlaceInfoId],
		[SupplierName],
		[SupplierLocation],
		[PriceInfo],
		[CurrencyId],
		[Description]
	)
	select	a.Id,
			a.SupplierName,
			a.SupplierLocation,
			a.PriceInfo,
			a.CurrencyId,
			a.[Description]
	from ANTOTO.dbo.SupplierPlaceInfo a (nolock)
	where a.Id = @pSupplierPlaceInfoId
	
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnSupplierPlaceInfoGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

