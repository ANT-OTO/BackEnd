IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_ChinaIdentifyProfile_Update]') AND type in (N'P', N'PC'))
BEGIN
	print 'Create procedure [dbo].[sp_ChinaIdentifyProfile_Update] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create procedure [dbo].[sp_ChinaIdentifyProfile_Update] 
		AS 
		BEGIN 
			PRINT ''To begin''
		END
	'


	exec (@create)
END

print 'Update [sp_ChinaIdentifyProfile_Update] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter procedure [dbo].[sp_ChinaIdentifyProfile_Update] 
	@pName nvarchar(64),
	@pPhoneNumber nvarchar(256),
	@pIdentityNumber nvarchar(256),
	@pFrontFileId int,
	@pBackFileId int,
	@pChinaIdentifyProfileId int output
AS

SET NOCOUNT ON
	declare @pTime datetime = getutcdate()

	if(exists(
		select *
		from ChinaIdentityProfile a (nolock)
		where a.Name = @pName
		and a.IdentityNumber = @pIdentityNumber
		and a.PhoneNumber = @pPhoneNumber
	))
	begin
		select @pChinaIdentifyProfileId = a.Id
		from ChinaIdentityProfile a
		where a.Name = @pName
		and a.IdentityNumber = @pIdentityNumber
		and a.PhoneNumber = @pPhoneNumber

		update a
		set a.FrontFileId = @pFrontFileId,
			a.BackFileId = @pBackFileId
		from ChinaIdentityProfile a
		where a.Name = @pName
		and a.IdentityNumber = @pIdentityNumber
		and a.PhoneNumber = @pPhoneNumber

		return
	end



	insert into [dbo].[ChinaIdentityProfile]
	( 
		[IdentityNumber],
		[Name],
		[PhoneNumber],
		[FrontFileId],
		[BackFileId],
		[Available],
		[CreateDate],
		[LastUpdate],
		[LastUpdateBy],
		[LastUpdateByType]
	)
	select	a.IdentityNumber, a.Name, a.PhoneNumber,
			a.FrontFileId, a.BackFileId,
			a.Available, @pTime, @pTime, 1, 1
	from 
	(
		select	@pIdentityNumber as [IdentityNumber],
				@pName as [Name],
				@pPhoneNumber as [PhoneNumber],
				@pFrontFileId as [FrontFileId],
				@pBackFileId as [BackFileId],
				1 as Available
	) a
	select @pChinaIdentifyProfileId = SCOPE_IDENTITY()

	





return

/*

*/



GO


