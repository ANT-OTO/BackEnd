
/****** Object:  Table [dbo].[CompanyApplication]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CompanyApplication]') AND type in (N'U'))
Begin
	/*
	DROP TABLE [dbo].[CompanyApplication]
	
	select distinct 'alter table [' + b.name + '] drop constraint [' + a.name + ']' 
	from sys.objects a
		inner join sys.objects b on a.parent_object_id = b.object_id
	where a.object_id in 
	(   select fk.constraint_object_id from sys.foreign_key_columns as fk
		where fk.referenced_object_id = 
    		(select object_id from sys.tables where name = 'CompanyApplication')
	)	
	
	
	declare @TblName as nvarchar(64) = 'CompanyApplication'
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
	
	print 'you need to manually exec DROP TABLE [dbo].[CompanyApplication] ' + convert(varchar, getdate())
	
End
else
begin

/*
change schema 1 of 2

Select *
into #Tmp_CompanyApplication
from CompanyApplication

drop table [dbo].[CompanyApplication]
*/
CREATE TABLE [dbo].[CompanyApplication](
	[Id] [int] IDENTITY(10000,1) NOT NULL,
	[WEYIApplicationId] [int] NOT NULL, --select * from WEYI.dbo.WEYIApplication
	[CompanyId] [int] NOT NULL,	-- select * from WEYIMgr.dbo.Company
	[Version] [timestamp] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL	

 CONSTRAINT [PK_CompanyApplication] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

/*
change schema 1 of 2

SET IDENTITY_INSERT CompanyApplication ON
insert into CompanyApplication
(Id, FirstName, LastName, Email, Phone, LoginName, [Password], Available, CreateDate, LastUpdate, LastUpdateBy, LastUpdateByType)
select Id, FirstName, LastName, Email, Phone, LoginName, [Password], Available, CreateDate, LastUpdate, LastUpdateBy, LastUpdateByType
from #Tmp_CompanyApplication

*/

ALTER TABLE [dbo].[CompanyApplication] ADD  CONSTRAINT [DF_CompanyApplication_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
ALTER TABLE [dbo].[CompanyApplication] ADD  CONSTRAINT [DF_CompanyApplication_LastUpdate]  DEFAULT (getutcdate()) FOR [LastUpdate]


-------------------------- Begin Foreign Key ---------------------------------------------------------------


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WEYIApplication]') AND type in (N'U'))
	and EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CompanyApplication]') AND type in (N'U'))
	and NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_CompanyApplication_WEYIApplication]') AND type in (N'F'))
begin
	ALTER TABLE [dbo].[CompanyApplication]  WITH CHECK ADD  CONSTRAINT [FK_CompanyApplication_WEYIApplication] FOREIGN KEY([WEYIApplicationId])
	REFERENCES [dbo].[WEYIApplication] ([Id])

	ALTER TABLE [dbo].[CompanyApplication] CHECK CONSTRAINT [FK_CompanyApplication_WEYIApplication]
end


-------------------------- End Foreign Key ---------------------------------------------------------------



-------------------------- Begin Primary Key Referenced by other tables ---------------------------------------------------------------

-------------------------- End Primary Key Referenced by other tables ---------------------------------------------------------------


select * from [CompanyApplication]
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------


print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_CompanyApplication_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CompanyApplication]') AND name = N'IX_CompanyApplication_1')
DROP INDEX [IX_CompanyApplication_1] ON [dbo].[CompanyApplication]
GO




/****** Object:  Index [IX_CompanyApplication_1]    Script Date: 2/2/2015 9:14:23 AM ******/
CREATE NONCLUSTERED INDEX [IX_CompanyApplication_1] ON [dbo].[CompanyApplication]
(
	[CompanyId] ASC

)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO




---------------------------------------------------------------End Index------------------------------------------------------------------
