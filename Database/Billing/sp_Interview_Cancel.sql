IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Interview_Cancel]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_Interview_Cancel] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_Interview_Cancel] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_Interview_Cancel] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[sp_Interview_Cancel] 

	@pProviderId int,
	@pTime datetime
AS

set nocount on

declare @Result int = 0

/*
select * from CodeList where Category = 'InterviewProviderStatus'
select * from CodeList where Category = 'InterviewStatus'
*/

declare @InterviewId int = 0

select @InterviewId = Id
from Interview a (nolock)
where a.InterviewerId = @pProviderId and a.[InterviewStatusCodeId] = 1		-- New
																			-- select * from CodeList where Category = 'InterviewStatus'

if( @InterviewId > 0 )
begin
	update a
	set a.[InterviewStatusCodeId] = 4			-- Cancelled
												-- select * from CodeList where Category = 'InterviewStatus'
		,a.LastUpdate =  @pTime
	--select *
	from Interview a 
		left join InterviewProvider b (nolock) on a.Id = b.InterviewId and b.InterviewProviderStatusCodeId in 
				( 5		-- Confirmed
						-- select * from CodeList where Category = 'InterviewProviderStatus'
				)
	where a.Id = @InterviewId
		and a.[InterviewStatusCodeId] = 1		-- New
												-- select * from CodeList where Category = 'InterviewStatus'
		and b.Id is null

	if( @@ROWCOUNT = 0 )
	begin
		select @Result = 1
	end
end



return @Result

GO


