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
		case when a.AppName = 'Client_Android' and a.ItemKey = '1' then N'<!DOCTYPE HTML>
<HTML>
<body>

<h2>常见问题解答</h2>

<ol type="1">
  <li>小芳翻译可否离线使用？</strong></li>
  <br />
  <div>
<table><tr><td style="width:20px;" valign="top">答：</td><td>目前的功能模块只支持在线使用。</td></tr></table>
</div>

  <br /><br />
  <li>登陆软件需要较长时间，是什么原因？</strong></li>
  <br />
  <div>
<table><tr><td style="width:20px;" valign="top">答：</td><td>初次使用时，系统有新的加载项，需耐心等待。此外，可能因网络信号较弱导致。</td></tr></table>
  </div>

  <br /><br />
  <li>“智能翻译”、“真人翻译”和“专员翻译”的区别在哪里？</strong></li>
  <br />
  <div>
<table><tr><td style="width:20px;" valign="top">答：</td><td>“智能翻译”是由庞大的数据库支撑的机器翻译，能够满足大部分用户的基本翻译需求。</td></tr>
<tr><td colspan="2">&nbsp;</td></tr>
<tr><td>&nbsp;</td><td>“真人翻译”是由专业的翻译人员对用户提出的问题进行回答，满足客户较高层次的翻译需求。</td></tr>
<tr><td colspan="2">&nbsp;</td></tr>
<tr><td>&nbsp;</td><td>“专员翻译”是您随身的私人翻译，遇到语言问题呼叫专员翻译，能够为您提供即时的一对一翻译服务。</td></tr></table>
  </div>

  <br /><br />
  <li>“真人翻译”为什么不能发布长篇文章？</strong></li>
  <br />
  <div>
<table><tr><td style="width:20px;" valign="top">答：</td><td>基于功能定位和方便翻译人员操作，我们将真人翻译需求的字数限定为140字以内。</td></tr></table>
  </div>

  <br /><br />
  <li>“专员翻译”的服务时段是什么？</strong></li>
  <br />
  <div>
<table><tr><td style="width:20px;" valign="top">答：</td><td>我们的专员翻译可以24小时在线，随时为您提供翻译服务。</td></tr></table>
  </div>

  <br /><br />
  <li>“真人翻译”、“专员翻译”可以翻译哪些语种？</strong></li>
  <br />
  <div>
<table><tr><td style="width:20px;" valign="top">答：</td><td>目前已开通中文对英语、日语、韩语、法语、西班牙语的互译功能，将来会不断增加新的语种，敬请期待。</td></tr></table>
  </div>

  <br /><br />
  <li>翻译的收费标准是什么？</strong></li>
  <br />
  <div>
<table><tr><td style="width:20px;" valign="top">答：</td><td>目前，我们完全免费为用户提供翻译服务。</td></tr></table>
  </div>

  <br /><br />
  <li>国外使用手机流量费用高怎么办？</strong></li>
  <br />
  <div>
<table><tr><td style="width:20px;" valign="top">答：</td><td>如果流量需求较多，建议租用随身wifi，可供多人同时使用，解决手机流量的问题。</td></tr></table>
  </div>

  <br /><br />
  <li>如果对翻译质量不满怎么办？</strong></li>
  <br />
  <div>
<table><tr><td style="width:20px;" valign="top">答：</td><td>请在用户反馈板块向我们提出您的宝贵意见，我们会不断完善和改进，为您提供更加优质的服务。</td></tr></table>
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
select a.Id from FAQY a inner join FAQ b on a.FAQId = b.Id and b.AppName = 'Client_Android'
where (SystemLanguageId = @SystemLanguageId and FAQId not in (select FAQId from @TblFAQY))
  or ( FAQId in (select FAQId from @TblFAQY) and SystemLanguageId = 1) 
 ) 

select b.AppName, b.ItemKey, isnull(a.Content, b.Content) as Content, b.IsLink, b.ParentKey, b.Level, b.DisplayOrder
from [FAQ] b left join [FAQY] a on a.FAQId = b.Id
where isnull(a.SystemLanguageId, @SystemLanguageId) = @SystemLanguageId and b.AppName = 'Client_Android'
order by b.[Level], b.ItemKey