
if not exists(select * from sys.columns 
            where Name = N'PersonId' and Object_ID = Object_ID(N'TextSession'))
begin
	ALTER TABLE TextSession
	ADD PersonId int NULL
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Person]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TextSession]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_TextSession_Person]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[TextSession]  WITH CHECK ADD  CONSTRAINT [FK_TextSession_Person] FOREIGN KEY([PersonId])
	REFERENCES [dbo].[Person] ([Id])

	ALTER TABLE [dbo].[TextSession] CHECK CONSTRAINT [FK_TextSession_Person]
end

select top 10 * from TextSession