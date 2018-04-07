
if not exists(select * from sys.columns 
            where Name = N'FromLanguageId' and Object_ID = Object_ID(N'TextBlock'))
begin
	ALTER TABLE TextBlock
	ADD FromLanguageId int NULL
end


if not exists(select * from sys.columns 
            where Name = N'ToLanguageId' and Object_ID = Object_ID(N'TextBlock'))
begin
	ALTER TABLE TextBlock
	ADD ToLanguageId int NULL
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Language]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TextBlock]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_TextBlock_FromLanguage]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[TextBlock]  WITH CHECK ADD  CONSTRAINT [FK_TextBlock_FromLanguage] FOREIGN KEY([FromLanguageId])
	REFERENCES [dbo].[Language] ([Id])

	ALTER TABLE [dbo].[TextBlock] CHECK CONSTRAINT [FK_TextBlock_FromLanguage]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Language]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TextBlock]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_TextBlock_ToLanguage]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[TextBlock]  WITH CHECK ADD  CONSTRAINT [FK_TextBlock_ToLanguage] FOREIGN KEY([ToLanguageId])
	REFERENCES [dbo].[Language] ([Id])

	ALTER TABLE [dbo].[TextBlock] CHECK CONSTRAINT [FK_TextBlock_ToLanguage]
end

select top 10 * from TextBlock