
/****** Object:  Table [dbo].[Country]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Country]') AND type in (N'U'))
Begin
	/*

	DROP TABLE [dbo].[Country]
	
	
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
	
	print 'you need to manually exec DROP TABLE [dbo].[Country] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[Country](
	[CountryCode] nvarchar(8) NOT NULL,
	[ISO] nvarchar(8) NOT NULL,					-- The same as [CountryCode]
	[ISO3] nvarchar(8) NOT NULL,
	[ISONumeric] nvarchar(8) NULL,
	[fips] nvarchar(8) NULL,					-- FIPS 10-4 country codes for Countries, Dependencies, Areas of Special Sovereignty, and Their Principal Administrative Divisions
	[Country] nvarchar(128) NULL,
	[Capital] nvarchar(128) NULL,
	[Area] nvarchar(16) NULL,							-- in sql km
	[Population] nvarchar(16) NULL,
	[Continent] nvarchar(8) NULL,
	[tld] nvarchar(8) NULL,						-- country code top-level domain (ccTLD)
	[CurrencyCode] nvarchar(8) NULL,
	[CurrencyName] nvarchar(32) NULL,
	[Phone] nvarchar(32) NULL,
	[PostalCodeFormat] nvarchar(32) NULL,
	[PostalCodeRegex] nvarchar(64) NULL,
	[Languages] nvarchar(128) NULL,
	[geonameid] nvarchar(16) NULL,
	[neighbours] nvarchar(128) NULL,
	[EquivalentFipsCode] nvarchar(8) NULL,
		
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[CountryCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]



-------------------------- Begin Foreign Key ---------------------------------------------------------------


-------------------------- End Foreign Key ---------------------------------------------------------------



-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------




-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------



select * from [Country]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_Country_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Country]') AND name = N'IX_Country_1')
DROP INDEX [IX_Country_1] ON [dbo].[Country]
GO




/****** Object:  Index [IX_Country_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Country_1] ON [dbo].[Country]
(
	[ISO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



---------------------------------------------------------------End Index------------------------------------------------------------------

/*


insert into Country
(CountryCode,ISO,ISO3,ISONumeric,fips,Country,Capital,Area,Population,Continent,tld,CurrencyCode,CurrencyName,Phone,PostalCodeFormat,PostalCodeRegex,Languages,geonameid,neighbours,EquivalentFipsCode,CreateDate)
select a.ISO as CountryCode,ISO,ISO3,[ISO-Numeric] as ISONumeric,fips,Country,Capital,
	[Area(in sq km)] as Area,[Population],Continent,tld,CurrencyCode,CurrencyName,Phone,
	[Postal Code Format] as PostalCodeFormat,[Postal Code Regex] as PostalCodeRegex,Languages,geonameid,neighbours,EquivalentFipsCode,GETUTCDATE()
from Test.dbo.CoutryCode a where a.ISO not in (select ISO from Country)


*/