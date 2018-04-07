
/****** Object:  Table [dbo].[CountryLanguage]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CountryLanguage]') AND type in (N'U'))
Begin
	/*

	DROP TABLE [dbo].[CountryLanguage]
	
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'Country')
	)	
	
	
	declare @TblName as nvarchar(64) = 'Country'
	select distinct '
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N''[dbo].[' + @TblName + ']'') AND type in (N''U''))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N''[dbo].[' + b.name + ']'') AND type in (N''U''))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N''[dbo].[' + a.name + ']'') AND type in (N''F''))
begin
	ALTER TABLE [dbo].[' + b.name + ']  WITH CHECK ADD  CONSTRAINT [' + a.name + '] FOREIGN KEY([' + c.ColumnName + '])
	REFERENCES [dbo].[' + @TblName + '] ([Id])

	ALTER TABLE [dbo].[' + b.name + '] CHECK CONSTRAINT [' + a.name + ']
end
'
	--select b.name as TableName, a.name as FKName, c.ColumnName
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
		inner join (   select fk.constraint_object_id, c.name as ColumnName from sys.foreign_key_columns as fk inner join sys.columns c on fk.parent_object_id = c.object_id and fk.parent_column_id = c.column_id
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = @TblName)
	) c on a.object_id = c.constraint_object_id	
	
	
	
	*/
	
	print 'you need to manually exec DROP TABLE [dbo].[CountryLanguage] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[CountryLanguage](
	[Id] [int] IDENTITY(1,1) NOT NULL,

	[CountryCode] nvarchar(8) NOT NULL,
	[LanguageId] int NOT NULL,
	[Popularity] int NOT NULL,					-- 1: most popular
		
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_CountryLanguage] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]



-------------------------- Begin Foreign Key ---------------------------------------------------------------



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Language]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CountryLanguage]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_CountryLanguage_Language]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[CountryLanguage]  WITH CHECK ADD  CONSTRAINT [FK_CountryLanguage_Language] FOREIGN KEY([LanguageId])
	REFERENCES [dbo].[Language] ([Id])

	ALTER TABLE [dbo].[CountryLanguage] CHECK CONSTRAINT [FK_CountryLanguage_Language]
end

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Country]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CountryLanguage]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_CountryLanguage_Country]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[CountryLanguage]  WITH CHECK ADD  CONSTRAINT [FK_CountryLanguage_Country] FOREIGN KEY([CountryCode])
	REFERENCES [dbo].[Country] ([CountryCode])

	ALTER TABLE [dbo].[CountryLanguage] CHECK CONSTRAINT [FK_CountryLanguage_Country]
end


-------------------------- End Foreign Key ---------------------------------------------------------------



-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------




-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------



select * from [CountryLanguage]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [[IX_CountryLanguage_1]]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CountryLanguage]') AND name = N'[IX_CountryLanguage_1]')
DROP INDEX [[IX_CountryLanguage_1]] ON [dbo].[CountryLanguage]
GO




/****** Object:  Index [[IX_CountryLanguage_1]]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_CountryLanguage_1] ON [dbo].[CountryLanguage]
(
	[CountryCode] ASC,
	[LanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



---------------------------------------------------------------End Index------------------------------------------------------------------

/*


set nocount on

declare @CountryCode nvarchar(8)
declare @Languages nvarchar(128)



DECLARE Country_Cursor CURSOR FOR 
select a.CountryCode, a.Languages
--select *
from Country a


OPEN Country_Cursor

FETCH NEXT FROM Country_Cursor INTO @CountryCode, @Languages


WHILE @@FETCH_STATUS = 0
BEGIN

	DECLARE @OneLanguage nvarchar(8)
	DECLARE Language_Cursor CURSOR FOR 
	select a.Item
	--select *
	from [dbo].[tfnToolSplitString](@Languages, ',') a

	OPEN Language_Cursor

	FETCH NEXT FROM Language_Cursor INTO @OneLanguage

	DECLARE @Popularity int = 0


	select @Popularity = 1

	WHILE @@FETCH_STATUS = 0
	BEGIN
		DECLARE @PosDash int = 0

		select @PosDash = 0
		select @PosDash = CHARINDEX('-', @OneLanguage)
		if( @PosDash > 0)
		begin
			select @OneLanguage = SUBSTRING(@OneLanguage, 1, @PosDash - 1)
		end

		--truncate table CountryLanguage


		insert into CountryLanguage
		--select * from CountryLanguage where CountryCode = 'HK'
		(CountryCode, LanguageId, Popularity, CreateDate)
		select @CountryCode, a.Id, @Popularity, GETUTCDATE()
		--select *
		from Language a inner join LanguageISO b on a.Id = b.LanguageId
			left join CountryLanguage z on a.Id = z.LanguageId and z.CountryCode = @CountryCode
		where (b.[639_1] = @OneLanguage or b.[639_3] = @OneLanguage)
			and z.Id is null

		select @Popularity = @Popularity + 1

		FETCH NEXT FROM Language_Cursor INTO @OneLanguage
	END

	CLOSE Language_Cursor
	DEALLOCATE Language_Cursor

	FETCH NEXT FROM Country_Cursor INTO @CountryCode, @Languages
END

CLOSE Country_Cursor
DEALLOCATE Country_Cursor


*/