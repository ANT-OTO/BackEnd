--select * from FAQ

declare @AppName varchar(32) = 'Provider_iPhone'

declare @TblCode as Table
(
	[ItemKey] [varchar](16) NOT NULL,

	[Content] [nvarchar](max) NOT NULL,			
	
	[IsLink] [bit] NOT NULL,
	
	[ParentKey] [varchar](16) NULL,
	[Level] [int] NOT NULL,
	
	[DisplayOrder] [varchar](8) NOT NULL
)	



------------------------------------- Begin  ------------------------------------- 
--delete [FAQ] where Category = 'InterviewStatus'

delete @TblCode

insert into @TblCode	
([ItemKey], [Content], [IsLink], [ParentKey], [Level], [DisplayOrder])
select a.*
from (
	select '1' as [ItemKey], 'Download and Installation' as [Content], 1 as [IsLink], null as [ParentKey], 1 as [Level], '001' as [DisplayOrder]

	UNION 
	
	select '1.1' as [ItemKey], '<!DOCTYPE HTML>
<HTML>
<body>

<h2>Download and Installation</h2>

<ol type="1">
  <li><strong>How do I download WeyiProvider?</strong></li>
  <div>
<ol type="a">
  <li>On your device, search for WEYIProvider on the App Store.</li>
  <li>Tap "GET" to the right of the application icon, and follow the steps to download.</li>
</ol>  
<br />
  </div>

  <li><strong>What operating system does WeyiProvider support?</strong></li>
<div>
Currently, our application supports iOS 8.0 or higher on iOS devices.
<br />
<br />
</div>

  <li><strong>What kind of device is good for WeyiProvider?</strong></li>
<div>
Our application can run on the iPhone 4S, 5, 5S, 6, and 6 Plus.
<br />
<br />
</div>
</ol>  

</body>
</HTML>
' as [Content], 0 as [IsLink], '1' as [ParentKey], 2 as [Level], '001' as [DisplayOrder]

	UNION 
	
	select '2' as [ItemKey], 'Login and Registration' as [Content], 1 as [IsLink], null as [ParentKey], 1 as [Level], '002' as [DisplayOrder]

	UNION 
	
	select '2.1' as [ItemKey], '<!DOCTYPE HTML>
<HTML>
<body>

<h2>Login and Registration</h2>

<ol type="1">
  <li><strong>How do I register for WeyiProvider?</strong></li>
  <div>
On the register page, tap the sign up button and simply follow the given steps.
<br />
<br />
  </div>

  <li><strong>How do I log in to WeyiProvider?</strong></li>
<div>
On the sign-in page, enter your email and password into the corresponding boxes and tap the sign-in button.
<br />
<br />
</div>

  <li><strong>What if I forgot my password?</strong></li>
<div>
On the sign-in page, tap the "Forgot password?" link and follow the steps to reset your password.
<br />
<br />
</div>

  <li><strong>Why am I stuck in register/sign in process?</strong></li>
<div>
Please check your Internet settings and try again, since our application relies on Internet access.Or you can finish your set up in our webpage.
<br />
<br />
</div>
</ol>  

</body>
</HTML>
' as [Content], 0 as [IsLink], '2' as [ParentKey], 2 as [Level], '001' as [DisplayOrder]

	UNION 
	
	select '3' as [ItemKey], 'Account Setting' as [Content], 1 as [IsLink], null as [ParentKey], 1 as [Level], '003' as [DisplayOrder]

	UNION 
	
	select '3.1' as [ItemKey], 'Profile Setting' as [Content], 1 as [IsLink], '3' as [ParentKey], 2 as [Level], '001' as [DisplayOrder]

	UNION 
	
	select '3.1.1' as [ItemKey], '<!DOCTYPE HTML>
<HTML>
<body>

<h2>Profile Setting</h2>

<ol type="1">
  <li><strong>What can I change?</strong></li>
  <div>
You can change your profile picture, name, password, and the list of languages you can speak. 
<br />
<br />
  </div>

  <li><strong>How do I change my profile picture?</strong></li>
<div>
 On the home screen, tap the setting icon on the upper-right corner. Tap the edit icon on the first row and then tap on your picture. You can select either Camera or Gallery to take a new photo or use an existing photo.
<br />
<br />
</div>

</ol>  

</body>
</HTML>
' as [Content], 0 as [IsLink], '3.1' as [ParentKey], 3 as [Level], '001' as [DisplayOrder]

	UNION 
	
	select '3.2' as [ItemKey], 'Security Setting' as [Content], 1 as [IsLink], '3' as [ParentKey], 2 as [Level], '002' as [DisplayOrder]

UNION 
	
	select '3.2.1' as [ItemKey], '<!DOCTYPE HTML>
<HTML>
<body>

<h2>Security Setting</h2>

<ol type="1">
  <li><strong>Can I change my password?</strong></li>
  <div>
Yes. On the home screen, tap the setting icon on the upper-right corner. Tap the "My Accounts" on the first row and then tap "Reset password".
<br />
<br />
  </div>


</ol>  

</body>
</HTML>
' as [Content], 0 as [IsLink], '3.2' as [ParentKey], 3 as [Level], '001' as [DisplayOrder]

	UNION 
	
	select '4' as [ItemKey], 'Service Communication' as [Content], 1 as [IsLink], null as [ParentKey], 1 as [Level], '004' as [DisplayOrder]

	UNION 
	
	select '4.1' as [ItemKey], '<!DOCTYPE HTML>
<HTML>
<body>

<h2>Service Communication</h2>

<ol type="1">
  <li><strong>How can I start to take tasks from weyi users?</strong></li>
  <div>
Make sure you set a schedule when you are approved at least in one service.When user request is created, we will push a notification to your phone if you are not in our app, or you can see the task on homepage. You can simply tap accept to take a customer.
<br />
<br />
  </div>

  <li><strong>How can I send picture to user?</strong></li>
<div>
Picture sending is available when user starts a text session. You can send whatever you think is helpful to describe your answer on service. 
<br />
<br />
</div>

  <li><strong>How can I send an audio message to translation provider?</strong></li>
<div>
Audio memo sending is available when user starts a text session. You can send whatever you think is helpful to describe your answer on service. 
<br />
<br />
</div>

  <li><strong>How can I finish a service?</strong></li>
<div>
When user thinks he/she has already finished his/her service ,he/she will finish the service , and our app will automatically take you to evaluation page after that.
<br />
<br />
</div>

  <li><strong>How can I leave evaluation to the customer I just served?</strong></li>
<div>
After the service session is completed, the app will ask you to rate the quality of the translation provider and session.
<br />
<br />
</div>
</ol>  

</body>
</HTML>' as [Content], 0 as [IsLink], '4' as [ParentKey], 2 as [Level], '001' as [DisplayOrder]

) a 

insert into [FAQ]
([AppName], [ItemKey], [Content], [IsLink], [ParentKey], [Level], [DisplayOrder])
select @AppName, a.*
from @TblCode a left join  [FAQ] z on @AppName = z.AppName and a.[ItemKey] = z.[ItemKey]
where z.Id is null

update a
set a.[Content] = b.[Content], a.[IsLink] = b.[IsLink], a.[ParentKey] = b.[ParentKey], a.[Level] = b.[Level], a.[DisplayOrder] = b.[DisplayOrder]
from [FAQ] a inner join  @TblCode b on a.AppName = @AppName and a.[ItemKey] = b.[ItemKey]

delete 
--select * from
FAQY where FAQId in (select Id from FAQ where AppName = @AppName and [ItemKey] not in (select [ItemKey] from @TblCode))

delete FAQ where AppName = @AppName and [ItemKey] not in (select [ItemKey] from @TblCode)

select * from FAQ 


------------------------------------- End  ------------------------------------- 


