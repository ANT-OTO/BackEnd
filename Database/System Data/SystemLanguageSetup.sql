declare @pTime datetime = getutcdate()

declare @Language Table
(
	[EnglishName] nvarchar(256),
	[DisplayName] nvarchar(256),
	[Available] bit
)

insert @Language
(EnglishName, DisplayName, Available)
select a.EnglishName, a.DisplayName, a.Available
from 
(
	select 'English' as [EnglishName], 'English' as [DisplayName], 1 as Available
	Union
	select 'Simplified Chinese', N'简体中文', 1
) a

insert into SystemLanguage
(
	[EnglishName],
	[DisplayName],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select	a.EnglishName,
		a.DisplayName,
		a.Available,
		@pTime,
		@pTime,
		1,
		1
from @Language a
left join SystemLanguage z (nolock) on a.EnglishName = z.EnglishName
where z.Id is null


update a
set a.DisplayName = b.DisplayName,
	a.Available = b.Available,
	a.LastUpdate = @pTime,
	a.LastUpdateBy = 1,
	a.LastUpdateByType = 1
from SystemLanguage a
	inner join @Language b on a.EnglishName = b.EnglishName
where a.Available <> b.Available
or a.DisplayName <> b.DisplayName


select * from SystemLanguage a (nolock) order by a.Id