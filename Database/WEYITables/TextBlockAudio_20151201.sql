
if not exists(select * from sys.columns 
            where Name = N'IsDPT' and Object_ID = Object_ID(N'TextBlockAudio'))
begin
	ALTER TABLE TextBlockAudio
	ADD IsDPT bit NULL
end


select top 10 * from TextBlockAudio