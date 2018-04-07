
if exists(select * from sys.columns 
            where Name = N'CodeShort' and Object_ID = Object_ID(N'CodeList'))
begin
	ALTER TABLE CodeList
	ALTER COLUMN CodeShort [nvarchar](1024) NOT NULL
end

if exists(select * from sys.columns 
            where Name = N'CodeLong' and Object_ID = Object_ID(N'CodeList'))
begin
	ALTER TABLE CodeList
	ALTER COLUMN CodeLong [nvarchar](1024) NOT NULL
end

select top 10 * from CodeList