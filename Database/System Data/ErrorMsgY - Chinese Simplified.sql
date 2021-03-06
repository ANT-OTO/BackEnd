--select * from [ErrorMsg]
--select * from [ErrorMsgY]
--select * from SystemLanguage


declare @SystemLanguageId int
select @SystemLanguageId = Id
--select *
from SystemLanguage where [Name] = N'简体中文'

select * from ErrorMsg a left join ErrorMsgY z on a.Id = z.ErrorMsgId and z.SystemLanguageId = @SystemLanguageId
where z.Id is null and a.Id not in (32,40,41,66, 72)

declare @Tbl as Table
(
	[ErrorMsgId] [int] NOT NULL,
	[SystemLanguageId] [int] NOT NULL,
	[Msg] [nvarchar](384) NOT NULL
)


insert into @Tbl
(ErrorMsgId, Msg, SystemLanguageId)
select a.*, @SystemLanguageId
from (
select a.Id as ErrorMsgId,
	case 
		--when a.Id = 1 then N'系统错误'
		--when a.Id = 2 then N'需要登录'
		--when a.Id = 3 then N'邮箱已被注册'
		--when a.Id = 4 then N'电子邮箱不合要求'
		--when a.Id = 5 then N'手机号码不合要求'
		--when a.Id = 6 then N'选择的地区不合要求'
		--when a.Id = 7 then N'系统语言不合要求'
		--when a.Id = 8 then N'手机号已被注册'
		--when a.Id = 9 then N'密码需要6至15个字符间'
		--when a.Id = 10 then N'记录未找到'
		--when a.Id = 11 then N'名字不合要求'
		--when a.Id = 12 then N'输入不合要求'
		--when a.Id = 13 then N'输入验证码不匹配'
		--when a.Id = 14 then N'已经验证过了'
		--when a.Id = 15 then N'验证码过期了'
		--when a.Id = 16 then N'图像格式不对'
		--when a.Id = 17 then N'文件是必需的'
		--when a.Id = 18 then N'没有图片'
		--when a.Id = 19 then N'请输入证书信息'
		--when a.Id = 20 then N'登录失败'

		--when a.Id = 21 then N'非法呼叫'
		--when a.Id = 22 then N'确认没有成功'
		--when a.Id = 23 then N'启动通话失败'
		--when a.Id = 24 then N'没有准备好'
		--when a.Id = 25 then N'请选择你需要帮助的语言'
		--when a.Id = 26 then N'要求SSL'
		--when a.Id = 27 then N'清除服务请求没成功'
		--when a.Id = 28 then N'取消服务请求没成功'
		--when a.Id = 29 then N'结束时间需在今日之后'
		--when a.Id = 30 then N'关键字无效'
		--when a.Id = 31 then N'起始时间需在结束时间之前'

		--when a.Id = 33 then N'不再支持'
		--when a.Id = 34 then N'图片没找见'

		--when a.Id = 35 then N'非法呼叫1'
		--when a.Id = 36 then N'非法呼叫2'
		--when a.Id = 37 then N'非法呼叫3'

		--when a.Id = 38 then N'权限不够'

		--when a.Id = 42 then N'请选择工作类型'
		--when a.Id = 43 then N'时间段不对'
		--when a.Id = 44 then N'起始时间不对'

		--when a.Id = 65 then N'验证号码不对'
		--when a.Id = 67 then N'此应用目前需要邀请函。请收到邀请函后再注册。'
		--when a.Id = 68 then N'促销号码不对'
		--when a.Id = 69 then N'请输入电子邮箱和手机号'
		--when a.Id = 70 then N'没成功'
		--when a.Id = 71 then N'验证号码不对'

		--when a.Id = 73 then N'请输入国家地区区号，比如 +1 （美国）'
		--when a.Id = 74 then N'请输入您的手机号'
		--when a.Id = 75 then N'请输入您的电子邮箱'
		--when a.Id = 76 then N'国家地区区号不对'
		when a.Id = 77 then N'请输入手机号'
		when a.Id = 78 then N'请输入国家地区区号，比如 +1 （美国）'
		when a.Id = 79 then N'请输入您的电子邮箱'
		when a.Id = 82 then N'图像识别没成功'
		when a.Id = 83 then N'语音识别没成功'
		when a.Id = 84 then N'脸书账号已经注册'
		when a.Id = 85 then N'机器翻译没成功'
		when a.Id = 86 then N'目前我们暂时不提供对所选语言的真人翻译'
	else N''
	end as Msg
from [ErrorMsg] a
) a 
where a.Msg <> ''


insert into ErrorMsgY
(ErrorMsgId, Msg, SystemLanguageId, CreateDate)
select a.ErrorMsgId, a.Msg, a.SystemLanguageId, GETDATE() as CreateDate
from @Tbl a left join [ErrorMsgY] z on a.ErrorMsgId = z.ErrorMsgId and z.SystemLanguageId = @SystemLanguageId 
where z.Id is null

update a
set a.Msg = b.Msg
--select *
from ErrorMsgY a inner join @Tbl b on a.ErrorMsgId = b.ErrorMsgId and a.SystemLanguageId = b.SystemLanguageId
where a.Msg <> b.Msg

--select * from @Tbl

delete 
--select * from
ErrorMsgY where SystemLanguageId = @SystemLanguageId and ErrorMsgId not in (select ErrorMsgId from @Tbl)

select * from ErrorMsg a left join ErrorMsgY z on a.Id = z.ErrorMsgId and z.SystemLanguageId = @SystemLanguageId
where z.Id is null and a.Id not in (32,40,41,66, 72)
