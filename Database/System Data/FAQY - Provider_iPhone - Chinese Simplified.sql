--select * from [FAQ]
--select * from [FAQY]
--select * from SystemLanguage


declare @SystemLanguageId int
select @SystemLanguageId = Id
--select *
from SystemLanguage where [Name] = N'简体中文'

declare @TblFAQY as Table
(
	[FAQId] [int] NOT NULL,
	[SystemLanguageId] [int] NOT NULL,
	[Content] [nvarchar](max) NOT NULL
)

delete @TblFAQY

insert into @TblFAQY
(FAQId, SystemLanguageId, [Content])
select a.FAQId, @SystemLanguageId, a.[Content]
from (
	select a.*
	from (
	select a.Id as FAQId,
		case when a.AppName = 'Provider_iPhone' and a.ItemKey = '1' then N'下载和安装'
			when a.AppName = 'Provider_iPhone' and a.ItemKey = '2' then N'注册和登录'
			when a.AppName = 'Provider_iPhone' and a.ItemKey = '3' then N'账号设置'
			when a.AppName = 'Provider_iPhone' and a.ItemKey = '4' then N'服务通讯'
			when a.AppName = 'Provider_iPhone' and a.ItemKey = '1.1' then N'<!DOCTYPE HTML>
<HTML>
<body>

<h2>下载和安装</h2>

<ol type="1">
  <li><strong>如何下载维译译者?</strong></li>
  <div>
<ol type="a">
  <li>在你的手机上搜索维译译者</li>
  <li>下载安装维译译者应用</li>
</ol>  
<br />
  </div>

  <li><strong>维译译者支持什么样的操作系统？</strong></li>
<div>
我们现在iOS设备上支持iOS 8.0 或更高的版本。
<br />
<br />
</div>

  <li><strong>维译译者支持什么样的手机？</strong></li>
<div>
我们针对iPhone 4s,5,5s,6,and 6plus做了用户界面的优化. 
<br />
<br />
</div>
</ol>  

</body>
</HTML>
'
			when a.AppName = 'Provider_iPhone' and a.ItemKey = '2.1' then N'<!DOCTYPE HTML>
<HTML>
<body>

<h2>注册和登录</h2>

<ol type="1">
  <li><strong>如何注册维译译者?</strong></li>
  <div>
当您进入注册页面，只需点击下方注册按钮，并按照要求步骤， 或者您也可以在网页上完成注册。
<br />
<br />
  </div>

  <li><strong>如何登陆维译译者?</strong></li>
<div>
当您已经有维译译者账号后，您可以进入登陆页面，并填写您的邮箱及密码进行登录
<br />
<br />
</div>

  <li><strong>如果我忘记密码怎么办</strong></li>
<div>
并且点击登陆页面中的忘记密码蓝色按钮，并且根据要求步骤进行找回 
<br />
<br />
</div>

  <li><strong>为什么我在注册或登录中卡住了？</strong></li>
<div>
请检查您的网络，因为我们的软件依赖于网络的交互，您也可以在网页上完成注册。
<br />
<br />
</div>
</ol>  

</body>
</HTML>'
when a.AppName = 'Provider_iPhone' and a.ItemKey = '3.1' then N'资料设置'
when a.AppName = 'Provider_iPhone' and a.ItemKey = '3.2' then N'隐私设置'
when a.AppName = 'Provider_iPhone' and a.ItemKey = '3.1.1' then N'<!DOCTYPE HTML>
<HTML>
<body>

<h2>资料设置</h2>

<ol type="1">
  <li><strong>我可以设置些什么？</strong></li>
  <div>
您可以随时设置您的头像，名字，密码，您服务的项目以及您的工作日程安排
<br />
<br />
  </div>

  <li><strong>我怎么更改我的头像？</strong></li>
<div>
当您登陆后，点击设置的按钮，然后点击进入个人资料栏，点击头像栏并选择上传头像的方式即可更改头像
<br />
<br />
</div>

</ol>  

</body>
</HTML>'
when a.AppName = 'Provider_iPhone' and a.ItemKey = '3.2.1' then N'<!DOCTYPE HTML>
<HTML>
<body>

<h2>隐私设置</h2>

<ol type="1">
  <li><strong>我怎么更改我的密码？</strong></li>
  <div>
当您登陆后，可以点击设置按钮，进入个人资料栏后点击更改密码，然后重新设置密码
<br />
<br />
  </div>


</ol>  

</body>
</HTML>'
when a.AppName = 'Provider_iPhone' and a.ItemKey = '4.1' then N'<!DOCTYPE HTML>
<HTML>
<body>

<h2>服务通信</h2>

<ol type="1">
  <li><strong>我如何拿到翻译任务？</strong></li>
  <div>
在您登陆后，如果有合适您的翻译任务并且允许维译译者通知设置，我们会自动推送给您，如果您没有开启通信设置，您会在工作面板页看到翻译任务。您只需点击接受按钮接受任务。
<br />
<br />
  </div>

  <li><strong>我如何发送图片给用户</strong></li>
<div>
发送图片功能属于文本信息里，如果用户开启了文本信息服务，您可以根据您的需要，发送图片
<br />
<br />
</div>

  <li><strong>我如何发送语音信息给用户</strong></li>
<div>
发送语音信息功能属于文本信息里，如果用户开启了文本信息服务，您可以根据您的需要，发送语音信息
<br />
<br />
</div>

  <li><strong>我如何得知服务结束？</strong></li>
<div>
当用户觉得得到了他／她想要的服务或直接结束服务，我们的软件会自动将您跳转到评价页面
<br />
<br />
</div>

  <li><strong>我如何评价我刚刚服务过的用户？</strong></li>
<div>
当您结束服务后，我们软件会让您评价您刚才服务过的用户以及我们的软件
<br />
<br />
</div>
</ol>  

</body>
</HTML>'

		else N''
		end as [Content]
	--select *
	from [FAQ] a
	) a where a.[Content] <> ''

	
) a 


insert into [FAQY]
(FAQId, SystemLanguageId, [Content])
select a.* 
from @TblFAQY a left join [FAQY] z on a.FAQId = z.FAQId and z.SystemLanguageId = @SystemLanguageId 
where z.Id is null

update a
set a.Content = b.Content
from [FAQY] a inner join @TblFAQY b on a.FAQId = b.FAQId and a.SystemLanguageId = b.SystemLanguageId
where a.SystemLanguageId = @SystemLanguageId 

--select * from @TblFAQY
--select * from FAQY where SystemLanguageId = @SystemLanguageId 


delete [FAQY] 
where Id in (
select a.Id from FAQY a inner join FAQ b on a.FAQId = b.Id and b.AppName = 'Provider_iPhone'
where (SystemLanguageId = @SystemLanguageId and FAQId not in (select FAQId from @TblFAQY))
  or ( FAQId in (select FAQId from @TblFAQY) and SystemLanguageId = 1) 
 ) 

select b.AppName, b.ItemKey, isnull(a.Content, b.Content) as Content, b.IsLink, b.ParentKey, b.Level, b.DisplayOrder
from [FAQ] b left join [FAQY] a on a.FAQId = b.Id
where isnull(a.SystemLanguageId, @SystemLanguageId) = @SystemLanguageId
order by b.AppName, b.[Level], b.ItemKey