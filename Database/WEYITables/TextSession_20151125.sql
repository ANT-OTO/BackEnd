
if not exists(select * from sys.columns 
            where Name = N'DPTPersonId' and Object_ID = Object_ID(N'TextSession'))
begin
	ALTER TABLE TextSession
	ADD DPTPersonId int NULL
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Person]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TextSession]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_TextSession_DPTPerson]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[TextSession]  WITH CHECK ADD  CONSTRAINT [FK_TextSession_DPTPerson] FOREIGN KEY([DPTPersonId])
	REFERENCES [dbo].[Person] ([Id])

	ALTER TABLE [dbo].[TextSession] CHECK CONSTRAINT [FK_TextSession_DPTPerson]
end

select top 10 * from TextSession