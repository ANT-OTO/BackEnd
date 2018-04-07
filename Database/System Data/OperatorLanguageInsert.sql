
declare @pLanguageId int = 0
select @pLanguageId = a.Id
from WEYI.dbo.Language a (nolock)
where a.EnglishName = 'Operator'

if(isnull(@pLanguageId,0)>0)
begin
	update WEYI.dbo.Language
	set EnglishName = 'Operator',
		Available = 1
	where Id = @pLanguageId
end
else
begin
	insert into WEYI.dbo.Language 
	(
		EnglishName,
		Available
	)
	select 'Operator' as EnglishName,
			1 as Available
	select @pLanguageId = SCOPE_IDENTITY()
end

select * from WEYI.dbo.Language
