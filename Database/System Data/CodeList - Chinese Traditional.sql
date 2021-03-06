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
from SystemLanguage where [Name] = N'繁體中文'

--delete [CodeListY] where SystemLanguageId = @SystemLanguageId

insert into @TblCode
(CodeListId, CodeShort, CodeLong, SystemLanguageId)
select a.CodeListId, a.CodeShort, a.CodeShort as CodeLong, @SystemLanguageId
from (
	select a.*
	from (
	select a.Id as CodeListId,
		case 
			when CodeId = 1 and a.Category = N'ProviderTodayScheduleOption' then N'我今天工作時間可以服務'
			when CodeId = 2 and a.Category = N'ProviderTodayScheduleOption' then N'我今天剩下時間可以服務'
			when CodeId = 3 and a.Category = N'ProviderTodayScheduleOption' then N'我今天工作時間可以替補服務'
			when CodeId = 4 and a.Category = N'ProviderTodayScheduleOption' then N'我今天剩下時間可以替補服務'
			when CodeId = 5 and a.Category = N'ProviderTodayScheduleOption' then N'我今天剩下時間不能工作'

			when CodeShort = N'Cancelled After Failed Service' and a.Category = N'RequestStatus' then N'服務失敗後取消'

			when CodeShort = N'New' and a.Category = N'ProviderStatus' then N'開始註冊'
			when CodeShort = N'New' then N'新請求'
			when CodeShort = 'Accepted' then N'接受了'
			when CodeShort = 'In Process' then N'正在進行'
			when CodeShort = 'Finished' then N'結束了'
			when CodeShort = 'Cancelled' then N'取消了'
			when CodeShort = 'Service Fee' then N'服務費'
			when CodeShort = 'Payment' then N'付款'
			when CodeShort = 'Credit' then N'信用'
			when CodeShort = 'Charge' then N'收費'
			when CodeShort = 'Refund' then N'退款'
			when CodeShort = 'Voice' then N'語音'
			when CodeShort = 'Video' then N'視頻'
			when CodeShort = 'Sent' then N'已發送'
			when CodeShort = 'Received' then N'已收到'

			when CodeShort = 'Confirmed' then N'確認了'
			when CodeShort = 'Check' then N'支票'
			when CodeShort = 'ACH' then N'銀行自動結算 (ACH)'
			when CodeShort = 'Wire' then N'匯錢'
			when CodeShort = 'Credit Card' then N'信用卡'
			when CodeShort = 'Pending Interview' then N'等待面試'

			when CodeShort = 'PayPal' then N'PayPal'
			when CodeShort = 'Approved' then N'批准了'
			when CodeShort = 'Denied' then N'没被批准'
			when CodeShort = 'Available' then N'可以工作'
			when CodeShort = 'Available as Alternative' then N'可以做替補'
			when CodeShort = 'Not Available' then N'不想工作'
			when CodeShort = 'All Days' then N'包括任何一天'
			when CodeShort = 'Business Days' then N'工作日'
			when CodeShort = 'Non-Business Days' then N'非工作日'

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

			when CodeShort = '24 Hours a Day' then N'包括一天24小時'
			when CodeShort = 'Business Hours' then N'只包括工作时段'
			when CodeShort = 'Non-Business Hours' then N'只包括非工作时段'

			when CodeShort = 'Available Hours Only' then N'只包括可以工作时段'
			when CodeShort = 'Not Available Hours Only' then N'只包括非工作时段'

			when CodeShort = 'User Defined' then N'用戶自定義'
			when CodeShort = 'In Service' then N'正在服務'
			when CodeShort = 'Serviced' then N'已經服務了'
			when CodeShort = 'Native' then N'母語'
			when CodeShort = 'Near Native/fluent' then N'接近母語水平'
			when CodeShort = 'Highly Proficient' then N'非常熟練'
			when CodeShort = 'Very good command' then N'很熟練'
			when CodeShort = 'Not Applied' then N'沒有申請'
			when CodeShort = 'MobilePhoneValidated' then N'手機號已驗證'
			when CodeShort = 'SetUpFinished' then N'註冊完成'

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



--select * from CodeList a left join [CodeListY] z on a.Id = z.CodeListId and z.SystemLanguageId = @SystemLanguageId 
--where a.Category not in ('DescrCategory', 'MsgDeliveryMethod', 'DeviceType') and z.Id is null

delete CodeListY where CodeListId not in (select Id from CodeList)

select * from CodeList a left join [CodeListY] z on a.Id = z.CodeListId and z.SystemLanguageId = @SystemLanguageId 
where a.Category not in ('ProviderPaymentMethod', 'PersonPaymentMethod', 'DescrCategory', 'MsgDeliveryMethod', 'DeviceType', 'RequestStatus', 'RequestProviderCallStatus', 'InterviewProviderCallStatus', 'ProviderStatus', 'InterviewStatus') and z.Id is null


select * from CodeListY