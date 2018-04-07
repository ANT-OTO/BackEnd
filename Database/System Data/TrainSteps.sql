
/*
truncate table [TrainStepY]
truncate table [TrainStepSetStep]
truncate table [TrainStep]
truncate table [TrainStepSet]
*/

declare @TrainStepId int = 0, @TrainStepSetId int = 0

-- Insert TrainStepSet

 insert [dbo].[TrainStepSet](
    [DeviceTypeCodeId], 
	[Active],
	[Name],			
	[Description],
	[StartDate],	
	[CreateDate]
)
select
	1,
	1,
	'TRAINSET1.01',
	'For device Type 1',
	GETUTCDATE(),
	GETUTCDATE()

 insert [dbo].[TrainStepSet](
    [DeviceTypeCodeId], 
	[Active],
	[Name],			
	[Description],
	[StartDate],	
	[CreateDate]
)
select
	2, -- DeviceTypeCodeId
	1, -- Active
	'TRAINSET1.02',
	'For device Type 2'	,
	GETUTCDATE(),
	GETUTCDATE()

 insert [dbo].[TrainStepSet](
    [DeviceTypeCodeId], 
	[Active],
	[Name],			
	[Description],
	[StartDate],	
	[CreateDate]
)
select
	3, -- DeviceTypeCodeId
	1, -- Active
	'TRAINSET1.03',
	'For device Type 3'	,
	GETUTCDATE(),
	GETUTCDATE()

 insert [dbo].[TrainStepSet](
    [DeviceTypeCodeId], 
	[Active],
	[Name],			
	[Description],
	[StartDate],	
	[CreateDate]
)
select
	4, -- DeviceTypeCodeId
	1, -- Active
	'TRAINSET1.04',
	'For device Type 4'	,
	GETUTCDATE(),
	GETUTCDATE()

 insert [dbo].[TrainStepSet](
    [DeviceTypeCodeId], 
	[Active],
	[Name],			
	[Description],
	[StartDate],	
	[CreateDate]
)
select
	5, -- DeviceTypeCodeId
	1, -- Active
	'TRAINSET1.05',
	'For device Type 5'	,
	GETUTCDATE(),
	GETUTCDATE()


-- Insert Train Steps - 12

-- Step 1
insert [TrainStep](
	[Description],	
	[Active],
	[IsVisible],
	[CloseOnVideoComplete],
	[CreateDate])
select 'Home', 1, 1, 0, GETUTCDATE()
where not exists (select * from [TrainStep] where [Description] = 'Home')

select @TrainStepId = SCOPE_IDENTITY()

if  isnull(@TrainStepId, 0) <> 0
begin
	insert [dbo].[TrainStepY](
		[TrainStepId],
		[SystemLanguageId],		
		[Title],		
		[HTMLText],		
		[VideoURL],			
		[CreateDate] )
	select 	@TrainStepId,
		1,		
		'Home',		
		'Each short training module within the WEYI Provider Training Program must be watched in full.  The entire process only takes about 10 minutes.<br/><br/>
Soon, your training will be complete and you''ll be ready to begin helping WEYI clients.<br/><br/>
You''ll receive more information at the end of this training.<br/><br/>
Let''s get started!',
		'',			
		 GETUTCDATE()

	insert [dbo].[TrainStepSetStep](
		[TrainStepId],
		[TrainStepSetId],
		[OrderBy],
		[CreateDate] )
	select @TrainStepId,
		a.Id,
		1,		
		GETUTCDATE()
	from [dbo].[TrainStepSet] a
end

select @TrainStepId  = 0

-- Step 2
insert [TrainStep](
	[Description],	
	[Active],
	[IsVisible],
	[CloseOnVideoComplete],
	[CreateDate])
select 'Confidentiality Statement', 1, 1, 1, GETUTCDATE()

select @TrainStepId = SCOPE_IDENTITY()

