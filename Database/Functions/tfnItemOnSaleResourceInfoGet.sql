
--drop function [dbo].[tfnItemOnSaleResourceInfoGet]


/****** Object:  UserDefinedFunction [dbo].[tfnItemOnSaleResourceInfoGet]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnItemOnSaleResourceInfoGet]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnItemOnSaleResourceInfoGet] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[tfnItemOnSaleResourceInfoGet] 
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


print 'Update function [dbo].[tfnItemOnSaleResourceInfoGet] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnItemOnSaleResourceInfoGet]
(
    @pItemOnSaleId int,
	@pItemId int
)  
RETURNS @Ret_Table Table
(
	[ItemOnSaleId] int NOT NULL,
	[ResourceTypeCodeId] int NOT NULL, --image, video
	[FileId] int NOT NULL,
	[isMain] bit NOT NULL,
	[Order] int NOT NULL,
	[Description_1] nvarchar(max) NULL,
	[Description_2] nvarchar(max) NULL,
	[Selected] bit NOT NULL,
	[Available] bit NOT NULL
)
as
Begin 
	
	if(isnull(@pItemId, 0) > 0)
	begin
		select @pItemOnSaleId = a.Id 
		from ItemOnSale a (nolock)
		where a.ItemId = @pItemId
		and a.Available = 1
	end
	declare @pOnMarket bit = 0
	if(not exists(
		select *
		from ItemOnSale a
		where a.Id = @pItemOnSaleId
		and a.Available = 1
	))
	begin
		select @pOnMarket = 1
	end
	declare @pWizardSessionId int = 0
		select @pWizardSessionId = a.Id
		from WizardSession a (nolock)
		where a.SourceId = @pItemId
		and a.SourceTable = 'Item'
		insert into @Ret_Table
		(
			[ItemOnSaleId],
			[ResourceTypeCodeId], --image, video
			[FileId],
			[isMain],
			[Order],
			[Description_1],
			[Description_2],
			[Selected],
			[Available]
		)
		select	@pItemOnSaleId,
				a.ResourceTypeCodeId,
				a.FileId,
				a.MainResource,
				0,
				a.Description_1,
				a.Description_2,
				0,
				a.Available
		from ItemResource a (nolock)
		where a.ItemId = @pItemId
		and a.Available = 1
		insert into @Ret_Table
		(
			[ItemOnSaleId],
			[ResourceTypeCodeId], --image, video
			[FileId],
			[isMain],
			[Order],
			[Description_1],
			[Description_2],
			[Selected],
			[Available]
		)
		select	@pItemOnSaleId,
				b.FileStoreTypeCodeId,
				b.Id,
				0,
				a.InputOrder,
				b.Para1,
				'',
				0,
				1
		from WizardSessionInputs a (nolock)
			inner join [File] b (nolock) on a.StepSourceTable = 'File' and a.StepSourceId = b.Id
		where a.WizardSessionId = @pWizardSessionId
		and a.StepSourceTable = 'File'
		and a.StepSourceId not in (
			select a.FileId
			from @Ret_Table a
		)

	if(@pOnMarket = 0
	and exists(
		select * 
		from ItemOnSale a (nolock)
		where a.ItemId = @pItemId
	))
	begin
		update a
		set a.Selected = 1
		from @Ret_Table a
		where a.FileId in 
		(
			select a.FileId
			from ItemOnSaleResource a (nolock)
			where a.ItemOnSaleId = @pItemOnSaleId
			and a.Available = 1
		)
		
	end
	else if(@pOnMarket = 0 and not exists(
		select * 
		from ItemOnSale a (nolock)
		where a.ItemId = @pItemId
	))
	begin
		select @pItemId = @pItemId
		
	end
	else
	begin
		update a
		set a.Selected = 1
		from @Ret_Table a
		where a.FileId in 
		(
			select a.FileId
			from ItemOnSaleResource a (nolock)
			where a.ItemOnSaleId = @pItemOnSaleId
			and a.Available = 1
		)
		
	end
	
Return 


/*
--select * from FAQ
--select * from FAQY

select * from WEYI.dbo.CompanySRIConference order by Id desc
select * from WEYI.dbo.CompanySRIConferenceAudioChannel order by Id desc
select * from WEYI.dbo.CompanySRIConferencePresenterSession order by Id desc
select * from [dbo].[tfnItemOnSaleResourceInfoGet](3,7,8,24,1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

