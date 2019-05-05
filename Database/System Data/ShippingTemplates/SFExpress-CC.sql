-- cc template
declare @pTemplateName nvarchar(256) = N'顺丰电商-中国'
declare @pTemplateCode nvarchar(256) = N'SFExpress-CC'
declare @pTime datetime = getutcdate()
declare @pBatchTemplateId int = 0
declare @pColumnOrder int = 0
declare @pRequired bit = 0

insert into [dbo].[BatchTemplate]
(
	[TemplateName],
	[TemplateCode],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select a.TemplateName, a.TemplateCode, 1, @pTime as CreateDate, @pTime as LastUpdate, 1 , 1
from
(
	select @pTemplateName as [TemplateName], @pTemplateCode as [TemplateCode], 1 as [Available]
) a
left join BatchTemplate z (nolock) on z.TemplateCode = a.TemplateCode
where z.Id is null



update a
set a.TemplateName = @pTemplateName,
	a.Available = 1,
	a.LastUpdate = @pTime
from BatchTemplate a
where a.TemplateCode = @pTemplateCode

select @pBatchTemplateId = a.Id
from BatchTemplate a (nolock)
where a.TemplateCode = @pTemplateCode


-- clear Template Content

delete
from BatchTemplateContent 
where BatchTemplateId = @pBatchTemplateId

-- insert new

declare @pColumnName nvarchar(256) = ''
--declare @pColumnCode nvarchar(256) = ''
declare @pColumnTypeCodeId int = 0 --select * from CodeList where Category = 'ColumnType'


-- 运单关联编号
select @pColumnName = N'运单关联编号'
--select @pColumnCode = N'OrderReferenceCode'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 1

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1


-- 客户代码
select @pColumnName = N'客户代码'
--select @pColumnCode = N'PackingService'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 0

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1


-- 运单关联编号2
select @pColumnName = N'运单关联编号2'
--select @pColumnCode = N'OrderReferenceCode2'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 0

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1


-- 寄件人公司
select @pColumnName = N'寄件人公司'
--select @pColumnCode = N'ShipperCompanyName'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 0



insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1

-- 寄件人姓名
select @pColumnName = N'寄件人姓名'
--select @pColumnCode = N'ShipperName'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 1

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1


-- 寄件人联系电话
select @pColumnName = N'寄件人联系电话'
--select @pColumnCode = N'ShipperPhoneNumber'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 1

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1


-- 寄件人详细地址
select @pColumnName = N'寄件人详细地址'
--select @pColumnCode = N'ShipperAddress'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 1

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1

-- 寄件人城市
select @pColumnName = N'寄件人城市'
--select @pColumnCode = N'ShipperCity'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 1


insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1



-- 寄件人州/省
select @pColumnName = N'寄件人州/省'
--select @pColumnCode = N'ShipperState/District'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 1

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1

-- 寄件人国家
select @pColumnName = N'寄件人国家'
--select @pColumnCode = N'ShipperCountry'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 1

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1


-- 寄件人邮编
select @pColumnName = N'寄件人邮编'
--select @pColumnCode = N'ReceiverEmail'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 1

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1



-- 寄件人邮箱
select @pColumnName = N'寄件人邮箱'
--select @pColumnCode = N'ShipperEmail'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 0

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1

-- 收件人公司
select @pColumnName = N'收件人公司'
--select @pColumnCode = N'ReceiverCompanyName'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 0

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1

-- 收件人姓名
select @pColumnName = N'收件人姓名'
--select @pColumnCode = N'ReceiverName'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 1

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1

-- 收件人联系电话
select @pColumnName = N'收件人联系电话'
--select @pColumnCode = N'ReceiverPhoneNumber'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 1

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1

-- 收件人详细地址
select @pColumnName = N'收件人详细地址'
--select @pColumnCode = N'ReceiverAddress'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 1

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1

-- 收件人城市
select @pColumnName = N'收件人城市'
--select @pColumnCode = N'ReceiverCity'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 1

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1

-- 收件人州/省
select @pColumnName = N'收件人州/省'
--select @pColumnCode = N'ReceiverState/District'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 1

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1

-- 收件人国家
select @pColumnName = N'收件人国家'
--select @pColumnCode = N'ReceiverCountry'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 1

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1

-- 收件人邮编
select @pColumnName = N'收件人邮编'
--select @pColumnCode = N'ReceiverEmail'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 1

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1


-- 收件人邮箱
select @pColumnName = N'收件人邮箱'
--select @pColumnCode = N'ReceiverEmail'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 0

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1


-- 收件人证件类型
select @pColumnName = N'收件人证件类型'
--select @pColumnCode = N'ReceiverIDType'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 0

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1


-- 收件人证件号
select @pColumnName = N'收件人证件号'
--select @pColumnCode = N'ReceiverIDNumber'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 0


insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1

-- 渠道代码
select @pColumnName = N'渠道代码'
--select @pColumnCode = N'ChannelCode'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 1

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1

--包裹数量
select @pColumnName = N'包裹数量'
--select @pColumnCode = N'ChannelCode'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 1 --select * from CodeList where Category = 'ColumnType'
select @pRequired = 1

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1



-- 打包增值服务
select @pColumnName = N'打包增值服务'
--select @pColumnCode = N'PackingService'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 2
select @pRequired = 0

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1


-- 打包材料增值服务
select @pColumnName = N'打包材料增值服务'
--select @pColumnCode = N'PackingService'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 2
select @pRequired = 0

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1


-- 邮寄保险增值服务
select @pColumnName = N'邮寄保险增值服务'
--select @pColumnCode = N'PackingService'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 2
select @pRequired = 0

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1


-- 付款方式
select @pColumnName = N'付款方式'
--select @pColumnCode = N'PackingService'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 0

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1

-- 税金付款方式
select @pColumnName = N'税金付款方式'
--select @pColumnCode = N'PackingService'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 1

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1

-- 申报货币币种
select @pColumnName = N'申报货币币种'
--select @pColumnCode = N'PackingService'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 1

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1

-- 商品UPC1
select @pColumnName = N'商品UPC1'
--select @pColumnCode = N'PackingService'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 0
insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1

-- 商品SKU1
select @pColumnName = N'商品SKU1'
--select @pColumnCode = N'PackingService'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 0

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1

-- 商品重量1
select @pColumnName = N'商品重量1'
--select @pColumnCode = N'PackingService'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 1
select @pRequired = 0

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1

-- 商品名称1
select @pColumnName = N'商品名称1'
--select @pColumnCode = N'PackingService'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 1

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1


-- 商品品牌1
select @pColumnName = N'商品品牌1'
--select @pColumnCode = N'PackingService'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 1

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1



-- 商品数量1
select @pColumnName = N'商品数量1'
--select @pColumnCode = N'PackingService'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 1
select @pRequired = 1

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1


-- 商品单位1
select @pColumnName = N'商品单位1'
--select @pColumnCode = N'PackingService'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 1

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1


-- 商品单价1
select @pColumnName = N'商品单价1'
--select @pColumnCode = N'PackingService'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 5
select @pRequired = 1

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1

-- 商品源地区1
select @pColumnName = N'商品源地区1'
--select @pColumnCode = N'PackingService'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 1

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1


-- 商品UPC2
select @pColumnName = N'商品UPC2'
--select @pColumnCode = N'PackingService'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 0
insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1

-- 商品SKU2
select @pColumnName = N'商品SKU2'
--select @pColumnCode = N'PackingService'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 0

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1

-- 商品重量2
select @pColumnName = N'商品重量2'
--select @pColumnCode = N'PackingService'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 1
select @pRequired = 0

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1

-- 商品名称2
select @pColumnName = N'商品名称2'
--select @pColumnCode = N'PackingService'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 0

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1


-- 商品品牌2
select @pColumnName = N'商品品牌2'
--select @pColumnCode = N'PackingService'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 0

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1



-- 商品数量2
select @pColumnName = N'商品数量2'
--select @pColumnCode = N'PackingService'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 1
select @pRequired = 0

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1


-- 商品单位2
select @pColumnName = N'商品单位2'
--select @pColumnCode = N'PackingService'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 0

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1


-- 商品单价2
select @pColumnName = N'商品单价2'
--select @pColumnCode = N'PackingService'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 5
select @pRequired = 0

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1

-- 商品源地区2
select @pColumnName = N'商品源地区2'
--select @pColumnCode = N'PackingService'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 0

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1


-- 商品UPC3
select @pColumnName = N'商品UPC3'
--select @pColumnCode = N'PackingService'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 0
insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1

-- 商品SKU3
select @pColumnName = N'商品SKU3'
--select @pColumnCode = N'PackingService'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 0

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1

-- 商品重量3
select @pColumnName = N'商品重量3'
--select @pColumnCode = N'PackingService'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 1
select @pRequired = 0

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1

-- 商品名称3
select @pColumnName = N'商品名称3'
--select @pColumnCode = N'PackingService'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 0

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1


-- 商品品牌3
select @pColumnName = N'商品品牌3'
--select @pColumnCode = N'PackingService'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 0

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1



-- 商品数量3
select @pColumnName = N'商品数量3'
--select @pColumnCode = N'PackingService'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 1
select @pRequired = 0

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1


-- 商品单位3
select @pColumnName = N'商品单位3'
--select @pColumnCode = N'PackingService'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 0

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1


-- 商品单价3
select @pColumnName = N'商品单价3'
--select @pColumnCode = N'PackingService'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 5
select @pRequired = 0

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1

-- 商品源地区3
select @pColumnName = N'商品源地区3'
--select @pColumnCode = N'PackingService'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 0

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1

-- 商品UPC4
select @pColumnName = N'商品UPC4'
--select @pColumnCode = N'PackingService'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 0
insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1

-- 商品SKU4
select @pColumnName = N'商品SKU4'
--select @pColumnCode = N'PackingService'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 0

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1

-- 商品重量4
select @pColumnName = N'商品重量4'
--select @pColumnCode = N'PackingService'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 1
select @pRequired = 0

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1

-- 商品名称4
select @pColumnName = N'商品名称4'
--select @pColumnCode = N'PackingService'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 0

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1


-- 商品品牌4
select @pColumnName = N'商品品牌4'
--select @pColumnCode = N'PackingService'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 0

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1



-- 商品数量4
select @pColumnName = N'商品数量4'
--select @pColumnCode = N'PackingService'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 1
select @pRequired = 0

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1


-- 商品单位4
select @pColumnName = N'商品单位4'
--select @pColumnCode = N'PackingService'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 0

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1


-- 商品单价4
select @pColumnName = N'商品单价4'
--select @pColumnCode = N'PackingService'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 5
select @pRequired = 0

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1

-- 商品源地区4
select @pColumnName = N'商品源地区4'
--select @pColumnCode = N'PackingService'
select @pColumnOrder = @pColumnOrder + 1
select @pColumnTypeCodeId = 3
select @pRequired = 0

insert into [dbo].[BatchTemplateContent]
(
	[BatchTemplateId],
	[ColumnName],
	[ColumnTypeCodeId],
	[ColumnOrder],
	[Required],
	[Available],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select @pBatchTemplateId, @pColumnName, @pColumnTypeCodeId, @pColumnOrder, @pRequired, 1, @pTime, @pTime, 1, 1


select * from [BatchTemplateContent] a where a.BatchTemplateId = @pBatchTemplateId

insert into [dbo].[BatchTemplateSampleFile]
(
	[BatchTemplateId],
	[FilePath],
	[FilePublicUrl],
	[Available], 
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select	a.BatchTemplateId, a.FilePath, a.FilePublicUrl,
		1, @pTime, @pTime, 1, 1
from 
(
	select	@pBatchTemplateId as BatchTemplateId,
			'C:/Work/FileManagement/ExcelFile/' as FilePath, 
			'https://www.oto-ant.com/ExcelFiles/antotoexcel.xlsx' as [FilePublicUrl]
) a
left join [dbo].[BatchTemplateSampleFile] z (nolock) on a.BatchTemplateId = z.BatchTemplateId
where z.Id is null


update a
set a.FilePath = 'C:/Work/FileManagement/ExcelFile/',
	a.FilePublicUrl = 'https://www.oto-ant.com/ExcelFiles/antotoexcel.xlsx',
	a.LastUpdate = @pTime,
	a.LastUpdateBy = 1,
	a.LastUpdateByType = 1
from BatchTemplateSampleFile a
where a.BatchTemplateId = @pBatchTemplateId