if  isnull(@TrainStepId, 0) <> 0
begin
	insert [dbo].[TrainStepY](
		[TrainStepId],
		[SystemLanguageId],		
		[Title],		
		[HTMLText],		
		[VideoURL],			
		[CreateDate] )
	select 	@TrainStepId,
		1,		
		'Confidentiality Statement',		
		'',
		'https://www.weyimobile.com/trainvideo/01 WEYI provider training - confidentiality statement.mp4',			
		 GETUTCDATE()

	insert [dbo].[TrainStepSetStep](
		[TrainStepId],
		[TrainStepSetId],
		[OrderBy],
		[CreateDate] )
	select @TrainStepId,
		a.Id,
		2,		
		GETUTCDATE()
	from [dbo].[TrainStepSet] a
end

select @TrainStepId  = 0

-- Step 3

insert [TrainStep](
	[Description],	
	[Active],
	[IsVisible],
	[CloseOnVideoComplete],
	[CreateDate])
select 'Introduction', 1, 1, 1, GETUTCDATE()

select @TrainStepId = SCOPE_IDENTITY()

if  isnull(@TrainStepId, 0) <> 0
begin
	insert [dbo].[TrainStepY](
		[TrainStepId],
		[SystemLanguageId],		
		[Title],		
		[HTMLText],		
		[VideoURL],			
		[CreateDate] )
	select 	@TrainStepId,
		1,		
		'Introduction',		
		'',
		'https://www.weyimobile.com/trainvideo/02 WEYI provider training - introduction.mp4',			
		 GETUTCDATE()

	insert [dbo].[TrainStepSetStep](
		[TrainStepId],
		[TrainStepSetId],
		[OrderBy],
		[CreateDate] )
	select @TrainStepId,
		a.Id,
		3,		
		GETUTCDATE()
	from [dbo].[TrainStepSet] a
end

select @TrainStepId  = 0

-- Step 4

insert [TrainStep](
	[Description],	
	[Active],
	[IsVisible],
	[CloseOnVideoComplete],
	[CreateDate])
select 'How WEYI connects you to clients', 1, 1, 1, GETUTCDATE()

select @TrainStepId = SCOPE_IDENTITY()

if  isnull(@TrainStepId, 0) <> 0
begin
	insert [dbo].[TrainStepY](
		[TrainStepId],
		[SystemLanguageId],		
		[Title],		
		[HTMLText],		
		[VideoURL],			
		[CreateDate] )
	select 	@TrainStepId,
		1,		
		'How WEYI connects you to clients',		
		'',
		'https://www.weyimobile.com/trainvideo/03 WEYI provider training - how WEYI connects you to clients.mp4',			
		 GETUTCDATE()

	insert [dbo].[TrainStepSetStep](
		[TrainStepId],
		[TrainStepSetId],
		[OrderBy],
		[CreateDate] )
	select @TrainStepId,
		a.Id,
		4,		
		GETUTCDATE()
	from [dbo].[TrainStepSet] a
end

select @TrainStepId  = 0

-- Step 5

insert [TrainStep](
	[Description],	
	[Active],
	[IsVisible],
	[CloseOnVideoComplete],
	[CreateDate])
select 'Accepting Service requests', 1, 1, 1, GETUTCDATE()

select @TrainStepId = SCOPE_IDENTITY()

if  isnull(@TrainStepId, 0) <> 0
begin
	insert [dbo].[TrainStepY](
		[TrainStepId],
		[SystemLanguageId],		
		[Title],		
		[HTMLText],		
		[VideoURL],			
		[CreateDate] )
	select 	@TrainStepId,
		1,		
		'Accepting Service requests',		
		'',
		'https://www.weyimobile.com/trainvideo/04 WEYI provider training - accepting service requests.mp4',			
		 GETUTCDATE()

	insert [dbo].[TrainStepSetStep](
		[TrainStepId],
		[TrainStepSetId],
		[OrderBy],
		[CreateDate] )
	select @TrainStepId,
		a.Id,
		5,		
		GETUTCDATE()
	from [dbo].[TrainStepSet] a
