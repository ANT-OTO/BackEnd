--select * from [Wizard]


declare @TblContent as Table
(
	[Id] int NOT NULL,
	Category [nvarchar](256) NOT NULL,
	WizardName [nvarchar](256) NOT NULL
)	


insert into @TblContent
([Id], Category, WizardName)
select a.*
from (
	select 1 as Id, N'Provider' as Category, N'Registration' as WizardName
	
) a 


insert into [Wizard]
([Id], Category, WizardName, CreateDate)
select a.*, GETUTCDATE()
from @TblContent a left join  [Wizard] z on a.Id = z.Id
where z.Id is null

update a
set a.Category = b.Category, a.WizardName = b.WizardName
from [Wizard] a inner join  @TblContent b on a.Id = b.Id
where Not ( a.Category = b.Category and a.WizardName = b.WizardName)

select * from [Wizard]