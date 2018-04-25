declare @pTime datetime = getutcdate()
insert into [dbo].[SecFunction]
(
	[FunctionName],
	[FunctionKey],
	[ParentFunctionKey],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select distinct a.FunctionKey, a.FunctionKey, '', 1, @pTime, @pTime, 1, 1
from
(
SELECT 'FK_DashboardManagement' as [FunctionKey]
UNION SELECT 'FK_ProductManagement' as [FunctionKey]
UNION SELECT 'FK_OrderManagement' as [FunctionKey]
UNION SELECT 'FK_WarehouseManagement' as [FunctionKey]
UNION SELECT 'FK_LogisticsManagement' as [FunctionKey]
UNION SELECT 'FK_SupplyManagement' as [FunctionKey]
UNION SELECT 'FK_MakeManagement' as [FunctionKey]
UNION SELECT 'FK_MarketManagement' as [FunctionKey]
UNION SELECT 'FK_SecurityManagement' as [FunctionKey]
UNION SELECT 'FK_ReportManagement' as [FunctionKey]
UNION SELECT 'FK_FinanceManagement' as [FunctionKey]
UNION SELECT 'FK_CustomerServiceManagement' as [FunctionKey]
UNION SELECT 'FK_SubMerchantManagement' as [FunctionKey]
UNION SELECT 'FK_DashboardManagement' as [FunctionKey]
UNION SELECT 'FK_WarehouseManagement' as [FunctionKey]
UNION SELECT 'FK_DeliveryOrderManagement' as [FunctionKey]
UNION SELECT 'FK_ChannelManagement' as [FunctionKey]
UNION SELECT 'FK_SecurityManagement' as [FunctionKey]
UNION SELECT 'FK_TransferManagement' as [FunctionKey]
UNION SELECT 'FK_AgentManagement' as [FunctionKey]
UNION SELECT 'FK_SubMerchantManagement' as [FunctionKey]
) a

select * from SecFunction

-- Assign all company
insert into [dbo].[SecFunctionCompany]
(
	[SecFunctionId],
	[CompanyId],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select a.SecFunctionId, a.CompanyId, 1, @pTime, @pTime, 1, 1
from 
(
	select a.Id as [SecFunctionId], b.Id as [CompanyId]
	--select *
	from SecFunction a (nolock)
		cross join Company b (nolock)
	where a.Available = 1 
	and b.Active = 1
) a
left join [dbo].[SecFunctionCompany] z on a.SecFunctionId = z.SecFunctionId and a.CompanyId = z.CompanyId
where z.Id is null

select * from SecFunctionCompany