end

select @TrainStepId  = 0

-- Step 6

insert [TrainStep](
	[Description],	
	[Active],
	[IsVisible],
	[CloseOnVideoComplete],
	[CreateDate])
select 'Types of Service requests', 1, 1, 1, GETUTCDATE()

select @TrainStepId = SCOPE_IDENTITY()

if  isnull(@TrainStepId, 0) <> 0
begin
	insert [dbo].[TrainStepY](
		[TrainStepId],
		[SystemLanguageId],		
		[Title],		
		[HTMLText],		
		[VideoURL],			
		[CreateDate] )
	select 	@TrainStepId,
		1,		
		'Types of Service requests',		
		'',
		'https://www.weyimobile.com/trainvideo/05 WEYI provider training - types of service requests.mp4',			
		 GETUTCDATE()

	insert [dbo].[TrainStepSetStep](
		[TrainStepId],
		[TrainStepSetId],
		[OrderBy],
		[CreateDate] )
	select @TrainStepId,
		a.Id,
		6,		
		GETUTCDATE()
	from [dbo].[TrainStepSet] a
end

select @TrainStepId  = 0

-- Step 7

insert [TrainStep](
	[Description],	
	[Active],
	[IsVisible],
	[CloseOnVideoComplete],
	[CreateDate])
select 'Text and Chat', 1, 1, 1, GETUTCDATE()

select @TrainStepId = SCOPE_IDENTITY()

if  isnull(@TrainStepId, 0) <> 0
begin
	insert [dbo].[TrainStepY](
		[TrainStepId],
		[SystemLanguageId],		
		[Title],		
		[HTMLText],		
		[VideoURL],			
		[CreateDate] )
	select 	@TrainStepId,
		1,		
		'Text and Chat',		
		'',
		'https://www.weyimobile.com/trainvideo/06 WEYI provider training - text and chat.mp4',			
		 GETUTCDATE()

	insert [dbo].[TrainStepSetStep](
		[TrainStepId],
		[TrainStepSetId],
		[OrderBy],
		[CreateDate] )
	select @TrainStepId,
		a.Id,
		7,		
		GETUTCDATE()
	from [dbo].[TrainStepSet] a
end

select @TrainStepId  = 0

-- Step 8

insert [TrainStep](
	[Description],	
	[Active],
	[IsVisible],
	[CloseOnVideoComplete],
	[CreateDate])
select 'Service Interruptions', 1, 1, 1, GETUTCDATE()

select @TrainStepId = SCOPE_IDENTITY()

if  isnull(@TrainStepId, 0) <> 0
begin
	insert [dbo].[TrainStepY](
		[TrainStepId],
		[SystemLanguageId],		
		[Title],		
		[HTMLText],		
		[VideoURL],			
		[CreateDate] )
	select 	@TrainStepId,
		1,		
		'Service Interruptions',		
		'',
		'https://www.weyimobile.com/trainvideo/07 WEYI provider training - service interruptions.mp4',			
		 GETUTCDATE()

	insert [dbo].[TrainStepSetStep](
		[TrainStepId],
		[TrainStepSetId],
		[OrderBy],
		[CreateDate] )
	select @TrainStepId,
		a.Id,
		8,		
		GETUTCDATE()
	from [dbo].[TrainStepSet] a
end

select @TrainStepId  = 0

-- Step 9

insert [TrainStep](
	[Description],	
	[Active],
	[IsVisible],
	[CloseOnVideoComplete],
	[CreateDate])
select 'Your Schedule', 1, 1, 1, GETUTCDATE()

select @TrainStepId = SCOPE_IDENTITY()

