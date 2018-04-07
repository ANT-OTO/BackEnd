--select * from ScriptVariable

declare @TblCode as Table
(
	[VariableName] nvarchar(128) NOT NULL,
	[Description] nvarchar(max) NOT NULL,
	[Type] nvarchar(32) NOT NULL
)	



------------------------------------- Begin  ------------------------------------- 

delete @TblCode

insert into @TblCode	
([VariableName], [Description], [Type])
select distinct a.*
from (
	select '$@CompanyName@$' as [VariableName], 'Name of the Company' as [Description], 'string' as [Type]

	UNION
	
	select '$@PersonName@$' as [VariableName], 'Name of person who started the request' as [Description], 'string' as [Type]
	
	UNION
	
	select '$@InterpreterName@$' as [VariableName], 'Name of Interpreter who answers the call' as [Description], 'string' as [Type]

	UNION
	
	select '$@SourceLanguage@$' as [VariableName], 'Caller''s source language name' as [Description], 'string' as [Type]

	UNION
	
	select '$@SourceLanguageId@$' as [VariableName], 'Caller''s source language id' as [Description], 'int' as [Type]

	UNION
	
	select '$@TargetLanguage@$' as [VariableName], 'Caller''s target language name' as [Description], 'string' as [Type]
	
	UNION
	
	select '$@TargetLanguageId@$' as [VariableName], 'Caller''s target language Id' as [Description], 'int' as [Type]
	
	UNION
	
	select '$@AudioVideo@$' as [VariableName], 'Whether the service is an audio or a video session right now' as [Description], 'string' as [Type]
	
	UNION
	
	select '$@ProductAudioVideo@$' as [VariableName], 'Whether the product associated with the service supports Audio or Video: AudioOnly, VideoOnly, Both' as [Description], 'string' as [Type]
	
	UNION
	
	select '$@InterpreterID@$' as [VariableName], 'Id of Interpreter who answers the call' as [Description], 'string' as [Type]
	--UNION
	
	--select '$@ThirdPartyConference@$' as [VariableName], 'Whether the caller requires the interpreter to conference in a third party' as [Description], 'string' as [Type]	-- Yes/No

	--UNION
	
	--select '$@DataCollectionDone@$' as [VariableName], 'Whether the required info or data has been collected (either by an interpreter or by the caller through the app)' as [Description], 'string' as [Type]	-- Yes/No

) a 

insert into ScriptVariable
([VariableName], [Description], [Type])
select a.*
from @TblCode a left join  ScriptVariable z on a.[VariableName] = z.[VariableName] 
where z.Id is null

update a
set a.[Description] = b.[Description], a.[Type] = b.[Type]
	, a.LastUpdate = GETUTCDATE()
from ScriptVariable a inner join  @TblCode b on a.[VariableName] = b.[VariableName]
	and (a.[Description] <> b.[Description])

delete 
--select * from
ScriptVariable where [VariableName] not in (select [VariableName] from @TblCode)

select * from ScriptVariable


------------------------------------- End  ------------------------------------- 

go

