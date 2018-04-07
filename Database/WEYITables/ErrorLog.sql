
/****** Object:  Table [dbo].[ErrorLog]    Script Date: 01/15/2015 21:55:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ErrorLog]') AND type in (N'U'))
Begin
	--DROP TABLE [dbo].[ErrorLog]
	print 'you need to manually exec DROP TABLE [dbo].[ErrorLog] ' + convert(varchar, getdate())
	
End
else
begin

CREATE TABLE [dbo].[ErrorLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](16) NOT NULL,
	[Detail] [nvarchar](max) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ErrorLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Error, Info, Warning, Debug, ServiceCall, or other types' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ErrorLog', @level2type=N'COLUMN',@level2name=N'Type'

ALTER TABLE [dbo].[ErrorLog] ADD  CONSTRAINT [DF_ErrorLog_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]



select * from ErrorLog
end

GO

SET ANSI_PADDING OFF
GO

GO



---------------------------------------------------------------Begin Index------------------------------------------------------------------

print '
Create Index ' + convert(varchar, getdate())


/****** Object:  Index [IX_ErrorLog_1]    Script Date: 01/16/2015 11:50:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ErrorLog]') AND name = N'IX_ErrorLog_1')
DROP INDEX [IX_ErrorLog_1] ON [dbo].[ErrorLog] WITH ( ONLINE = OFF )
GO



/****** Object:  Index [IX_ErrorLog_1]    Script Date: 01/16/2015 11:50:32 ******/
CREATE NONCLUSTERED INDEX [IX_ErrorLog_1] ON [dbo].[ErrorLog] 
(
	[Type] ASC,
	[CreateDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO





---------------------------------------------------------------End Index------------------------------------------------------------------

