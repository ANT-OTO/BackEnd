declare @CallInPhoneNumber nvarchar(128) = '+13522784558',
	@CallOutPhoneNumber nvarchar(128) = '+13522784558',
	@IntervalSec1 int = 3,
	@DTMFDigits1 nvarchar(64) = '1234',
	@IntervalSec2 int = 7,
	@DTMFDigits2 nvarchar(64) = '567',
	@IntervalSec3 int = NULL,
	@DTMFDigits3 nvarchar(64) = NULL,
	@IntervalSec4 int = NULL,
	@DTMFDigits4 nvarchar(64) = NULL,
	@pTime datetime = getutcdate()
insert into WEYI.[dbo].[SimpleRedirectPhoneNumber]
(
	[CallInPhoneNumber],
	[CallOutPhoneNumber],
	[IntervalSec1],
	[DTMFDigits1],
	[IntervalSec2],
	[DTMFDigits2],
	[IntervalSec3],
	[DTMFDigits3],
	[IntervalSec4],
	[DTMFDigits4],
	[CreateDate],
	[LastUpdate]
)
select @CallInPhoneNumber as [CallInPhoneNumber],
	   @CallOutPhoneNumber as [CallOutPhoneNumber],
	   @IntervalSec1 as [IntervalSec1],
	   @DTMFDigits1 as [DTMFDigits1],
	   @IntervalSec2 as [IntervalSec2],
	   @DTMFDigits2 as [DTMFDigits2],
	   @IntervalSec3 as [IntervalSec3],
	   @DTMFDigits3 as [DTMFDigits3],
	   @IntervalSec4 as [IntervalSec4],
	   @DTMFDigits4 as [DTMFDigits4],
	   @pTime as [CreateDate],
	   @pTime as [LastUpdate]

select * from [SimpleRedirectPhoneNumber]