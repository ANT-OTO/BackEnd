
if not exists(select * from sys.columns 
            where Name = N'FinishTime' and Object_ID = Object_ID(N'DPT'))
begin
	ALTER TABLE DPT
	ADD FinishTime DateTime NULL
end

select top 10 * from DPT