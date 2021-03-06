--select * from [CodeList]
--select * from [CodeListY]
--select * from SystemLanguage

declare @TblCode as Table
(
	[CodeListId] [int] NOT NULL,
	[CodeShort] [nvarchar](64) NOT NULL,
	[CodeLong] [nvarchar](256) NOT NULL,
	[SystemLanguageId] int NOT NULL
)	

declare @SystemLanguageId int
select @SystemLanguageId = Id
--select *
from SystemLanguage where [Name] = N'简体中文'

insert into @TblCode
(CodeListId, CodeShort, CodeLong, SystemLanguageId)
select a.CodeListId, a.CodeShort, a.CodeShort as CodeLong, @SystemLanguageId
from (
	select a.*
	from (
	select a.Id as CodeListId,
		case 
			when CodeId = 1 and a.Category = N'ProviderTodayScheduleOption' then N'我今天工作时间可以服务'
			when CodeId = 2 and a.Category = N'ProviderTodayScheduleOption' then N'我今天剩下时间可以服务'
			when CodeId = 3 and a.Category = N'ProviderTodayScheduleOption' then N'我今天工作时间可以替补服务'
			when CodeId = 4 and a.Category = N'ProviderTodayScheduleOption' then N'我今天剩下时间可以替补服务'
			when CodeId = 5 and a.Category = N'ProviderTodayScheduleOption' then N'我今天剩下时间不能工作'

			when CodeShort = N'Cancelled After Failed Service' and a.Category = N'RequestStatus' then N'服务失败后取消'

			when CodeShort = N'New' and a.Category = N'ProviderStatus' then N'开始注册'
			when CodeShort = N'New' then N'新请求'
			when CodeShort = 'Accepted' then N'接受了'
			when CodeShort = 'In Process' then N'正在进行'
			when CodeShort = 'Finished' then N'结束了'
			when CodeShort = 'Cancelled' then N'取消了'
			when CodeShort = 'Service Fee' then N'服务费'
			when CodeShort = 'Payment' then N'付款'
			when CodeShort = 'Credit' then N'信用'
			when CodeShort = 'Charge' then N'收费'
			when CodeShort = 'Refund' then N'退款'
			when CodeShort = 'Voice' then N'语音'
			when CodeShort = 'Video' then N'视频'
			when CodeShort = 'Sent' then N'已发送'
			when CodeShort = 'Received' then N'已收到'

			when CodeShort = 'Confirmed' then N'确认了'
			when CodeShort = 'Check' then N'支票'
			when CodeShort = 'ACH' then N'银行自动结算 (ACH)'
			when CodeShort = 'Wire' then N'汇钱'
			when CodeShort = 'Credit Card' then N'信用卡'
			when CodeShort = 'Pending Interview' then N'等待面试'

			when CodeShort = 'PayPal' then N'PayPal'
			when CodeShort = 'Approved' then N'批准了'
			when CodeShort = 'Denied' then N'没被批准'
			when CodeShort = 'Available' then N'可以工作'
			when CodeShort = 'Available as Alternative' then N'可以做替补'
			when CodeShort = 'Not Available' then N'不想工作'
			when CodeShort = 'All Days' then N'包括任何一天'
			when CodeShort = 'Business Days' then N'只包括工作日'
			when CodeShort = 'Non-Business Days' then N'只包括非工作日'


			when CodeShort = 'Everyday in the date range' then N'包括任何一天'
			when CodeShort = 'Available Days Only' then N'只包括可以工作日'
			when CodeShort = 'Not Available Days Only' then N'只包括非工作日'

			when CodeShort = 'Monday Only' then N'只包括星期一'
			when CodeShort = 'Tuesday Only' then N'只包括星期二'
			when CodeShort = 'Wednesday Only' then N'只包括星期三'
			when CodeShort = 'Thursday Only' then N'只包括星期四'
			when CodeShort = 'Friday Only' then N'只包括星期五'
			when CodeShort = 'Saturday Only' then N'只包括星期六'
			when CodeShort = 'Sunday Only' then N'只包括星期天'


			when CodeShort = '24 Hours a Day' then N'包括一天24小时'
			when CodeShort = 'Business Hours' then N'只包括工作时段'
			when CodeShort = 'Non-Business Hours' then N'只包括非工作时段'

			when CodeShort = 'Available Hours Only' then N'只包括可以工作时段'
			when CodeShort = 'Not Available Hours Only' then N'只包括不想工作时段'

			when CodeShort = 'User Defined' then N'用户自定义'
			when CodeShort = 'In Service' then N'正在服务'
			when CodeShort = 'Serviced' then N'已经服务了'
			when CodeShort = 'Native' then N'母语'
			when CodeShort = 'Near Native/fluent' then N'接近母语水平'
			when CodeShort = 'Highly Proficient' then N'非常熟练'
			when CodeShort = 'Very good command' then N'很熟练'
			when CodeShort = 'Not Applied' then N'没有申请'
			when CodeShort = 'MobilePhoneValidated' then N'手机号已验证'
			when CodeShort = 'SetUpFinished' then N'注册完成'

			when CodeShort = 'Monday' then N'星期一'
			when CodeShort = 'Tuesday' then N'星期二'
			when CodeShort = 'Wednesday' then N'星期三'
			when CodeShort = 'Thursday' then N'星期四'
			when CodeShort = 'Friday' then N'星期五'
			when CodeShort = 'Saturday' then N'星期六'
			when CodeShort = 'Sunday' then N'星期天'

			when CodeShort = 'Today' then N'今天'
			when CodeShort = 'Tomorrow' then N'明天'
			when CodeShort = 'Yesterday' then N'昨天'

		else N''
		end as CodeShort
	from [CodeList] a
	) a where a.CodeShort <> ''

	
) a

insert into [CodeListY]
(CodeListId, CodeShort, CodeLong, SystemLanguageId, CreateDate)
select a.CodeListId, a.CodeShort, a.CodeShort as CodeLong, @SystemLanguageId, GETDATE() as CreateDate
from @TblCode a left join  [CodeListY] z on a.CodeListId = z.CodeListId and z.SystemLanguageId = @SystemLanguageId 
where z.Id is null

update a
set a.CodeShort = b.CodeShort, a.CodeLong = b.CodeLong
from [CodeListY] a inner join @TblCode b on a.CodeListId = b.CodeListId and a.SystemLanguageId = b.SystemLanguageId

delete CodeListY where CodeListId not in (select Id from CodeList)

select * from CodeList a left join [CodeListY] z on a.Id = z.CodeListId and z.SystemLanguageId = @SystemLanguageId 
where a.Category not in ('ProviderPaymentMethod', 'PersonPaymentMethod', 'DescrCategory', 'MsgDeliveryMethod', 'DeviceType', 'RequestStatus', 'RequestProviderCallStatus', 'InterviewProviderCallStatus', 'ProviderStatus', 'InterviewStatus') and z.Id is null

select * from CodeListY