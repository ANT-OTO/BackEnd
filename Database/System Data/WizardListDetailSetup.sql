declare @Time datetime = getutcdate()
declare @WizardListId int = 0

insert into [dbo].[WizardList]
(
	[ListName],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select 'ProductCodeType', 1, @Time, @Time, 1, 1

select @WizardListId = SCOPE_IDENTITY()

insert into [dbo].[WizardListDetail]
(
	[WizardListId],
	[Value],
	[Content],
	[Order],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @WizardListId, '1', 'UPC', '001', 1, @Time, @Time, 1, 1

insert into [dbo].[WizardListDetail]
(
	[WizardListId],
	[Value],
	[Content],
	[Order],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @WizardListId, '2', 'EAN', '002', 1, @Time, @Time, 1, 1


select * from WizardList order by Id desc

select * from WizardListDetail order by Id desc