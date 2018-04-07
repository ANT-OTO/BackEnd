
if not exists(select * from sys.columns 
            where Name = N'Mode' and Object_ID = Object_ID(N'TextBlockText'))
begin
	ALTER TABLE TextBlockText
	ADD [Mode] varchar(2) NULL
end

select top 10 * from TextBlockText