
insert into [ErrorMsg]
([Msg], CreateDate)
select a.*, GETDATE() as CreateDate
from (
	select N'System Error' as [Msg]
) a left join  [ErrorMsg] z on a.[Msg] = z.[Msg] 
where z.Id is null


insert into [ErrorMsg]
([Msg], CreateDate)
select a.*, GETDATE() as CreateDate
from (	
	select N'Requires Login' as [Msg]
) a left join  [ErrorMsg] z on a.[Msg] = z.[Msg] 
where z.Id is null

insert into [ErrorMsg]
([Msg], CreateDate)
select a.*, GETDATE() as CreateDate
from (	
	select distinct *
	from (
		select N'Invalid System Language' as [Msg]

		UNION

		select N'Record not found' as [Msg]

		UNION

		select N'Invalid Email' as [Msg]

		UNION

		select N'Password needs to be between 6 and 15 characters' as [Msg]

		UNION

		select N'Invalid Region' as [Msg]

		UNION

		select N'Invalid Mobile Number' as [Msg]

		UNION

		select N'Email is already registered' as [Msg]

		UNION

		select N'Mobile Number is already registered' as [Msg]

		UNION

		select N'Invalid Name' as [Msg]

		UNION

		select N'Invalid Input' as [Msg]

		UNION

		select N'Invalid Code' as [Msg]

		UNION

		select N'Code Already Validated' as [Msg]

		UNION

		select N'Code Expired' as [Msg]

		UNION

		select N'Invalid Image Format' as [Msg]

		UNION

		select N'Please enter certificate info' as [Msg]

		UNION

		select N'This function is under construction' as [Msg]
	) a

) a left join  [ErrorMsg] z on a.[Msg] = z.[Msg] 
where z.Id is null



select * from ErrorMsg