if  isnull(@TrainStepId, 0) <> 0
begin
	insert [dbo].[TrainStepY](
		[TrainStepId],
		[SystemLanguageId],		
		[Title],		
		[HTMLText],		
		[VideoURL],			
		[CreateDate] )
	select 	@TrainStepId,
		1,		
		'Your Schedule',		
		'',
		'https://www.weyimobile.com/trainvideo/08 WEYI provider training - your schedule.mp4',			
		 GETUTCDATE()

	insert [dbo].[TrainStepSetStep](
		[TrainStepId],
		[TrainStepSetId],
		[OrderBy],
		[CreateDate] )
	select @TrainStepId,
		a.Id,
		9,		
		GETUTCDATE()
	from [dbo].[TrainStepSet] a
end

select @TrainStepId  = 0

-- Step 10

insert [TrainStep](
	[Description],	
	[Active],
	[IsVisible],
	[CloseOnVideoComplete],
	[CreateDate])
select 'Language Assessment', 1, 1, 1, GETUTCDATE()

select @TrainStepId = SCOPE_IDENTITY()

if  isnull(@TrainStepId, 0) <> 0
begin
	insert [dbo].[TrainStepY](
		[TrainStepId],
		[SystemLanguageId],		
		[Title],		
		[HTMLText],		
		[VideoURL],			
		[CreateDate] )
	select 	@TrainStepId,
		1,		
		'Language Assessment',		
		'',
		'https://www.weyimobile.com/trainvideo/09 WEYI provider training - language assessment.mp4',			
		 GETUTCDATE()

	insert [dbo].[TrainStepSetStep](
		[TrainStepId],
		[TrainStepSetId],
		[OrderBy],
		[CreateDate] )
	select @TrainStepId,
		a.Id,
		10,		
		GETUTCDATE()
	from [dbo].[TrainStepSet] a
end

select @TrainStepId  = 0

-- Step 11

insert [TrainStep](
	[Description],	
	[Active],
	[IsVisible],
	[CloseOnVideoComplete],
	[CreateDate])
select 'Last Steps', 1, 1, 1, GETUTCDATE()

select @TrainStepId = SCOPE_IDENTITY()

if  isnull(@TrainStepId, 0) <> 0
begin
	insert [dbo].[TrainStepY](
		[TrainStepId],
		[SystemLanguageId],		
		[Title],		
		[HTMLText],		
		[VideoURL],			
		[CreateDate] )
	select 	@TrainStepId,
		1,		
		'Last Steps',		
		'',
		'https://www.weyimobile.com/trainvideo/10 WEYI provider training - last steps.mp4',			
		 GETUTCDATE()

	insert [dbo].[TrainStepSetStep](
		[TrainStepId],
		[TrainStepSetId],
		[OrderBy],
		[CreateDate] )
	select @TrainStepId,
		a.Id,
		11,		
		GETUTCDATE()
	from [dbo].[TrainStepSet] a
end

select @TrainStepId  = 0

-- Step 12

insert [TrainStep](
	[Description],	
	[Active],
	[IsVisible],
	[CloseOnVideoComplete],
	[CreateDate])
select 'Provider Payment', 1, 1, 1, GETUTCDATE()

select @TrainStepId = SCOPE_IDENTITY()

if  isnull(@TrainStepId, 0) <> 0
begin
	insert [dbo].[TrainStepY](
		[TrainStepId],
		[SystemLanguageId],		
		[Title],		
		[HTMLText],		
		[VideoURL],			
		[CreateDate] )
	select 	@TrainStepId,
		1,		
		'Provider Payment',		
		'',
		'https://www.weyimobile.com/trainvideo/11 WEYI provider training - provider payment.mp4',			
		 GETUTCDATE()

	insert [dbo].[TrainStepSetStep](
		[TrainStepId],
		[TrainStepSetId],
		[OrderBy],
		[CreateDate] )
	select @TrainStepId,
		a.Id,
		12,		
		GETUTCDATE()
	from [dbo].[TrainStepSet] a
end

select * from TrainStepSet
select * from TrainStep
select * from TrainStepY
select * from TrainStepSetStep
