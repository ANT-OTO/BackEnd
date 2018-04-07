--drop function [dbo].[tfnBillProviderPayTermRate]


/****** Object:  UserDefinedFunction [dbo].[tfnBillProviderPayTermRate]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tfnBillProviderPayTermRate]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN	
	print 'Create function [dbo].[tfnBillProviderPayTermRate] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '
		Create function [dbo].[tfnBillProviderPayTermRate] 
		(
			@pProviderId int,
			@pProviderProductCodeId int,
			@pBillActionTimeCodeId int,
			@pProviderServiceId int,
			@pDateTime datetime,
			@pActive bit
			
		)
		RETURNS @Ret_Table Table
		(	
			[Id] [int] NOT NULL,
			[BillPayTermId] [int] NOT NULL,
			[Rate] [decimal](9,3) NOT NULL
		)
		AS  
		BEGIN 
			return 
		END
	'

	exec (@create)
END

print 'Update function [dbo].[tfnBillProviderPayTermRate] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[tfnBillProviderPayTermRate]
(
    @pProviderId int,
	@pProviderProductCodeId int,
	@pBillActionTimeCodeId int,
	@pProviderServiceId int,
	@pDateTime datetime,
	@pActive bit
)  


RETURNS @Ret_Table Table
(
	[Id] [int] NOT NULL,
	[BillPayTermId] [int] NOT NULL,
	[Rate] [decimal](9,3) NOT NULL
)
as
Begin 

if @pDateTime is null
begin
	select @pDateTime = getutcdate ()
end
--select * from BillProviderPayTermRate
insert into @Ret_Table
	(Id,
	BillPayTermId,
	Rate)
select b.Id,
		b.BillPayTermId,
		b.Rate
from (select max(a.Id) as Id, a.BillPayTermId
	from BillProviderPayTermRate a (nolock)
	join BillPayTerm b (nolock) on b.Id = a.BillPayTermId
	where a.ProviderId = @pProviderId
	and ( a.ProviderServiceId = @pProviderServiceId or a.ProviderServiceId is null)
	and b.ProviderProductCodeId = @pProviderProductCodeId
	and b.BillActionTimeCodeId = @pBillActionTimeCodeId
	and a.Active = @pActive
	and @pDateTime between a.StartDate and isnull(a.EndDate, dateadd(year, 1, getutcdate()))
	group by a.BillPayTermId) a
join BillProviderPayTermRate b (nolock) on b.Id = a.Id

Return 


/*

select * from [dbo].[tfnBillProviderPayTermRate](345,
			1,
			1,
			34,
			'11/29/2015 23:34',
			 1)

*/
End

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

