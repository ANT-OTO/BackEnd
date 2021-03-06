declare @pTime datetime = getutcdate()

delete
from dbo.[SFExpressOpCodeReference]

insert into [dbo].[SFExpressOpCodeReference]
(
	[OpCode],
	[EnglishDisplay],
	[ChineseDisplay],
	[CreateDate],
	[LastUpdate],
	[LastUpdateBy],
	[LastUpdateByType]
)
select a.OpCode, a.EngLishDisplay, a.ChineseDisplay, @pTime, @pTime, 1, 1
from 
(
SELECT '14' as OpCode, N'货件已放行' as ChineseDisplay, N'Clearance Process Completed' as EngLishDisplay
UNION ALL SELECT '15' as OpCode, N'海关查验' as ChineseDisplay, N'Clearance In Progress' as EngLishDisplay
UNION ALL SELECT '16' as OpCode, N'正式报关待申报' as ChineseDisplay, N'Pending Formal Entry' as EngLishDisplay
UNION ALL SELECT '17' as OpCode, N'海关待查 (Obsoleted)' as ChineseDisplay, N'Pending Customs Inspection' as EngLishDisplay
UNION ALL SELECT '18' as OpCode, N'海关扣件' as ChineseDisplay, N'Clearance Delay: [Reason]' as EngLishDisplay
UNION ALL SELECT '30' as OpCode, N'装车' as ChineseDisplay, N'Shipment DEPART from + Location Code = Service Centre & Gateway only' as EngLishDisplay
UNION ALL SELECT '31' as OpCode, N'卸车' as ChineseDisplay, N'Shipment ARRIVE at + Location Code = Service Centre & Gateway only' as EngLishDisplay
UNION ALL SELECT '33' as OpCode, N'滞留件入仓' as ChineseDisplay, N'Shipment undelivered, Returned to service center' as EngLishDisplay
UNION ALL SELECT '34' as OpCode, N'滞留件出仓' as ChineseDisplay, N'Detained shipments Out for delivery' as EngLishDisplay
UNION ALL SELECT '36' as OpCode, N'封车' as ChineseDisplay, N'Vihecle seal. (Start to next point)' as EngLishDisplay
UNION ALL SELECT '43' as OpCode, N'收件入仓' as ChineseDisplay, N'Shipment arrived at service center after pick-up' as EngLishDisplay
UNION ALL SELECT '44' as OpCode, N'派件出仓(二程接驳派件)(1：享受 null：不享受)' as ChineseDisplay, N'Handover to delivery agent;
Out for delivery(Other)' as EngLishDisplay
UNION ALL SELECT '47' as OpCode, N'二程接驳派件' as ChineseDisplay, N'Out for delivery' as EngLishDisplay
UNION ALL SELECT '50' as OpCode, N'一票一件' as ChineseDisplay, N'Pick-up' as EngLishDisplay
UNION ALL SELECT '51' as OpCode, N'一票多件的子件' as ChineseDisplay, N'Pick-up' as EngLishDisplay
UNION ALL SELECT '66' as OpCode, N'批量滞留' as ChineseDisplay, N'Batch on hold(customs)' as EngLishDisplay
UNION ALL SELECT '70' as OpCode, N'问题件' as ChineseDisplay, N'Shipment Exception' as EngLishDisplay
UNION ALL SELECT '77' as OpCode, N'中转滞留' as ChineseDisplay, N'On hold at sort facility' as EngLishDisplay
UNION ALL SELECT '80' as OpCode, N'派件扫描' as ChineseDisplay, N'Delivered or signed after receiving
Delivered' as EngLishDisplay
UNION ALL SELECT '99' as OpCode, N'转寄/退回' as ChineseDisplay, N'Forward/Return' as EngLishDisplay
UNION ALL SELECT '122' as OpCode, N'加时区域派件出仓' as ChineseDisplay, N'Out for delivery from remote warehouse' as EngLishDisplay
UNION ALL SELECT '123' as OpCode, N'便利店出仓' as ChineseDisplay, N'Out for delivery from convience store' as EngLishDisplay
UNION ALL SELECT '125' as OpCode, N'到达快递柜' as ChineseDisplay, N'Delivery to SF locker as requested' as EngLishDisplay
UNION ALL SELECT '126' as OpCode, N'快递员取消派件将快件取出丰巢' as ChineseDisplay, N'Retrieve from locker for delivery canceling ' as EngLishDisplay
UNION ALL SELECT '130' as OpCode, N'便利店交接' as ChineseDisplay, N'Handover to SF appointed store' as EngLishDisplay
UNION ALL SELECT '204' as OpCode, N'派件交接/出仓' as ChineseDisplay, N'Out for delivery' as EngLishDisplay
UNION ALL SELECT '208' as OpCode, N'代理交接' as ChineseDisplay, N'Agent Handover' as EngLishDisplay
UNION ALL SELECT '604' as OpCode, N'清关中' as ChineseDisplay, N'Under customs clearance' as EngLishDisplay
UNION ALL SELECT '605' as OpCode, N'运力抵达口岸' as ChineseDisplay, N'Arrived at Gateway' as EngLishDisplay
UNION ALL SELECT '607' as OpCode, N'代理收件' as ChineseDisplay, N'Transferring to [destination city]' as EngLishDisplay
UNION ALL SELECT '611' as OpCode, N'理货异常' as ChineseDisplay, N'Shipment Exception, Please contact SF Customer Services Hotline' as EngLishDisplay
UNION ALL SELECT '612' as OpCode, N'暂存口岸待申报' as ChineseDisplay, N'Pending for Customs declaration' as EngLishDisplay
UNION ALL SELECT '613' as OpCode, N'海关放行待补税' as ChineseDisplay, N'Pending duty/tax payment' as EngLishDisplay
UNION ALL SELECT '619' as OpCode, N'检疫查验' as ChineseDisplay, N'Quarantine Inspection' as EngLishDisplay
UNION ALL SELECT '620' as OpCode, N'检疫待查' as ChineseDisplay, N'Pending Quarantine Inspection' as EngLishDisplay
UNION ALL SELECT '621' as OpCode, N'检疫扣件' as ChineseDisplay, N'Detained Quarantine' as EngLishDisplay
UNION ALL SELECT '626' as OpCode, N'到转第三方快递' as ChineseDisplay, N'Forward to third party express to deliver' as EngLishDisplay
UNION ALL SELECT '634' as OpCode, N'港澳台二程接驳派件' as ChineseDisplay, N'Out for delivery' as EngLishDisplay
UNION ALL SELECT '642' as OpCode, N'门市/顺丰站快件上架' as ChineseDisplay, N'Retail Parcel Racking' as EngLishDisplay
UNION ALL SELECT '648' as OpCode, N'新旧运单关联' as ChineseDisplay, N'New-old Waybill Relevance(For return or forward)' as EngLishDisplay
UNION ALL SELECT '649' as OpCode, N'代理转运' as ChineseDisplay, N'In Transit under agent service' as EngLishDisplay
UNION ALL SELECT '657' as OpCode, N'合作点从顺丰交接' as ChineseDisplay, N'Handover to authenticated party' as EngLishDisplay
UNION ALL SELECT '658' as OpCode, N'合作点已派件' as ChineseDisplay, N'Delivered by authenticated party' as EngLishDisplay
) a


select * from [SFExpressOpCodeReference]
