
if not exists(select * from sys.columns 
            where Name = N'AllowCache' and Object_ID = Object_ID(N'ScriptStepInput'))
begin
	ALTER TABLE ScriptStepInput
	ADD AllowCache bit NULL
end

select top 10 * from ScriptStepInput

go

