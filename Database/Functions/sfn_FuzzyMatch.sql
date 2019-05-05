/****** Object:  UserDefinedFunction [dbo].[sfn_FuzzyMatch]    Script Date: 02/26/2009 13:58:14 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sfn_FuzzyMatch]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	print 'Create function [dbo].[sfn_FuzzyMatch] ' + convert(varchar, getdate())

	declare @create as varchar(2048)

	set @create = '

		Create function [dbo].[sfn_FuzzyMatch] 
		(
		)
		returns  bit

		AS  
		BEGIN 
			declare @Ret_value bit
			return @Ret_value
		END
	'


	exec (@create)
END


print 'Update function [dbo].[sfn_FuzzyMatch] ... ' + convert(varchar, getdate())

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER function [dbo].[sfn_FuzzyMatch]
(
	@s1 nvarchar(256),
	@s2 nvarchar(256)
)
RETURNS  int
as
BEGIN
    -- written by William Talada for SqlServerCentral
    DECLARE @i int, @j int;

    SET @i = 1;
    SET @j = 0;

    WHILE @i < LEN(@s1)
    BEGIN
        IF CHARINDEX(SUBSTRING(@s1,@i,2), @s2) > 0 SET @j=@j+1;
        SET @i=@i+1;
    END

    RETURN @j;
END
/*

--select top 10 * from WEYI.dbo.Person
select [dbo].[sfn_FuzzyMatch]('Nature Made COQ10','COQ10 Nature Made')
*/

GO


